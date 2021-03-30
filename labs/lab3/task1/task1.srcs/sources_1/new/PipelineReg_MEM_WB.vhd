library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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


end Behavioral;
