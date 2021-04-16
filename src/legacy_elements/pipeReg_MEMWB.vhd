---------------------------------------------------------------------------
-- pipeline register by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipeReg_MEMWB is
    port (
        -- control signals
        clk     : in  std_logic;
        WB_in   : in  std_logic_vector(1 downto 0);
        WB_out  : out  std_logic_vector(1 downto 0);
        --data
        read_data_in    : in std_logic_vector(15 downto 0);
        alu_result_in   : in std_logic_vector(15 downto 0);
        rd_in           : in std_logic_vector(3 downto 0);
        
        read_data_out   : out std_logic_vector(15 downto 0);
        alu_result_out  : out std_logic_vector(15 downto 0);
        rd_out          : out std_logic_vector(3 downto 0)
    );
end pipeReg_MEMWB;

architecture behavioral of pipeReg_MEMWB is
begin
    tick : process(clk)
    begin
        if (rising_edge(clk)) then
            WB_out          <= WB_in;
            read_data_out   <= read_data_in;
            alu_result_out  <= alu_result_in;
            rd_out          <= rd_in;
        end if;
    end process;
end behavioral;
