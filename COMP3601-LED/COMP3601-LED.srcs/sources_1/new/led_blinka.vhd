----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2023 12:33:39
-- Design Name: 
-- Module Name: led_blinka - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_blinka is
    Port ( clk_10MHZ : in STD_LOGIC;
           led_out : out STD_LOGIC);
end led_blinka;

architecture Behavioral of led_blinka is
    signal clk_counter: unsigned(23 downto 0) := "000000000000000000000000";
    signal led_on: std_logic := '0';
begin
    process(clk_10MHZ)
    begin
        if rising_edge(clk_10MHZ) then
           clk_counter <= clk_counter + 1;
           if clk_counter >= 10000000 then
                led_on <= NOT led_on;
                clk_counter <= "000000000000000000000000";
           end if; 
        end if;
        end process; 
        led_out <= led_on;                          
end Behavioral;
