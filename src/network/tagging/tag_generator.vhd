---- Tag Generator Unit
-- Performs a block bit flip, RLS and XOR on to four bytes (8-bit values)
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tag_generator is
    port ( D  : in  std_logic_vector(31 downto 0); -- Incoming data
                                                      -- Block 3 - 24 - 31
                                                      -- Block 2 - 16 - 23
                                                      -- Block 1 -  8 - 15
                                                      -- Block 0 -  0 -  7
           BF : in  std_logic_vector(3  downto 0); -- Block flip vector
           R  : in  std_logic_vector(11 downto 0); -- R-values
                                                      -- Block 3 - 9 - 11
                                                      -- Block 2 - 6 -  8
                                                      -- Block 1 - 3 -  5
                                                      -- Block 0 - 0 -  2
           T  : out std_logic_vector(7  downto 0)  -- Output tag
         );
end tag_generator;

architecture Behavioural of tag_generator is
     signal d_BF_RLS : std_logic_vector(31 downto 0);
     signal d_RLS_XOR : std_logic_vector(31 downto 0); 
begin

    -- Block bit flips
    gen_bit_flip: FOR i IN 0 TO 3 GENERATE
       dev_bit_flip: ENTITY work.bit_flip
           PORT MAP (
               data_in => D(i*8 + 7 DOWNTO i*8),
               data_out => d_BF_RLS(i*8 + 7 DOWNTO i*8),
               flip => BF(i)
           );
    END GENERATE;                           

    -- RLS components
    gen_rls_shift: FOR i IN 0 TO 3 GENERATE
       dev_rls_shift: ENTITY work.rlsshift
           PORT MAP (
               src  => d_BF_RLS((i*8 + 7) downto (i*8)),
               shft => R((i*3 + 2) downto (i*3)),
               res  => d_RLS_XOR((i*8 + 7) downto (i*8))
           );          
    END GENERATE;                       
    
    -- XOR each byte
    T <= d_RLS_XOR(31 DOWNTO 24) XOR d_RLS_XOR(23 DOWNTO 16) XOR d_RLS_XOR(15 DOWNTO 8) XOR d_RLS_XOR(7 DOWNTO 0);

end Behavioural;