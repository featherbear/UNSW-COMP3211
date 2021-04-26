---- Block bit flip unit
-- Performs a NOT operation on all bits of an n-bit vector
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_flip is
    port ( 
        data_in  : in  STD_LOGIC_VECTOR (7 downto 0);
        data_out : out STD_LOGIC_VECTOR (7 downto 0);
        flip : in STD_LOGIC
    );
end bit_flip;

architecture Behavioural of bit_flip is
begin
    -- Invert the bits when flip = 1
    data_out <= not data_in when flip = '1' else data_in;
end Behavioural;
