library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tag_generator is
    port ( D  : in  std_logic_vector(31 downto 0);
           BF : in  std_logic_vector(3 downto 0);
           R  : in  std_logic_vector(11 downto 0); -- I'm assuming it's like this? not sure if it's
                                                 -- supposed to be R3, R2, R1, R0 separately
           T  : out std_logic_vector(7 downto 0));
end tag_generator;

architecture Behavioral of tag_generator is
----------------------------- COMPONENTS -----------------------------
    component rlshift is
        port ( src  : in  std_logic_vector(7 downto 0);
               shft : in  std_logic_vector(2 downto 0);
               res  : out std_logic_vector(7 downto 0));
    end component;

    -- INSERT BIT FLIP COMPONENT HERE
    -- component bit_flip is
    --     port ();
    -- end component;

------------------------------ SIGNALS -------------------------------
    -- Result from bit flip. Feel free to change the name :)
    signal d_bf0, d_bf1, d_bf2, d_bf3,: std_logic_vector(7 downto 0); 
    signal d_rls0, d_rls1, d_rls2, d_rls3 : std_logic_vector(7 downto 0); 

    -- Alternative way of having the signals
    -- signal d_bf : std_logic_vector(31 downto 0)
    -- signal d_rls : std_logic_vector(31 downto 0)
    -- vvvv This one here is for the XOR if we're going by this method vvv
    -- signal d_xor0, d_xor2, d_xor3, d_xor4: std_logic_vector(7 downto 0);
begin
    -- Bit Flip 

    -- RLS 
    rlshift0: rlshift port map (src  <= d_bf0, -- Change to d_bf(7 downto 0) if needed
                                shft <= R(2 downto 0), -- Change to R0 if needed
                                res  <= d_rls0);

    rlshift1: rlshift port map (src  <= d_bf1,
                                shft <= R(5 downto 3),
                                res  <= d_rls1);

    rlshift2: rlshift port map (src  <= d_bf2,
                                shft <= R(8 downto 6),
                                res  <= d_rls2);

    rlshift3: rlshift port map (src  <= d_bf3,
                                shft <= R(11 downto 9),
                                res  <= d_rls3);
    
    T <= d_rls3 XOR d_rls2 XOR d_rls1 XOR d_rls0;

    -- Another way to do this (alternative method):
    -- Tbh I don't know if the multiplying works HAHAHHAHA. But it saves
    -- you from having too many lines like above^
    -- gen_rlshift: for i in 0 to 3 generate
    --     rls_comp: rlshift port map (src  <= d_bf((i * 8 + 7) downto (i * 8)),
    --                                 shft <= R((i * 3 + 2) downto (i * 3)),
    --                                 res  <= d_rls((i * 8 + 7) downto (i * 8)));
    -- end generate gen_rlshift;

    -- d_xor0 <= d_rls(7 downto 0);
    -- d_xor1 <= d_rls(15 downto 8);
    -- d_xor2 <= d_rls(23 downto 16);
    -- d_xor3 <= d_rls(31 downto 24);

    -- T <= d_xor3 XOR d_xor2 XOR d_xor1 XOR d_xor0;
    
    
end Behavioral;