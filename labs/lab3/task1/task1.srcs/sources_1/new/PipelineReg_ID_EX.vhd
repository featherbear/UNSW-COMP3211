----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 23:27:54
-- Design Name: 
-- Module Name: PipelineReg_ID_EX - Behavioral
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

entity PipelineReg_ID_EX is
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
           -- END passthrough registers
    
           ctrl_ALUSrcIN  : in STD_LOGIC;
           ctrl_ALUSrc    : out STD_LOGIC;

           ctrl_ALUOperationIN  : in STD_LOGIC;
           ctrl_ALUOperation    : out STD_LOGIC;
           
           -- BEGIN passthrough data
           WBAddrIN : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           WBAddr   : out STD_LOGIC_VECTOR(3 DOWNTO 0);    
           -- END passthrough data

           RegData1IN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           RegData1   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           RegData2IN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           RegData2   : out STD_LOGIC_VECTOR(15 DOWNTO 0);
           
           SignExtendDataIN : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           SignExtendData   : out STD_LOGIC_VECTOR(15 DOWNTO 0) 
       );
end PipelineReg_ID_EX;

architecture Behavioral of PipelineReg_ID_EX is

begin
 reg: entity work.PipelineRegister
        GENERIC MAP (n => 6 + 52)
        PORT MAP (
          clk => clk,

          dIn(57) => ctrl_MemToRegIN,
          dIn(56) => ctrl_RegWriteIN,
          dIn(55) => ctrl_EnableJumpPCIN,
          dIn(54) => ctrl_MemWriteIN,
          dIn(53) => ctrl_ALUSrcIN,
          dIn(52) => ctrl_ALUOperationIN,
          dOut(57) => ctrl_MemToReg,
          dOut(56) => ctrl_RegWrite,
          dOut(55) => ctrl_EnableJumpPC,
          dOut(54) => ctrl_MemWrite,
          dOut(53) => ctrl_ALUSrc,
          dOut(52) => ctrl_ALUOperation,
          
          dIn(51 DOWNTO 48) => WBAddrIN,
          dIn(47 DOWNTO 32) => RegData1IN,
          dIn(31 DOWNTO 16) => RegData2IN,
          dIn(15 DOWNTO 0) => SignExtendDataIN,   
          dOut(51 DOWNTO 48) => WBAddr,
          dOut(47 DOWNTO 32) => RegData1,
          dOut(31 DOWNTO 16) => RegData2,
          dOut(15 DOWNTO 0) => SignExtendData
        );

end Behavioral;
