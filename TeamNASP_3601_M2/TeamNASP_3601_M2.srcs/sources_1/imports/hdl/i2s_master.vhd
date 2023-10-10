library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

library work;
use work.aud_param.all;

-- I2S master interface for the SPH0645LM4H MEMs mic
-- useful links:
--   - https://diyi0t.com/i2s-sound-tutorial-for-esp32/
--   - https://cdn-learn.adafruit.com/downloads/pdf/adafruit-i2s-mems-microphone-breakout.pdf
--   - https://cdn-shop.adafruit.com/product-files/3421/i2S+Datasheet.PDF

entity i2s_master is
    generic (
        DATA_WIDTH : natural := 32;
        PCM_PRECISION : natural := 18
    );
    port (
        clk             : in  std_logic;
        clk_1            : in  std_logic;

        -- I2S interface to MEMs mic
        i2s_lrcl        : out std_logic;    -- left/right clk (word sel): 0 = left, 1 = right
        i2s_dout        : in  std_logic;    -- serial data: payload, msb first
        i2s_bclk        : out std_logic;    -- Bit clock: freq = sample rate * bits per channel * number of channels
                                            -- (should run at 2-4MHz). Changes when the next bit is ready.
        -- FIFO interface to MEMs mic
        fifo_din        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
        fifo_w_stb      : out std_logic;    -- Write strobe: 1 = ready to write, 0 = busy
        fifo_full       : in  std_logic     -- 1 = not full, 0 = full
    );
end i2s_master;

architecture Behavioral of i2s_master is
    --put your signals here
    signal bclk: std_ulogic := '0';
    signal word: std_ulogic := '1'; -- Start High
    signal ws_counter: unsigned (2 downto 0) := "000";
    signal bclk_counter: unsigned (3 downto 0) := "0000";
    signal read_idle: std_logic := '1'; -- If 0, in 32-64 bit range, otherwise in 0-32 bit range (first 3 states)
    
    signal data_buffer: std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal bit_count: integer := 0;
    signal fsm_state: integer := 0; 
    
begin
    -----------------------------------------------------------------------
    -- hint: write code for bclk clock generator:
    -----------------------------------------------------------------------
    --implementation...:
    process(clk_1)
    begin
        if falling_edge (clk_1) then 
            case bclk_counter is
                when "1011" =>
                    bclk <= not(bclk);
                    bclk_counter <= "0000";
              when others =>
                    bclk_counter <= bclk_counter + 1;
            end case;
       end if;
        i2s_bclk <= bclk;
    end process;
    ------------------------------------------------------------------------
    -- hint: write code for lrcl/ws clock generator:
    ------------------------------------------------------------------------
    --implementation...:
    process(bclk)
    begin 
        if falling_edge (bclk) then
            case ws_counter is
                when "100" =>
                    word <= not(word);
                    ws_counter <= "000";
                when others =>
                    ws_counter  <= ws_counter + 1;
            end case;
        end if;
        i2s_lrcl  <= word;
  end process;      
    ------------------------------------------------------------------------
    -- hint: write code for I2S FSM
    ------------------------------------------------------------------------
    --implementation...:
    --------------------------------------------------
    -- hint: write code for FIFO data handshake
    --------------------------------------------------
    -- hint: Useful link: https://encyclopedia2.thefreedictionary.com/Hand+shake+signal
    --implementation...:
    

    -- I2S FSM and FIFO Data Handshake
    process(bclk)
    begin
        if falling_edge(bclk) then
            case fsm_state is
                when 0 =>  -- Idle
                    if read_idle = '1' then
                        bit_count := 0;
                        data_buffer := (others => '0');
                        fsm_state := 1;
                    end if;
                when 1 =>  -- 18-bit data stream capture
                    data_buffer(bit_count) <= i2s_dout;
                    bit_count := bit_count + 1;
                    if bit_count = PCM_PRECISION then
                        fsm_state := 2;
                    end if;
                when 2 =>  -- Send bits to FIFO bus
                    if fifo_full = '0' then
                        fifo_din <= data_buffer;
                        fifo_w_stb <= '1';
                        fsm_state := 3;
                    end if;
                when 3 =>  -- Waiting state
                    if rising_edge(bclk) then
                        fsm_state := 0;
                        fifo_w_stb <= '0';
                    end if;
            end case;
        end if;
    end process;


end Behavioral;
