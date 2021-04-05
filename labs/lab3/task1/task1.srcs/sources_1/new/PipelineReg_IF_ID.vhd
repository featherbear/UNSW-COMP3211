library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineReg_IF_ID is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           writeDisable : in STD_LOGIC;
           instrIn : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           instr   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
end PipelineReg_IF_ID;

architecture Behavioral of PipelineReg_IF_ID is

begin
    reg: entity work.PipelineRegister
        GENERIC MAP (n => 16)
        PORT MAP (
            clk => clk,
            rst => rst,
            writeDisable => writeDisable,
            dIn(15 DOWNTO 0) => instrIn,
            dOut(15 DOWNTO 0) => instr
        );

end Behavioral;
