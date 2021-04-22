---- Block bit flip component test
-- Tests a single block bit flip component against a series of inputs
-- Then compared to their expected outputs

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity block_flip_TB is
end block_flip_TB;

architecture Behavioral of block_flip_TB is
    signal data   : std_logic_vector(7 downto 0);
    signal result : std_logic_vector(7 downto 0); 
    signal flip   : std_logic;
    
    -- Visual comparison
    signal expected : std_logic_vector(7 downto 0);
    signal check    : std_logic;
begin

uut: entity work.bit_flip port map (
    data_in => data,
    data_out => result,
    flip => flip
);

-- Comparator to compare against the expected value
checks: entity work.nBitComparator generic map ( n => 8 ) port map (inA => result, inB => expected, isEqual => check);
                            
process begin
    ---- Invert all bits
    data <= "00000000"; flip <= '0'; expected <= "00000000"; wait for 50ns;
    data <= "00000000"; flip <= '1'; expected <= "11111111"; wait for 50ns;
    
    data <= "11111111"; flip <= '0'; expected <= "11111111"; wait for 50ns;
    data <= "11111111"; flip <= '1'; expected <= "00000000"; wait for 50ns;
    
    ---- Invert partial bits
    data <= "10101010"; flip <= '0'; expected <= "10101010"; wait for 50ns;
    data <= "10101010"; flip <= '1'; expected <= "01010101"; wait for 50ns;
    
    data <= "01010101"; flip <= '0'; expected <= "01010101"; wait for 50ns;
    data <= "01010101"; flip <= '1'; expected <= "10101010"; wait for 50ns;
    
    data <= "11110000"; flip <= '0'; expected <= "11110000"; wait for 50ns;
    data <= "11110000"; flip <= '1'; expected <= "00001111"; wait for 50ns;
    
    data <= "00001111"; flip <= '0'; expected <= "00001111"; wait for 50ns;
    data <= "00001111"; flip <= '1'; expected <= "11110000"; wait for 50ns;
end process;

end Behavioral;
