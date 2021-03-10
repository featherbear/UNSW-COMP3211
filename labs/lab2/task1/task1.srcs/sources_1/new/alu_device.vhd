library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_device is
    port (
        src_a : in std_logic_vector(15 downto 0);
        src_b : in std_logic_vector(15 downto 0);
        result : out std_logic_vector(15 downto 0);
        flag  : out std_logic;
        operation: in std_logic );
end alu_device;

architecture Behavioral of alu_device is
    SIGNAL add_result : std_logic_vector(15 downto 0);
    SIGNAL add_flag : std_logic;
    SIGNAL sll_result : std_logic_vector(15 downto 0);
    
    SIGNAL comparator_result : std_logic;
begin

    add_device: entity work.adder_16b 
    port map ( src_a     => src_a,
               src_b     => src_b,
               sum       => add_result,
               carry_out => add_flag );
    
    sll_device: entity work.sll_block
    port map ( val => src_a,
               amt => src_b,
               res => sll_result );
    
    comparator: entity work.comparator
    port map ( src_a => src_a,
               src_b => src_b,
               res   => comparator_result );

    result <= add_result WHEN operation = '0' ELSE sll_result;
    flag <= add_flag WHEN operation = '0' ELSE comparator_result;

end Behavioral;
