library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PipelineRegister is
    Generic ( n : INTEGER );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           writeDisable: in STD_LOGIC;
           dIn : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
           dOut : out STD_LOGIC_VECTOR(n-1 DOWNTO 0)
         );
end PipelineRegister;

architecture Behavioural of PipelineRegister is
begin
    process (rst, clk) begin
        if (rst = '1') then
            dOut <= (others => '0');
        elsif (clk'event and falling_edge(clk)) then
            if (writeDisable = '0') then
               dOut <= dIn;
            end if;
        end if;
    end process;
end Behavioural;
