---------------------------------------------------------------------------
-- pipeline register by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipeReg_EXMEM is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        -- Control lines
        M_in    : in  std_logic_vector(2 downto 0);
        WB_in   : in  std_logic_vector(1 downto 0);
        M_out   : out std_logic_vector(2 downto 0);
        WB_out  : out  std_logic_vector(1 downto 0);
        -- Actual data
        jmpaddr_in  : in std_logic_vector(3 downto 0);
        ALU_zero_in : in std_logic;
        ALU_res_in  : in std_logic_vector(15 downto 0);
        data_in     : in std_logic_vector(15 downto 0);
        rd_in       : in std_logic_vector(3 downto 0);

        jmpaddr_out : out std_logic_vector(3 downto 0);
        ALU_zero_out: out std_logic;
        ALU_res_out : out std_logic_vector(15 downto 0);
        data_out    : out std_logic_vector(15 downto 0);
        rd_out      : out std_logic_vector(3 downto 0)
    );
end pipeReg_EXMEM;

architecture behavioral of pipeReg_EXMEM is
begin
    tick : process(clk)
    begin
        if (reset = '1') then
            jmpaddr_out <= "0000";
        elsif (rising_edge(clk)) then
            M_out       <= M_in;
            WB_out      <= WB_in;
            jmpaddr_out <= jmpaddr_in;
            ALU_zero_out <= ALU_zero_in;
            ALU_res_out <= ALU_res_in;
            data_out    <= data_in;
            rd_out      <= rd_in;
        end if;
    end process;
end behavioral;
