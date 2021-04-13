-- Early test bench for the parity checker
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Our testbench, currently no need to interface
entity check_tb is
end check_tb;

-- The architecture
architecture behaviour of check_tb is
    -- For generating the parity signals
    component parity_unit PORT (
        data:   in  std_logic_vector(7 downto 0);
        parity: out std_logic
    );
    end component;

    -- Test the effectiveness of that
    component parity_check PORT (
        data:   in std_logic_vector(7 downto 0);
        parity: in std_logic;
        error:  out std_logic
    );
    end component;
    
    -- Signals that we'll need
    signal DATA     : std_logic_vector(7 downto 0); -- To the parity
    signal PARITY   : std_logic;    -- Output from the parity
    signal ERROR    : std_logic;
    signal CLK      : std_logic;

    constant clk_period : time := 10ns;
begin
    parity_component : parity_unit port map (
        data    => DATA,
        parity  => PARITY
    );
    check_UUT : parity_check port map (
        data    => DATA,
        parity  => PARITY,
        error  => ERROR
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
            -- Write the data to the parity unit
            DATA <= std_logic_vector(to_unsigned(i, DATA'length));
            wait until rising_edge(CLK);
        end loop;
    end process;
end behaviour;