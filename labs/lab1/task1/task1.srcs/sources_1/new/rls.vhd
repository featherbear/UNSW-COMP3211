----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.02.2021 01:09:46
-- Design Name: 
-- Module Name: rls - Behavioral
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

entity rls is
    Generic ( N : INTEGER := 0);
    Port ( I : in STD_LOGIC_VECTOR (15 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end rls;

architecture Behavioral of rls is
begin

O <= I(15-N DOWNTO 0) & I(15 DOWNTO 15-N+1);

end Behavioral;
