----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 23:05:28
-- Design Name: 
-- Module Name: TB_bit_flip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_bit_flip is
--  Port ( );
end TB_bit_flip;

architecture Behavioral of TB_bit_flip is
    signal d0, d1, d2, d3 : std_logic_vector(7 downto 0);
    signal d_bf0, d_bf1, d_bf2, d_bf3: std_logic_vector(7 downto 0); 
    SIGNAL BF : std_logic_vector (3 downto 0);

begin

uut0: entity work.bit_flip port map (data_in => d0,
                            data_out => d_bf0,
                            flip => BF(0));
                            
uut1: entity work.bit_flip port map (data_in => d1,
                            data_out => d_bf1,
                            flip => BF(1));
                                                          
uut2: entity work.bit_flip port map (data_in => d2,
                            data_out => d_bf2,
                            flip => BF(2));
                            
uut3: entity work.bit_flip port map (data_in => d3,
                            data_out => d_bf3,
                            flip => BF(3));   
                            
process begin
    
    BF <= "0000"; wait for 50ns;
    d0 <= "00000000"; wait for 50ns;
    d1 <= "00000000"; wait for 50ns;
    d2 <= "00000000"; wait for 50ns;
    d3 <= "00000000"; 
    wait for 50ns; -- 0
    BF <= "1111"; wait for 50ns;
    d0 <= "00000000"; wait for 50ns;
    d1 <= "00000000"; wait for 50ns;
    d2 <= "00000000"; wait for 50ns;
    d3 <= "00000000"; 
    wait for 50ns;
    
    
end process;

end Behavioral;
