library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineReg_IF_ID is
    Port ( clk : in STD_LOGIC;
    
           addrIn  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           addr    : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           
           instrIn : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           instr   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
end PipelineReg_IF_ID;

architecture Behavioral of PipelineReg_IF_ID is

begin
    reg: entity work.PipelineRegister
        GENERIC MAP (n => 20)
        PORT MAP (
            clk => clk,
            
            dIn(19 DOWNTO 16) => addrIn,
            dOut(19 DOWNTO 16) => addr,
            
            dIn(15 DOWNTO 0) => instrIn,
            dOut(15 DOWNTO 0) => instr
        );

end Behavioral;
