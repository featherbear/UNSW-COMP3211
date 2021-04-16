---------------------------------------------------------------------------
-- forwarding control unit by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity forwarding_control_unit is
    port (
        IDEX_rs     : in  std_logic_vector(3 downto 0);
        IDEX_rt     : in  std_logic_vector(3 downto 0);
        EXMEM_rd    : in  std_logic_vector(3 downto 0);
        MEMWB_rd    : in  std_logic_vector(3 downto 0);

        EXMEM_RegWrite : in std_logic;
        MEMWB_RegWrite : in std_logic;

        ForwardA    : out std_logic_vector(1 downto 0);
        ForwardB    : out std_logic_vector(1 downto 0)
    );
end forwarding_control_unit;

architecture behavioral of forwarding_control_unit is
begin
    process(IDEX_rs, IDEX_rt, EXMEM_rd, MEMWB_rd, EXMEM_RegWrite, MEMWB_RegWrite)
    begin
        -- EX Hazard
        if (EXMEM_RegWrite = '1'
            and not(EXMEM_rd = 0)
            and EXMEM_rd = IDEX_rs) then
            ForwardA <= "01";
            
        elsif (EXMEM_RegWrite = '1'
            and not(EXMEM_rd = 0)
            and EXMEM_rd = IDEX_rt) then
            ForwardB <= "01";
    
        -- MEM Hazard
        elsif (MEMWB_RegWrite = '1'
            and not(MEMWB_rd = 0)
            and MEMWB_rd = IDEX_rs) then
            ForwardA <= "10";
        elsif (MEMWB_RegWrite = '1'
            and not(MEMWB_rd = 0)
            and MEMWB_rd = IDEX_rt) then
            ForwardB <= "10";
    
        -- Default case
        else
            ForwardA <= "00";
            ForwardB <= "00";
        end if;
        --wait for 10ns;
    end process;
end behavioral;