library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineReg_IF_ID is
    Port ( clk : in STD_LOGIC;

           -- BEGIN passthrough registers
           ctrl_MemToRegIN  : in STD_LOGIC;
           ctrl_MemToReg    : out STD_LOGIC;        
           ctrl_RegWriteIN  : in STD_LOGIC;
           ctrl_RegWrite    : out STD_LOGIC;
           ctrl_EnableJumpPCIN : in STD_LOGIC;
           ctrl_EnableJumpPC   : out STD_LOGIC;
           ctrl_MemWriteIN  : in STD_LOGIC;
           ctrl_MemWrite    : out STD_LOGIC;
           ctrl_ALUSrcIN  : in STD_LOGIC;
           ctrl_ALUSrc    : out STD_LOGIC;
           ctrl_ALUOperationIN  : in STD_LOGIC;
           ctrl_ALUOperation    : out STD_LOGIC;
           -- END passthrough registers

           addrIn  : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           addr    : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           
           instrIn : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           instr   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
end PipelineReg_IF_ID;

architecture Behavioral of PipelineReg_IF_ID is

begin
    reg: entity work.PipelineRegister
        GENERIC MAP (n => 6 + 20)
        PORT MAP (
            clk => clk,
            
            dIn(25) => ctrl_MemToRegIN,
            dIn(24) => ctrl_RegWriteIN,
            dIn(23) => ctrl_EnableJumpPCIN,
            dIn(22) => ctrl_MemWriteIN,
            dIn(21) => ctrl_ALUSrcIN,
            dIn(20) => ctrl_ALUOperationIN,
            dOut(25) => ctrl_MemToReg,
            dOut(24) => ctrl_RegWrite,
            dOut(23) => ctrl_EnableJumpPC,
            dOut(22) => ctrl_MemWrite,
            dOut(21) => ctrl_ALUSrc,
            dOut(20) => ctrl_ALUOperation,
             
            dIn(19 DOWNTO 16) => addrIn,
            dIn(15 DOWNTO 0) => instrIn,
            dOut(19 DOWNTO 16) => addr,
            dOut(15 DOWNTO 0) => instr
        );

end Behavioral;
