
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity holdUnit is
    Port ( src_a : in STD_LOGIC_VECTOR (3 downto 0);
           src_b : in STD_LOGIC_VECTOR (3 downto 0);
           
           -- ID.EX
           check_1_a : in STD_LOGIC;
           check_1_b : in STD_LOGIC_VECTOR(3 downto 0);
      
      
           ------------ extra checks because we're not forwarding
             
           -- EX.MEM
           check_2_a : in STD_LOGIC;
           check_2_b : in STD_LOGIC_VECTOR(3 downto 0);
           
           -- MEM.WB
           check_3_a : in STD_LOGIC;
           check_3_b : in STD_LOGIC_VECTOR(3 downto 0);
           
           -- if '1'
           --   set id.ex RegWrite to '0'
           --   set id.ex MemWrite to '0'
           --   set id.ex EnableJumpPC to '0'
           --   freeze IF.ID
           --   freeze PC
           res : out STD_LOGIC
         );
end holdUnit;

architecture Behavioral of holdUnit is

begin
    process (
        check_1_a, check_2_a, check_3_a,
        check_1_b, check_2_b, check_3_b, 
        src_a, src_b
    ) begin
      res <= '0';
      if (check_1_a = '1' and (check_1_b = src_a or check_1_b = src_b))
      or (check_2_a = '1' and (check_2_b = src_a or check_2_b = src_b))
      or (check_3_a = '1' and (check_3_b = src_a or check_3_b = src_b))
      then
        res <= '1';
      end if;
    end process;
end Behavioral;
