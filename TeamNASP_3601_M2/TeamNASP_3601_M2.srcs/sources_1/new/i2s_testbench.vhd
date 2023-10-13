----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2023 11:37:41
-- Design Name: 
-- Module Name: i2s_testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aud_param.all;

entity i2s_testbench is
end entity i2s_testbench;

architecture sim of i2s_testbench is
    signal clk, clk_1, bclk, fifo_full, i2s_dout, reset: std_logic := '0';
    signal datastream : std_logic_vector (31 downto 0) := "00011010010101001011010101101100";
    signal counter: unsigned (4 downto 0) := "0000";
    
    constant CLOCK_PERIOD : time := 10 ns;
    constant BCLK_PERIOD : time := 190 ns;
    
    component i2s_master
        generic (
            DATA_WIDTH : natural := 32;
            PCM_PRECISION : natural := 18
        );
        port (
            clk             : in  std_logic;
            clk_1           : in  std_logic;
            reset             : in  std_logic;  -- Added Reset Signal
            i2s_lrcl        : out std_logic;
            i2s_dout        : in  std_logic;
            i2s_bclk        : out std_logic;
            fifo_din        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
            fifo_w_stb      : out std_logic;
            fifo_full       : in  std_logic
        );
    end component;

begin
    UUT: i2s_master
    generic map (
        DATA_WIDTH => 32,
        PCM_PRECISION => 18
    )
    port map (
        clk => clk,
        clk_1 => clk_1,
        reset => reset,
        i2s_lrcl => open,
        i2s_dout => i2s_dout,
        i2s_bclk => bclk,    
        fifo_din => open,
        fifo_w_stb => open,
        fifo_full => fifo_full
    );

    -- Clock Generation Process for clk
    process
    begin
        clk <= '0';
        wait for CLOCK_PERIOD/2;
        clk <= '1';
        wait for CLOCK_PERIOD/2;
    end process;
    
    -- Clock Generation Process for clk_1
    process
    begin
        clk_1 <= '0';
        wait for BCLK_PERIOD/2;
        clk_1 <= '1';
        wait for BCLK_PERIOD/2;
    end process;

    -- Simulation for i2s_dout
    process
    begin
        for i in unsigned'("00000") to unsigned'("11111") loop
            i2s_dout <= datastream(to_integer(i));
            wait for CLOCK_PERIOD;  -- Wait for a clock cycle before updating data
        end loop;
        wait;
    end process;

    -- Reset Simulation
    process
    begin
        reset <= '1';
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait;
    end process;

end sim;