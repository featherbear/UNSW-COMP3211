---- Parity send test
-- Tests the request to send parity-invalid data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_parity_error is
end test_parity_error;

architecture Behavioural of test_parity_error is
    constant c_CLOCK_PERIOD : time := 5 ns;
    signal r_CLOCK : std_logic := '0';
    signal r_reset : std_logic := '0';
    
    signal CPU_ctrl        : std_logic_vector(4 downto 0);
    signal CPU_data        : std_logic_vector(31 downto 0);
    signal CPU_data_parity : std_logic;
    
    signal network          : std_logic_vector(39 downto 0);
    signal network_activity : std_logic;

    -- Test signal
    signal sig_error: std_logic;
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
        error => sig_error,
        netOut => network,
        netDataPresent => network_activity
    );

    process begin
        r_reset <= '0'; wait for 2*c_CLOCK_PERIOD; r_reset <= '1'; wait for 2*c_CLOCK_PERIOD; r_reset <= '0'; wait for 6*c_CLOCK_PERIOD;
       
        ---- Send parity-invalid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000001"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;

        ---- Send parity-valid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000001"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        ---- Send parity-valid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000011"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;

        ---- Send parity-invalid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000011"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;

        ---- Send parity-valid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000111"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        ---- Send parity-valid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000111"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;
        -- And then send parity-valid request
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '1'; wait for 2*c_CLOCK_PERIOD;

        ---- Send parity-valid request
        CPU_ctrl <= "10100"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        CPU_ctrl <= "00000"; CPU_data <= "00000000000000000000000000000000"; CPU_data_parity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        wait for 2 sec;
    end process;

    p_CLK_GEN : process is begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

end Behavioural;
