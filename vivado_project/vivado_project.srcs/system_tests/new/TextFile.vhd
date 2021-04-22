----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 15:09:30
-- Design Name: 
-- Module Name: TextFile - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity TextFile is
--  Port ( );
end TextFile;

architecture Behavioural of TextFile is
    constant c_CLOCK_PERIOD : time := 5 ns;
    signal r_CLOCK : std_logic := '0';
    signal r_reset : std_logic := '0';
    
    signal CPU_ctrl : std_logic_vector(4 downto 0);
    signal CPU_data : std_logic_vector(31 downto 0);
    signal CPU_data_parity : std_logic;
    
    signal sig_error : std_logic;
    signal network : std_logic_vector(39 downto 0);
    signal network_activity : std_logic;
    
  file file_input : text;
  file file_output : text;
  
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

  process
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_cpu_ctrl : std_logic_vector(4 downto 0);
    variable v_cpu_data : std_logic_vector(31 downto 0);
    variable v_cpu_data_parity : std_logic;
    variable v_ok : boolean;
    variable v_SPACE     : character;
    variable out_error : std_logic;
  begin
    r_reset <= '0'; wait for 2*c_CLOCK_PERIOD; r_reset <= '1'; wait for 2*c_CLOCK_PERIOD; r_reset <= '0'; wait for 6*c_CLOCK_PERIOD;
    file_open(file_input, "input_tests.txt",  read_mode);
    file_open(file_output, "output_tests.txt",  write_mode);
 
    while not endfile(file_input) loop
    
      readline(file_input, v_ILINE);
      
      read(v_ILINE, v_cpu_ctrl);
      read(v_ILINE, v_SPACE);
      
      read(v_ILINE, v_cpu_data);
      read(v_ILINE, v_SPACE);
      
      read(v_ILINE, v_cpu_data_parity);
 
      -- Pass the variable
      CPU_ctrl <= v_cpu_ctrl;
      CPU_data <= v_cpu_data;
      CPU_data_parity <= v_cpu_data_parity;
      
      wait for 2*c_CLOCK_PERIOD;
      
      out_error := sig_error;
      write(v_OLINE, out_error);
      writeline(file_output, v_OLINE);
    end loop;
 
    file_close(file_input);
    file_close(file_output);
    wait;
  end process;

    p_CLK_GEN : process is begin
        wait for c_CLOCK_PERIOD/2;
        r_CLOCK <= not r_CLOCK;
    end process p_CLK_GEN; 

end Behavioural;
