---------------------------------------------------------------------------
-- pipeline register by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipeReg_IFID is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;

        pc4_in      : in  std_logic_vector(3 downto 0);
        insn_in     : in  std_logic_vector(15 downto 0);
        
        pc4_out     : out std_logic_vector(3 downto 0);
        insn_out    : out std_logic_vector(15 downto 0)
    );
end pipeReg_IFID;

architecture behavioral of pipeReg_IFID is
begin
    tick : process(clk)
    begin
        if (reset = '1') then
            pc4_out     <= "0000";
        elsif (rising_edge(clk)) then
            pc4_out     <= pc4_in;
            insn_out    <= insn_in;
        end if;
    end process;
end behavioral;
