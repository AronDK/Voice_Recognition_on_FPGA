library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aud_param.all;
--library UNISIM;
--use UNISIM.VComponents.all;

entity i2s_master_tb is
end i2s_master_tb;

architecture Behavioral of i2s_master_tb is
    signal i2s_dout, clk, clk_1, fifo_full: std_logic := '0';
    constant CLK_PERIOD: time := 10 ns; -- 49.08MHZ
    signal clk_counter: unsigned(5 downto 0) := "000000";
        
    component i2s_master
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
        end component i2s_master;
        
begin
        
       -- Instantiate the i2s_master component
    UUT: i2s_master 
    generic map (
        PCM_PRECISION => 18,     -- Set PCM precision as needed
        DATA_WIDTH => 32        -- Set data width as needed
    )
    port map (
        clk => clk,
        clk_1 => clk_1,
        i2s_lrcl => open,
        i2s_dout => i2s_dout,  
        i2s_bclk => open,
        fifo_din => open,
        fifo_w_stb => open,
        fifo_full => fifo_full
    );
    
    -- Process for generating clocks
    process
    begin
        while true loop
            clk <= not clk;
            clk_1 <= not clk_1;
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process (apply inputs)
    process
    begin
        wait for CLK_PERIOD;  -- Wait for a clock cycle
        
        if clk_counter = "100000" then
            clk_counter <= (others => '0');
            fifo_full <= '0';
        else 
            clk_counter <= clk_counter + 1;
            
        end if;
        i2s_dout <= not(i2s_dout); 
    end process;
end Behavioral;