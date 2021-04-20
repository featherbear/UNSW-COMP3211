library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tag_generator is
    port ( D  : in  std_logic_vector(31 downto 0); -- Incoming data
           BF : in  std_logic_vector(3  downto 0); -- Block flip vector
           R  : in  std_logic_vector(11 downto 0); -- R-values
           T  : out std_logic_vector(7  downto 0)  -- Output tag
         );
end tag_generator;

architecture Behavioural of tag_generator is
     signal d_BF_RLS : std_logic_vector(31 downto 0);
     signal d_RLS_XOR : std_logic_vector(31 downto 0); 
begin

    gen_bit_flip: FOR i IN 0 TO 3 GENERATE
       dev_bit_flip: ENTITY work.bit_flip
           PORT MAP (
               data_in => D(i*8 + 7 DOWNTO i*8),
               data_out => d_BF_RLS(i*8 + 7 DOWNTO i*8),
               flip => BF(i)
           );
    END GENERATE;                           
           
    gen_rls_shift: FOR i IN 0 TO 3 GENERATE
       dev_rls_shift: ENTITY work.rlshift
           PORT MAP (
               src  => d_BF_RLS((i*8 + 7) downto (i*8)),
               shft => R((i*3 + 2) downto (i*3)),
               res  => d_RLS_XOR((i*8 + 7) downto (i*8))
           );          
    END GENERATE;                       
    
    T <= d_RLS_XOR(31 DOWNTO 24) XOR d_RLS_XOR(23 DOWNTO 16) XOR d_RLS_XOR(15 DOWNTO 8) XOR d_RLS_XOR(7 DOWNTO 0);

end Behavioural;