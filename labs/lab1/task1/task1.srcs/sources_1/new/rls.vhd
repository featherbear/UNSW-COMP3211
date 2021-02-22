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
    Generic ( N : INTEGER );
    Port ( I : in STD_LOGIC_VECTOR (15 downto 0);
           O : out STD_LOGIC_VECTOR (15 downto 0));
end rls;

architecture Behavioral of rls is
    SIGNAL temp : STD_LOGIC_VECTOR (15 downto 0);
begin

process (I)
    begin
    rot: for x in 1 to N loop
        temp(16-x) <= I(16-x-1);
        temp(x-1) <= I(16 - x); 
    end loop;

end process;

O <= temp;

end Behavioral;
