---- Tag generation component test
-- Tests the tag generation component against a set of inputs and expected outputs

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tag_gen_TB is
end tag_gen_TB;

architecture Behavioral of tag_gen_TB is
    signal Rotate : std_logic_vector(11 downto 0); 
    signal BitFlip : std_logic_vector(3 downto 0);
    signal result : std_logic_vector(7 downto 0); 
    signal Data : std_logic_vector(31 downto 0);
  
    -- Visual comparison
    signal expected : std_logic_vector(7 downto 0);
    signal check    : std_logic;
begin

    uut : entity work.tag_generator port map (
                                                 R => Rotate,
                                                 BF => BitFlip,
                                                 T => result,
                                                 D => Data
                                             );

    -- Comparator to compare against the expected value
    checks: entity work.nBitComparator generic map ( n => 8 ) port map (inA => result, inB => expected, isEqual => check);
    
    process begin

        ---- Dud checks
        Data <= "00000000000000000000000000000000"; BitFlip <= "0000"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0000"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;

        ---------------------------------------------------

        ---- Flip individual blocks, no RLS
        Data <= "00000000111111110000000011111111"; BitFlip <= "1000"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0100"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0010"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0001"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;

        ---- Flip multiple blocks, no RLS
        Data <= "00000000111111110000000011111111"; BitFlip <= "1111"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "1010"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0101"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "1100"; Rotate <= "000000000000"; Expected <= "00000000"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "1110"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;
        Data <= "00000000111111110000000011111111"; BitFlip <= "0111"; Rotate <= "000000000000"; Expected <= "11111111"; wait for 50ns;

        ---------------------------------------------------

        ---- No flips, rotate one block
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000000000000"; Expected <= "01011010"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000001000000"; Expected <= "01001011"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000010000000"; Expected <= "01101001"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000011000000"; Expected <= "00101101"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000100000000"; Expected <= "10100101"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000101000000"; Expected <= "10110100"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000110000000"; Expected <= "10010110"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000111000000"; Expected <= "11010010"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000000000001"; Expected <= "10100101"; wait for 50ns;
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000000000010"; Expected <= "01011010"; wait for 50ns;

        ---- Flip multiple blocks
        Data <= "00000000000011110000000001010101"; BitFlip <= "0000"; Rotate <= "000001000001"; Expected <= "10110100"; wait for 50ns;

    end process;


end Behavioral;
