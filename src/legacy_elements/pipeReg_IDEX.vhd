---------------------------------------------------------------------------
-- pipeline register by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipeReg_IDEX is
    port (
        -- Control signals
        clk     : in  std_logic;
        reset   : in  std_logic;
        EX_in   : in  std_logic_vector(3 downto 0);
        M_in    : in  std_logic_vector(2 downto 0);
        WB_in   : in  std_logic_vector(1 downto 0);
        EX_out  : out std_logic_vector(3 downto 0);
        M_out   : out std_logic_vector(2 downto 0);
        WB_out  : out  std_logic_vector(1 downto 0);
        -- Data
        pc4_in      : in  std_logic_vector(3 downto 0);
        data1_in    : in  std_logic_vector(15 downto 0);
        data2_in    : in  std_logic_vector(15 downto 0);
        rs_in       : in  std_logic_vector(3 downto 0);
        rt_in       : in  std_logic_vector(3 downto 0);
        rd_in       : in  std_logic_vector(3 downto 0);

        pc4_out     : out  std_logic_vector(3 downto 0);
        data1_out   : out  std_logic_vector(15 downto 0);
        data2_out   : out  std_logic_vector(15 downto 0);
        rs_out      : out  std_logic_vector(3 downto 0);
        rt_out      : out  std_logic_vector(3 downto 0);
        rd_out      : out  std_logic_vector(3 downto 0)
    );
end pipeReg_IDEX;

architecture behavioral of pipeReg_IDEX is
begin
    tick : process(clk) is
    begin
        if (reset = '1') then
            pc4_out     <= "0000";
        elsif (rising_edge(clk)) then
            EX_out  <= EX_in;
            M_out   <= M_in;
            WB_out  <= WB_in;

            pc4_out     <= pc4_in;
            data1_out   <= data1_in;
            data2_out   <= data2_in;
            rs_out      <= rs_in;
            rt_out      <= rt_in;
            rd_out      <= rd_in;
        end if;
    end process;
end behavioral;
