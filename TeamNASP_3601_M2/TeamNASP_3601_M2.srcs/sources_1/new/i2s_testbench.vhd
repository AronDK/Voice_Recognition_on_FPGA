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
use work.aud_param.all;  -- Make sure to include the necessary package

entity i2s_testbench is
end entity i2s_testbench;

architecture sim of i2s_testbench is
    signal clk, clk_1, bclk, fifo_full, i2s_dout: std_logic := '0';
    signal datastream : std_logic_vector (31 downto 0) := "00011010010101001011010101101100";
    signal simulating : boolean := true;
    signal counter: unsigned (4 downto 0) := "0000";
    
    constant CLOCK_PERIOD : time := 10 ns;  -- 49.408 MHz
    constant BCLK_PERIOD : time := 190 ns;
    
    component i2s_master
        generic (
            DATA_WIDTH : natural := 32;
            PCM_PRECISION : natural := 18
        );
        port (
            clk             : in  std_logic;
            clk_1           : in  std_logic;
            i2s_lrcl        : out std_logic;
            i2s_dout        : in  std_logic;
            i2s_bclk        : out std_logic;
            fifo_din        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
            fifo_w_stb      : out std_logic;
            fifo_full       : in  std_logic
        );
    end component;

begin
    -- Instantiate i2s_master
    UUT: i2s_master
    generic map (
        DATA_WIDTH => 32,
        PCM_PRECISION => 18
    )
    port map (
        clk => clk,
        clk_1 => clk_1,
        i2s_dout => i2s_dout,
        fifo_full => fifo_full
    );

    -- Clock Generation Process
    process
    begin
        while simulating loop
            wait for CLOCK_PERIOD;
            clk <= not clk;
            clk_1 <= not clk_1;
            wait for BCLK_PERIOD ;
            bclk <= not bclk;
        end loop;
    end process;

    -- Simulation Stage 1
    -- Stimulate inputs
    process(bclk)
    begin
        if (counter = 32) then 
            simulating = false;
        end if;
        i2s_dout <= not i2s_dout;
        counter <= counter + 1;
    end process;

end sim;