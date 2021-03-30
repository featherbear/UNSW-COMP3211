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
        GENERIC MAP (n => 20)
        PORT MAP (
            clk => clk,
            
            dIn(19 DOWNTO 16) => addrIn,
            dOut(19 DOWNTO 16) => addr,
            
            dIn(15 DOWNTO 0) => instrIn,
            dOut(15 DOWNTO 0) => instr
        );

end Behavioral;
