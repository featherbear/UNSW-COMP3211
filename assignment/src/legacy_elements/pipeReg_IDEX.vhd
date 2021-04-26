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

        ctrl_is_net_op     : in std_logic;
        ctrl_is_net_op_out : out std_logic;
        ctrl_mem_write     : in std_logic;
        ctrl_mem_write_out : out std_logic;
        ctrl_reg_write     : in std_logic;
        ctrl_reg_write_out : out std_logic;
        ctrl_direction     : in std_logic;
        ctrl_direction_out : out std_logic;
        
        data    : in  std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0);
        
        tag_parity : in std_logic_vector(7 downto 0);
        tag_parity_out : out std_logic_vector(7 downto 0);
        
        ext_key : in std_logic_vector(15 downto 0);
        ext_key_out : out std_logic_vector(15 downto 0);
        
        key : in std_logic_vector(15 downto 0);
        key_out : out std_logic_vector(15 downto 0)
    );
end pipeReg_IDEX;

architecture behavioral of pipeReg_IDEX is
begin
    tick : process(clk) is
    begin
        if (rising_edge(clk)) then
            ctrl_is_net_op_out <= ctrl_is_net_op;
            ctrl_mem_write_out <= ctrl_mem_write;
            ctrl_reg_write_out <= ctrl_reg_write;
            ctrl_direction_out <= ctrl_direction;

            data_out <= data;
            tag_parity_out <= tag_parity;
            ext_key_out <= ext_key;
            key_out <= key;
        end if;
    end process;
end behavioral;
