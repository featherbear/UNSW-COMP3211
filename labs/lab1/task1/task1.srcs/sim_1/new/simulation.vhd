----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.02.2021 01:32:59
-- Design Name: 
-- Module Name: simulation - Behavioral
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

entity simulation is
--  Port ( );
end simulation;

architecture Behavioral of simulation is
    SIGNAL testValue : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0111000011110001";
    SIGNAL out0, out1, out2, out3, out4, out5 : STD_LOGIC_VECTOR(15 DOWNTO 0);
begin
  rot0: ENTITY work.rls 
        GENERIC map (
            n => 0
        ) 
        PORT map (
            I => testValue,
            O => out0
        );
  
  rot1: ENTITY work.rls 
        GENERIC map (
            n => 1
        ) 
        PORT map (
            I => testValue,
            O => out1
        );
  
  rot2: ENTITY work.rls 
        GENERIC map (
            n => 2
        ) 
        PORT map (
            I => testValue,
            O => out2
        );
  
  rot3: ENTITY work.rls 
        GENERIC map (
            n => 3
        ) 
        PORT map (
            I => testValue,
            O => out3
        );
  
  rot4: ENTITY work.rls 
        GENERIC map (
            n => 4
        ) 
        PORT map (
            I => testValue,
            O => out4
        );
  
  rot5: ENTITY work.rls 
        GENERIC map (
            n => 5
        ) 
        PORT map (
            I => testValue,
            O => out5
        );
  


end Behavioral;
