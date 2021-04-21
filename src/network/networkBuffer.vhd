library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity networkBuffer is
    port (
        clk         : in  std_logic;

        extPort : in STD_LOGIC_VECTOR (15 downto 0);
        extPort_out : out STD_LOGIC_VECTOR (15 downto 0);
        
        procData : in STD_LOGIC_VECTOR (31 downto 0);
        procData_out : out STD_LOGIC_VECTOR (31 downto 0);
        
        netData : in STD_LOGIC_VECTOR (39 downto 0);
        netData_out : out STD_LOGIC_VECTOR (39 downto 0);
        
        procParity : in STD_LOGIC;
        procParity_out : out STD_LOGIC
    );
end networkBuffer;

architecture behavioral of networkBuffer is
begin
    tick : process(clk)
    begin
        if (rising_edge(clk)) then
            extPort_out <= extPort;
            procData_out <= procData;
            netData_out <= netData;
            procParity_out <= procParity;
        end if;
    end process;
end behavioral;
