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

        ctrl_is_net_op     : in std_logic;
        ctrl_is_net_op_out : out std_logic;
        ctrl_mem_write     : in std_logic;
        ctrl_mem_write_out : out std_logic;
        ctrl_reg_write     : in std_logic;
        ctrl_reg_write_out : out std_logic;
        ctrl_direction     : in std_logic;
        ctrl_direction_out : out std_logic;

        tag : in std_logic_vector(7 downto 0);
        tag_out : out std_logic_vector(7 downto 0);
        
        tag_err : in std_logic;
        tag_err_out : out std_logic;
        
        p_err : in std_logic;
        p_err_out : out std_logic;
        
        data : in std_logic_vector(31 downto 0);
        data_out : out std_logic_vector(31 downto 0);
        
        ext_key : in std_logic_vector(15 downto 0);
        ext_key_out : out std_logic_vector(15 downto 0)
    );
end pipeReg_EXMEM;

architecture behavioral of pipeReg_EXMEM is
begin
    tick : process(clk)
    begin
        if (rising_edge(clk)) then
            ctrl_is_net_op_out <= ctrl_is_net_op;
            ctrl_mem_write_out <= ctrl_mem_write;
            ctrl_reg_write_out <= ctrl_reg_write;
            ctrl_direction_out <= ctrl_direction;
        
            tag_out <= tag;
            tag_err_out <= tag_err;
            p_err_out <= p_err;
            data_out <= data;
            ext_key_out <= ext_key;
        end if;
    end process;
end behavioral;
