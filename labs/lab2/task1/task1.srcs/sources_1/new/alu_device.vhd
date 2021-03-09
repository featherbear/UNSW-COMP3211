----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 00:08:09
-- Design Name: 
-- Module Name: alu_device - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

    process (operation) begin
        result <= add_result WHEN operation = '0' ELSE sll_result;
        flag <= add_flag WHEN operation = '0' ELSE '0';
    end process;
    
end Behavioral;
