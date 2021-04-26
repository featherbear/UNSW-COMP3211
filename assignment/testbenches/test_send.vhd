---- Network send test
-- Sends data over a wire

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_send is
end test_send;

architecture Behavioural of test_send is
    constant c_CLOCK_PERIOD : time := 5 ns;
    signal r_CLOCK : std_logic := '0';
    signal r_reset : std_logic := '0';
    
    signal CPU_ctrl        : std_logic_vector(4 downto 0);
    signal CPU_data        : std_logic_vector(31 downto 0);
    signal CPU_data_parity : std_logic;
    
    -- Signals under test
    signal network : std_logic_vector(39 downto 0);
    signal network_activity : std_logic;
    
begin

    uut: entity work.network_coprocessor_ASIP PORT MAP (
        reset => r_reset,
        clk => r_CLOCK,
        extPort => (others => '0'),
        CTRL => CPU_ctrl,
        procData => CPU_data,
        procParity => CPU_data_parity,
        networkReady => '0',
        netData => (others => '0'),
        netOut => network,
        netDataPresent => network_activity
    );

    process begin
        r_reset <= '0'; wait for 2*c_CLOCK_PERIOD; r_reset <= '1'; wait for 2*c_CLOCK_PERIOD; r_reset <= '0'; wait for 6*c_CLOCK_PERIOD;

        -- Send data
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000101010101"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;

        -- Send data
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000101010101"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
  
        -- Send data
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000101010101"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        -- Load key
        CPU_ctrl <= "10010"; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; wait for 2*c_CLOCK_PERIOD;

        -- Send with updated tag
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000101010101"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        wait for 4*c_CLOCK_PERIOD;
    end process;

    p_CLK_GEN : process is begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

end Behavioural;
