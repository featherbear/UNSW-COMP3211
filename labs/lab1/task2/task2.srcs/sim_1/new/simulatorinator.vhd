----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.02.2021 17:11:11
-- Design Name: 
-- Module Name: simulatorinator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simulatorinator is
--  Port ( );
end simulatorinator;

architecture Behavioral of simulatorinator is
    SIGNAL votes : std_logic_vector(30 downto 0);
    SIGNAL decision : STD_LOGIC;
begin

uut: entity work.majoritinatorinator 
    PORT MAP (
        votes,
        majority => decision
    );

process begin
    votes <= "0000000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000000001"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000000010"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000000100"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000001000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000010000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000000100000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000001000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000010000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000000100000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000001000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000010000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000000100000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000001000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000010000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000000100000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000001000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000010000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000000100000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000001000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000010000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000000100000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000001000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000010000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000000100000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000001000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000010000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0000100000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0001000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0010000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "0100000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1000000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1100000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1110000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111000000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111100000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111110000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111000000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111100000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111110000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111000000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111100000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111110000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111111000000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111111100000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111111110000000000000000"; wait for 50ns; -- 0
    votes <= "1111111111111111000000000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111100000000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111110000000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111000000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111100000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111110000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111000000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111100000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111110000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111111000000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111111100000"; wait for 50ns; -- 1
    votes <= "1111111111111111111111111111111"; wait for 50ns; -- 1
    votes <= "0101010101010101010101010101010"; wait for 50ns; -- 0
    votes <= "1010101010101010101010101010101"; wait for 50ns; -- 1
end process;



end Behavioral;
