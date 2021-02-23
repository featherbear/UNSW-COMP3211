----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.02.2021 17:06:54
-- Design Name: 
-- Module Name: majoritinatorinator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity majoritinatorinator is
    Port ( votes : in STD_LOGIC_VECTOR (30 downto 0);
           majority : out STD_LOGIC);
end majoritinatorinator;

architecture Behavioral of majoritinatorinator is

begin

process (votes)
    variable c : unsigned(4 downto 0) := "00000";
begin
    c := "00000";
    for i in 0 to 30 loop
        if votes(i) = '1' then
            c := c + 1;
        end if;
    end loop;
    if c >= 16 then
        majority <= '1';
    else
        majority <= '0';
    end if;
end process;


end Behavioral;
