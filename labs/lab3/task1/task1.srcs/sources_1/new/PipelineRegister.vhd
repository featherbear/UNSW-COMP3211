library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineRegister is
    Generic ( n : INTEGER );
    Port ( clk : in STD_LOGIC;
           dIn : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
           dOut : out STD_LOGIC_VECTOR(n-1 DOWNTO 0)
         );
end PipelineRegister;

architecture Behavioural of PipelineRegister is
begin
    process (clk, dIn) begin
        if (clk'event and falling_edge(clk)) then
            dOut <= dIn;
        end if;
    end process;
end Behavioural;
