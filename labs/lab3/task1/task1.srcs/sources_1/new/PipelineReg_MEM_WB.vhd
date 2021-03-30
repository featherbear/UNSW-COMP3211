library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineReg_MEM_WB is
    Port ( clk : in STD_LOGIC;

           ctrl_MemToRegIN  : in STD_LOGIC;
           ctrl_MemToReg    : out STD_LOGIC;
           
           ctrl_RegWriteIN  : in STD_LOGIC;
           ctrl_RegWrite    : out STD_LOGIC;
           
           ALUResultIN : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALUResult   : out STD_LOGIC_VECTOR(15 DOWNTO 0);

           WBAddrIN : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           WBAddr   : out STD_LOGIC_VECTOR(3 DOWNTO 0);    
                  
           dataMemoryIN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           dataMemory   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
end PipelineReg_MEM_WB;

architecture Behavioral of PipelineReg_MEM_WB is

begin
 reg: entity work.PipelineRegister
        GENERIC MAP (n => 2 + 36)
        PORT MAP (
          clk => clk,
         
          dIn(37) => ctrl_MemToRegIN,
          dIn(36) => ctrl_RegWriteIN,
          dOut(37) => ctrl_MemToReg,
          dOut(36) => ctrl_RegWrite,
         
          dIn(35 DOWNTO 20) => ALUResultIN,
          dIn(19 DOWNTO 16) => WBAddrIN,
          dIn(15 DOWNTO 0) => dataMemoryIN,
          dOut(35 DOWNTO 20) => ALUResult,
          dOut(19 DOWNTO 16) => WBAddr,
          dOut(15 DOWNTO 0) => dataMemory
        );

end Behavioral;
