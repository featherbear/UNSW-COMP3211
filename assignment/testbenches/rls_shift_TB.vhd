---- RLS component test
-- Tests the rotate left shift component against a set of inputs and expected outputs

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rls_shift_TB is
end rls_shift_TB;

architecture Behavioral of rls_shift_TB is
    signal data   : std_logic_vector(7 downto 0);
    signal result : std_logic_vector(7 downto 0); 
    signal shift  : std_logic_vector(2 downto 0);
    
    -- Visual comparison
    signal expected : std_logic_vector(7 downto 0);
    signal check    : std_logic;
begin

    uut: entity work.rlsshift port map (
        src  => data,
        shft => shift,
        res  => result
    );
    
    -- Comparator to compare against the expected value
    checks: entity work.nBitComparator generic map ( n => 8 ) port map (inA => result, inB => expected, isEqual => check);
                               
process begin

    -- Rotate the same inputs through all RLS values
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(0, shift'length)); expected <= "00010001"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(1, shift'length)); expected <= "00100010"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(2, shift'length)); expected <= "01000100"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(3, shift'length)); expected <= "10001000"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(4, shift'length)); expected <= "00010001"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(5, shift'length)); expected <= "00100010"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(6, shift'length)); expected <= "01000100"; wait for 50ns;
    data <= "00010001"; shift <= std_logic_vector(to_unsigned(7, shift'length)); expected <= "10001000"; wait for 50ns;

    -- Ensure no 1 bit appears during rotation
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(0, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(1, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(2, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(3, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(4, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(5, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(6, shift'length)); expected <= "00000000"; wait for 50ns;
    data <= "00000000"; shift <= std_logic_vector(to_unsigned(7, shift'length)); expected <= "00000000"; wait for 50ns;
    
end process;


end Behavioral;
