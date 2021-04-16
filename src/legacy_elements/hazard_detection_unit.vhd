---------------------------------------------------------------------------
-- hazard detection unit by Lindsay Small March 2021
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hazard_detection_unit is
    port (
        IDEX_memread    : in  std_logic;
        IFID_rs         : in  std_logic_vector(3 downto 0);
        IFID_rt         : in  std_logic_vector(3 downto 0);
        IDEX_rt         : in  std_logic_vector(3 downto 0);
        
        stall           : out std_logic
    );
end hazard_detection_unit;

architecture behavioral of hazard_detection_unit is
constant OP_LOAD  : std_logic_vector(3 downto 0) := "0001";

begin
    process(IDEX_memread, IFID_rs, IFID_rt, IDEX_rt)
    begin
        -- Is the instruction reading from memory (must be LOAD)
        if (IDEX_memread = '1') and 
            -- does rs or rt match the LOAD destination
            ((IFID_rs = IDEX_rt) or (IFID_rt = IDEX_rt)) then
                stall <= '1';
        -- else we good
        else
            stall <= '0';
        end if;
    end process;
end behavioral;