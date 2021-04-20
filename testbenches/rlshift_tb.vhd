library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    COMPONENT test is     
        port ( src  : in  std_logic_vector(7 downto 0);
               shft : in  std_logic_vector(2 downto 0);
               res  : out std_logic_vector(7 downto 0));
    END COMPONENT;
    
    -- INPUTS
    SIGNAL src : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL shft : STD_LOGIC_VECTOR(2 DOWNTO 0);
    
    -- OUTPUTS
    SIGNAL res : STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    -- CLOCK
    SIGNAL Clock: STD_LOGIC;
    CONSTANT clk_period: time := 10ns;
    
begin
    -- Unit Under Test (UUT)
    uut: test PORT MAP (src => src,
                        shft => shft,
                        res => res);

    
    -- Clock process definitions
    clk_process : process is
    begin
       clock <= '0';
       wait for clk_period/2;
       clock <= '1';
       wait for clk_period/2;
    end process;
    
    -- Reset process definitions
--    rst_process : process is
--    begin
--        reset <= '1';
--        wait for clk_period;
--        reset <= '0';
--        wait for 8*clk_period;
--    end process;
    
    stimulus : process is 
        variable seed1 : positive :=0; -- uniform needs two seed variables to work
        variable seed2 : positive :=0;
        variable var1 : real;
        variable var2 : real;
        
    begin
        seed1 := seed1 + 1;
        seed2 := seed2 + 1; 
        wait until rising_edge(clock);
        uniform(seed1, seed2, var1);
        uniform(seed1, seed2, var2);
        src <= conv_std_logic_vector(integer(floor(var1 * 255.0)), 8);
        shft <= conv_std_logic_vector(integer(floor(var2 * 7.0)), 3);
        
    end process;
end Behavioral;