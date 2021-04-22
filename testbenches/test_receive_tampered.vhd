---- Parity send test
-- Tests the request to send parity-invalid data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use STD.textio.all;
use ieee.std_logic_textio.all;

entity test_receive_tampered is
end test_receive_tampered;

architecture Behavioural of test_receive_tampered is
    constant c_CLOCK_PERIOD : time := 5 ns;
    signal r_CLOCK : std_logic := '0';
    signal r_reset : std_logic := '0';
    
    signal CPU_ctrl         : std_logic_vector(4 downto 0);
    signal network          : std_logic_vector(39 downto 0);
    signal network_activity : std_logic;
    
    -- Test signal
    signal sig_error : std_logic;
    
begin
    
    uut: entity work.network_coprocessor_ASIP PORT MAP (
        reset => r_reset,
        clk => r_CLOCK,
        extPort => (others => '0'),
        CTRL => CPU_ctrl,
        procData => (others => '0'),
        procParity => '0',
        networkReady => network_activity,
        netData => network,
        error => sig_error
    );

    process begin
        r_reset <= '0'; wait for 2*c_CLOCK_PERIOD; r_reset <= '1'; wait for 2*c_CLOCK_PERIOD; r_reset <= '0'; wait for 6*c_CLOCK_PERIOD;

        -- Send tampered data
        CPU_ctrl <= "11000"; network <= "0000000000000000000000000000000000000101"; network_activity <= '1'; wait for 2*c_CLOCK_PERIOD;
        
        -- Network silence
        CPU_ctrl <= "00000"; network <= "0000000000000000000000000000000000000000"; network_activity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        -- Send tampered data
        CPU_ctrl <= "11000"; network <= "0000000000000000000000000000000000000101"; network_activity <= '1'; wait for 2*c_CLOCK_PERIOD;
        
        -- Network silence
        CPU_ctrl <= "00000"; network <= "0000000000000000000000000000000000000000"; network_activity <= '0'; wait for 2*c_CLOCK_PERIOD;
        
        -- Send tampered data
        CPU_ctrl <= "11000"; network <= "0000000000000000000000000000000000000101"; network_activity <= '1'; wait for 2*c_CLOCK_PERIOD;
        
        -- Network silence
        CPU_ctrl <= "00000"; network <= "0000000000000000000000000000000000000000"; network_activity <= '0'; wait for 6*c_CLOCK_PERIOD;
    end process;

    p_CLK_GEN : process is begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

end Behavioural;
