----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 23:28:06
-- Design Name: 
-- Module Name: PipelineReg_EX_MEM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PipelineReg_EX_MEM is
    Port ( clk : in STD_LOGIC;

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
           
           ALUResultIN : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           ALUResult   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           dataMemoryWriteIN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           dataMemoryWrite   : out STD_LOGIC_VECTOR(15 DOWNTO 0)
   );
end PipelineReg_EX_MEM;

architecture Behavioral of PipelineReg_EX_MEM is

begin


end Behavioral;
