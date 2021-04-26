---- Network communication tests
-- Tests two cores, one sending data and the other receiving that data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use STD.textio.all;
use ieee.std_logic_textio.all;

entity test_network is
end test_network;

architecture Behavioural of test_network is
    constant c_CLOCK_PERIOD : time := 5 ns;
    signal r_CLOCK : std_logic := '0';
    signal r_reset : std_logic := '0';
    
    -- CPU1 (sender)
    signal CPU1_ctrl        : std_logic_vector(4 downto 0);
    signal CPU1_data        : std_logic_vector(31 downto 0);
    signal CPU1_data_parity : std_logic;
    
    -- CPU (receiver)
    signal CPU2_ctrl : std_logic_vector(4 downto 0); 

    -- The network link
    signal network          : std_logic_vector(39 downto 0);
    signal network_activity : std_logic;
    
begin

    ----- CPU1 (sender)
    -- Sends CPU1_data over the network (`network`)
    uut1: entity work.network_coprocessor_ASIP PORT MAP (
        clk => r_CLOCK,
        reset => r_reset,
        extPort => (others => '0'),
        CTRL => CPU1_ctrl,
        procData => CPU1_data,
        procParity => CPU1_data_parity,
        networkReady => '0',
        netData => (others => '0'),
        netOut => network,
        netDataPresent => network_activity
    );
    
    ----- CPU2 (receiver)
    -- Should receive CPU1_data from the network
    uut2: entity work.network_coprocessor_ASIP PORT MAP (
        clk => r_CLOCK,
        reset => r_reset,
        extPort => (others => '0'),
        CTRL => CPU2_ctrl,
        procData => (others => '0'),
        procParity => '0',
        networkReady => network_activity,
        netData => network
    );

    process begin
        r_reset <= '0'; wait for 2*c_CLOCK_PERIOD; r_reset <= '1'; wait for 2*c_CLOCK_PERIOD; r_reset <= '0'; wait for 6*c_CLOCK_PERIOD;

        -- Send data
        CPU1_ctrl <= "10100"; CPU1_data <= "00000000000000000000000101010101"; CPU1_data_parity <= '1';
        wait for 8*c_CLOCK_PERIOD;
        
        -- Network silence
        CPU1_ctrl <= "00000"; CPU1_data <= "00000000000000000000000101010101";
        wait for 2*c_CLOCK_PERIOD;
    end process;
    
    process begin
        -- Receive data
        CPU2_ctrl <= "11000"; 
        wait for 2*c_CLOCK_PERIOD;
    end process;

    p_CLK_GEN : process is begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

end Behavioural;
