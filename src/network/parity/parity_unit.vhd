--- Early parity checker by Lindsay Small for COMP3211 Assignment1

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration for the parity checker
entity parity_unit is
    port (
        data:   in std_logic_vector(7 downto 0);
        parity: out std_logic
    );
end parity_unit;

-- The architecture, not entirely sure this is supported
--architecture parity1 of parity_unit is
--begin
--    parity <= xor data;
--end parity1;

architecture parity2 of parity_unit is
    signal temp: std_logic_vector(7 downto 0);
begin
    temp(0) <= data(0);
    gen: for i in 1 to 7 generate
        temp(i) <= temp(i-1) xor data(i);
    end generate;
    parity <= temp(7);
end parity2;