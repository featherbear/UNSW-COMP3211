----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 23:56:14
-- Design Name: 
-- Module Name: sll_block - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sll_block is
    Port ( val : in STD_LOGIC_VECTOR (15 downto 0);
           amt : in STD_LOGIC_VECTOR (3 downto 0);
           res : out STD_LOGIC_VECTOR (15 downto 0) );
end sll_block;

architecture Behavioral of sll_block is
begin
    res <= std_logic_vector(shift_left(unsigned(val), to_integer(unsigned(amt)))); 
    
    -- else generate 16 cases?
end Behavioral;
