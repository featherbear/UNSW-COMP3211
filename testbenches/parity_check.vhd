--- Early parity checker by Lindsay Small for COMP3211 Assignment1

-- The parity bit tacked onto the data should be an even value

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration for the parity checker
entity parity_check is
    port (
        data:   in std_logic_vector(7 downto 0);
        parity: in std_logic;
        error:  out std_logic
    );
end parity_check;

-- Actually do the checking
architecture behaviour of parity_check is
    component parity_unit port (
        data:   in std_logic_vector(7 downto 0);
        parity: out std_logic
    );
    end component;

    signal ODD : std_logic;
begin
    -- Does the data have an odd parity?
    calc : parity_unit port map (
        data    => data,
        parity  => ODD
    );

    -- For a data byte with odd values, this should be 1 ^ 1 = 0
    error <= parity xor ODD;
end behaviour;