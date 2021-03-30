library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineReg_EX_MEM is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;

           -- BEGIN passthrough registers
           ctrl_MemToRegIN  : in STD_LOGIC;
           ctrl_MemToReg    : out STD_LOGIC;        
           ctrl_RegWriteIN  : in STD_LOGIC;
           ctrl_RegWrite    : out STD_LOGIC;
           -- END passthrough registers
    
           ctrl_EnableJumpPCIN : in STD_LOGIC;
           ctrl_EnableJumpPC   : out STD_LOGIC;
                         
           ctrl_MemWriteIN  : in STD_LOGIC;
           ctrl_MemWrite    : out STD_LOGIC;
           
           ctrl_ALUFlagIN : in  STD_LOGIC;
           ctrl_ALUFlag   : out STD_LOGIC;
           
           -- BEGIN passthrough data
           WBAddrIN : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           WBAddr   : out STD_LOGIC_VECTOR(3 DOWNTO 0);    
           -- END passthrough data
           
           PotentialPCIN : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           PotentialPC : out STD_LOGIC_VECTOR(3 DOWNTO 0);
           
           ALUResultIN : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALUResult   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           dataMemoryWriteIN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           dataMemoryWrite   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
   );
end PipelineReg_EX_MEM;

architecture Behavioral of PipelineReg_EX_MEM is

begin
 reg: entity work.PipelineRegister
        GENERIC MAP (n => 5 + 40)
        PORT MAP (
          clk => clk,
          rst => rst,
          writeDisable => '0',
          
          dIn(44)  => ctrl_MemToRegIN,
          dIn(43)  => ctrl_RegWriteIN,
          dIn(42) => ctrl_EnableJumpPCIN,
          dIn(41) => ctrl_MemWriteIN,
          dIn(40) => ctrl_ALUFlagIN,
          dIn(39 DOWNTO 36) => WBAddrIN,
          dIn(35 DOWNTO 32) => PotentialPCIN,
          dIn(31 DOWNTO 16) => ALUResultIN,
          dIn(15 DOWNTO 0) => dataMemoryWriteIN,

          dOut(44)  => ctrl_MemToReg,
          dOut(43)  => ctrl_RegWrite,
          dOut(42) => ctrl_EnableJumpPC,
          dOut(41) => ctrl_MemWrite,
          dOut(40) => ctrl_ALUFlag,
          dOut(39 DOWNTO 36) => WBAddr,
          dOut(35 DOWNTO 32) => PotentialPC,
          dOut(31 DOWNTO 16) => ALUResult,
          dOut(15 DOWNTO 0) => dataMemoryWrite
        );

end Behavioral;
