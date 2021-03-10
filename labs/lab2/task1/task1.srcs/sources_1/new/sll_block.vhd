library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity sll_block is
    Port ( val : in STD_LOGIC_VECTOR (15 downto 0);
           amt : in STD_LOGIC_VECTOR (15 downto 0); -- realistically will only use at most 4 bits
           res : out STD_LOGIC_VECTOR (15 downto 0) );
end sll_block;

architecture Behavioral of sll_block is
begin
    res <= std_logic_vector(shift_left(unsigned(val), to_integer(unsigned(amt)))); 
    -- else generate 16 cases?
end Behavioral;
