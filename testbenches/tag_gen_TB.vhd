----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2021 03:12:58
-- Design Name: 
-- Module Name: TB_taggen - Behavioral
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

entity TB_taggen is
--  Port ( );
end TB_taggen;

architecture Behavioral of TB_taggen is
    signal Rotate : std_logic_vector(11 downto 0); 
    signal BitFlip : std_logic_vector(3 downto 0);
    signal T : std_logic_vector(7 downto 0); 
    signal Data : std_logic_vector(31 downto 0); -- is this the data incoming?
    


begin

uut : entity work.tag_generator port map(  R => Rotate,
                                           BF => BitFlip,
                                           T => T,
                                           D => Data);

process begin

Data <= "00000000000000000000000000000000";
BitFlip <= "0000";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0000";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "1000";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0100";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0010";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0001";
Rotate <= "000000000000";
wait for 50ns;
-------------------------------------------------

-------------------------------------------------
Data <= "00000000111111110000000011111111";
BitFlip <= "1111";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "1010";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0101";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "1100";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "1110";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000111111110000000011111111";
BitFlip <= "0111";
Rotate <= "000000000000";
wait for 50ns;

---------------------------------------------------
--Test Rotate
---------------------------------------------------

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000000000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000001000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000010000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000011000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000100000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000101000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000110000000";
wait for 50ns;

Data <= "00000000000011110000000001010101";
BitFlip <= "0000";
Rotate <= "000111000000";
wait for 50ns;

end process;


end Behavioral;
