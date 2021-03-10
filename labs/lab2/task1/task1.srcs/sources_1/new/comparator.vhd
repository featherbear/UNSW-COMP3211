library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    Port ( src_a : in STD_LOGIC_VECTOR (15 downto 0);
           src_b : in STD_LOGIC_VECTOR (15 downto 0);
           res : out STD_LOGIC );
end comparator;

architecture Behavioral of comparator is
begin
    res <= '0' WHEN src_a = src_b ELSE '1';
end Behavioral;
