---- Early test bench for the parity checker
-- Tests the parity generation for all 8-bit values (0-255)
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Our testbench, currently no need to interface
entity parity_TB is
end parity_TB;

-- The architecture
architecture behaviour of parity_TB is
    component parity_unit PORT (
        data:   in std_logic_vector(7 downto 0);
        parity: out std_logic
    );
    end component;

    signal DATA     : std_logic_vector(7 downto 0);
    signal PARITY   : std_logic;
    signal CLK      : std_logic;

    constant clk_period : time := 10ns;
begin
    UUT : parity_unit port map (
        data    => DATA,
        parity  => PARITY
    );

    ---------------------------------------------------------------------------
    clk_process : process is
    begin
        CLK <= '0';     wait for clk_period/2;
        CLK <= '1';     wait for clk_period/2;
    end process;

    ---------------------------------------------------------------------------
    stimulus : process is
    begin
        -- Initially the information is 0
        DATA <= X"00";
        wait until rising_edge(CLK);

        -- Then go through all possible data combinations
        for i in 0 to 255 loop
            DATA <= std_logic_vector(to_unsigned(i, DATA'length));
            wait until rising_edge(CLK);
        end loop;
    end process;
end behaviour;