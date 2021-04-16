---------------------------------------------------------------------------
-- 3to1 mux by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_3to1_16b is
    port (
        mux_select  : in  std_logic_vector(1 downto 0);
        data_a      : in  std_logic_vector(15 downto 0);
        data_b      : in  std_logic_vector(15 downto 0);
        data_c      : in  std_logic_vector(15 downto 0);
        data_out    : out std_logic_vector(15 downto 0)
    );
end mux_3to1_16b;

architecture behavioral of mux_3to1_16b is
    -- We'll build a 3 way mux from a pair of 2ways
    component mux_2to1_16b is
        port (
            mux_select : in  std_logic;
            data_a     : in  std_logic_vector(15 downto 0);
            data_b     : in  std_logic_vector(15 downto 0);
            data_out   : out std_logic_vector(15 downto 0)
        );
    end component;

    signal sig_intermediate : std_logic_vector(15 downto 0);

begin
    mux1 : mux_2to1_16b
    port map (  mux_select  => mux_select(0),
                data_a      => data_a,
                data_b      => data_b,
                data_out    => sig_intermediate);

    mux2 : mux_2to1_16b
    port map (  mux_select  => mux_select(1),
                data_a      => sig_intermediate,
                data_b      => data_c,
                data_out    => data_out);

end behavioral;