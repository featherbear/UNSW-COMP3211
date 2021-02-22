library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity add3_TB is
end add3_TB;

architecture Behavioral of add3_TB is

    component add3
    PORT(
        A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        C: in std_logic_vector(7 downto 0);
        S: out std_logic_vector(7 downto 0));
    end component;

    --Inputs
    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    signal C : std_logic_vector(7 downto 0);
    --Outputs
    signal S : std_logic_vector(7 downto 0);
    
    signal clk: std_logic;
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut:   add3 PORT map (
        A => A,
        B => B,
        C => C,
        S => S
      );
        
   -- Clodk process defintions
   clk_process  : process is
   begin
       clk <= '0';
       wait for clk_period/2;
       clk <= '1';
       wait for clk_period/2;
   end process;
   
  -- random inputs in the range of 0-50
  stimulus: process is
    variable seed1 : positive :=0;
    variable seed2 : positive :=0;
    variable x : real;
    variable y : real;
    variable z : real;
  begin
    seed1 := seed1 + 1;
    seed2 := seed2 + 1;
    wait until rising_edge(clk);
      uniform(seed1, seed2, x);
      uniform(seed1, seed2, y);
      uniform(seed1, seed2, z);
      A <= conv_std_logic_vector(integer(floor(x * 50.0)), 8);
      B <= conv_std_logic_vector(integer(floor(y * 50.0)), 8);
      C <= conv_std_logic_vector(integer(floor(z * 50.0)), 8);
  end process;

end Behavioral;
