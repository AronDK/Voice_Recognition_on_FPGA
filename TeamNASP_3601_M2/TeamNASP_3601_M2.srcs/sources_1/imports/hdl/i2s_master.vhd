library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library work;
use work.aud_param.all;

-- I2S master interface for the SPH0645LM4H MEMs mic
-- useful links:
--   - https://diyi0t.com/i2s-sound-tutorial-for-esp32/
--   - https://cdn-learn.adafruit.com/downloads/pdf/adafruit-i2s-mems-q1microphone-breakout.pdf
--   - https://cdn-shop.adafruit.com/product-files/3421/i2S+Datasheet.PDF

entity i2s_master is
    generic (
        DATA_WIDTH : natural := 32;
        PCM_PRECISION : natural := 18
    );
    port (
        clk             : in  std_logic;
        clk_1           : in  std_logic; -- 49.06MHz

        -- I2S interface to MEMs mic
        i2s_lrcl        : out std_logic;    -- left/right clk (word sel): 0 = left, 1 = right
        i2s_dout        : in  std_logic;    -- serial data: payload, msb first
        i2s_bclk        : out std_logic;    -- Bit clock: freq = sample rate * bits per channel * number of channels
                                            -- (should run at 2-4MHz). Changes when the next bit is ready.
        -- FIFO interface to MEMs mic
        fifo_din        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
        fifo_w_stb      : out std_logic;    -- Write strobe: 1 = ready to write, 0 = busy
        fifo_full       : in  std_logic     -- 0 = not full, 1 = full
    );
end i2s_master;

architecture Behavioral of i2s_master is
    --put your signals here
    signal bclk, prev_bclk: std_ulogic := '0'; -- Bclk signal, start low
    signal word, prev_word: std_ulogic := '1'; -- WS/lrcl, start high
    signal ws_counter: unsigned (5 downto 0) := "000000"; -- counter for 4 bytes / 32 bclk clock cyles
    signal bclk_counter: unsigned (4 downto 0) := "00000"; -- counter for 22 clk_1 cycles
    signal readable: boolean := true; -- If false, in 32-64 bit range, true if in 0-32 bit range (first 3 states)
    signal databuffer : std_logic_vector (DATA_WIDTH - 1 downto 0) := (others => '0'); -- Write to databuffer, then await rising edge of clk signal to sync handshake
    signal bit_count: integer := 31; -- Bitcount for shift register, counts down on every bclk so MSB is leftmost bit for FIFO Bufffer
    signal fsm_state: integer := 0; -- State counter
    
    component fifo_handshake is
        Port( fifo_full, i2s_dout: IN std_logic;
          bit_count, fsm_state: IN integer;
          readable: in boolean;
          fifo_w_stb: OUT std_logic;
          fifo_din: OUT std_logic_vector(31 downto 0));
    end component;
    
begin
    -----------------------------------------------------------------------
    -- hint: write code for bclk clock generator:
    -----------------------------------------------------------------------
    --implementation...:
    
    
    process(clk, bclk, readable) -- Clk_1 at 49.06 MHZ, count to 11 to make ~4 MHZ Bclk signal
    begin
        if rising_edge(clk) then 
            case bclk_counter is
                when "10110" =>
                    prev_bclk <= bclk;
                    bclk <= not(bclk);
                    bclk_counter <= "00000";
                    bit_count <= bit_count - 1; -- Decrements every bclk
                    
                    if ws_counter = "100000" then 
                        prev_word <= word;
                        word <= not(word);
                        ws_counter <= "000000";
                     else
                        ws_counter  <= ws_counter + 1;
                     end if; 
              
                when others =>
                    bclk_counter <= bclk_counter + 1;
            end case;
            if readable = false or word = '1'  then -- Not readable, will reset bit_count to 17 to represent head of bit string
                bit_count <= 31;
            end if;
       end if;
        i2s_lrcl <= word;
        i2s_bclk <= bclk; -- Assign bclk
    end process;
    ------------------------------------------------------------------------
    -- hint: write code for I2S FSM
    ------------------------------------------------------------------------
    --implementation...:
    process(word, bit_count, clk)
    begin
       if bit_count < 14 then -- 18-bit data stream captured, now onto 18-32 bit section of data stream
                    fsm_state <= 2;
       elsif word = '0' and prev_word = '1' then -- Negative edge triggered flip flop to state 1 - falling edge always in 0-32 bit range
                readable <= true; -- In state 1, can read 18 bit bus
                fsm_state <= 1;        
       elsif word = '1' and prev_word = '0' then -- Rising edge always on 32-64 bit range
                fsm_state <= 0; -- Idle state
                readable <= false; -- Do not read R channel data
            end if;
    end process;
    --------------------------------------------------
    -- hint: write code for FIFO data handshake
    --------------------------------------------------
    -- hint: Useful link: https://encyclopedia2.thefreedictionary.com/Hand+shake+signal
    --implementation...:
    

    -- I2S FSM and FIFO Data Handshake
       f0: fifo_handshake port map(fifo_full, i2s_dout, bit_count, fsm_state, readable, fifo_w_stb, fifo_din);
end Behavioral;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity fifo_handshake is
    Port( fifo_full, i2s_dout: IN std_logic;
          bit_count, fsm_state: IN integer;
          readable: in boolean;
          fifo_w_stb: OUT std_logic;
          fifo_din: OUT std_logic_vector(31 downto 0));
end fifo_handshake;

architecture behavioural of fifo_handshake is
begin
    process(fsm_state, bit_count)
    begin            
        fifo_w_stb <= '0';
        case fsm_state is
            when 0 =>  -- Idle
                if readable = false then -- Only flush if readable
                    fifo_w_stb <= '0'; -- Fifo_Din will be flushed, ready to add to buffer
                end if;
            when 1 =>  -- 18-bit data stream capture
                fifo_din(bit_count) <= i2s_dout; -- clk cycle, sync with handshake, send data to Fifo buffer    
            when 2 =>  -- Send bits to FIFO bus
                if fifo_full = '0' then -- Fifo buffer says not full
                    fifo_w_stb <= '1'; -- Drive Fifo buffer with ready signal
                end if;
            when others => -- reset fifo_w_stb
                fifo_w_stb <= '0';
        end case;
    end process;
end behavioural;
