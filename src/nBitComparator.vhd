library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nBitComparator is
    Generic ( n : integer := 8 );
    Port ( 
        inA : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        inB : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        isEqual : out STD_LOGIC;
        isNotEqual : out STD_LOGIC
    );
end nBitComparator;

architecture Behavioral of nBitComparator is

begin
    isEqual <= '1' when inA = inB else '0';
    isNotEqual <= '0' when inA = inB else '1';
end Behavioral;
