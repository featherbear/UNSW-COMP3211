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
 
        extPort : in STD_LOGIC_VECTOR (15 downto 0);
        extPort_out : out STD_LOGIC_VECTOR (15 downto 0);
        procData : in STD_LOGIC_VECTOR (31 downto 0);
        procData_out : out STD_LOGIC_VECTOR (31 downto 0);
        netData : in STD_LOGIC_VECTOR (39 downto 0);
        netData_out : out STD_LOGIC_VECTOR (39 downto 0);
        procParity : in STD_LOGIC;
        procParity_out : out STD_LOGIC;

        insn_in     : in  std_logic_vector(15 downto 0);
        insn_out    : out std_logic_vector(15 downto 0)
    );
end pipeReg_IFID;

architecture behavioral of pipeReg_IFID is
begin
    tick : process(clk)
    begin
        if (rising_edge(clk)) then
            extPort_out <= extPort;
            procData_out <= procData;
            netData_out <= netData;
            procParity_out <= procParity;
            insn_out <= insn_in;
        end if;
    end process;
end behavioral;
