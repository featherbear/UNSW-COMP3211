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

entity rlshift is
    port ( src  : in  std_logic_vector(7 downto 0);
           shft : in  std_logic_vector(2 downto 0);
           res  : out std_logic_vector(7 downto 0));
end rlshift;

architecture Behavioral of rlshift is

begin

    shift_left: process(src, shft)
        variable n : integer;
        variable shft_src: std_logic_vector(7 downto 0);
    begin
        n := conv_integer(shft);
        shft_src := src;

        shftloop: for i in 1 to 7 loop
            if i <= n then
                shft_src := shft_src(6 downto 0) & shft_src(7); 
            end if;
        end loop;
        
        res <= shft_src;
    end process;

end Behavioral;
