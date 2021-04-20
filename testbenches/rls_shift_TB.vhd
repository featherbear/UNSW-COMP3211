----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2021 00:36:57
-- Design Name: 
-- Module Name: TB_leftshift - Behavioral
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

entity TB_leftshift is
--  Port ( );
end TB_leftshift;

architecture Behavioral of TB_leftshift is
    signal d_bf0, d_bf1, d_bf2, d_bf3: std_logic_vector(7 downto 0); 
    signal d_rls0, d_rls1, d_rls2, d_rls3 : std_logic_vector(7 downto 0); 
    signal R : std_logic_vector(11 downto 0);
begin

    uut0: entity work.rlshift port map (src  => d_bf0, -- Change to d_bf(7 downto 0) if needed
                                shft => R(2 downto 0), -- Change to R0 if needed
                                res  => d_rls0);

    uut1: entity work.rlshift port map (src  => d_bf1,
                                shft => R(5 downto 3),
                                res  => d_rls1);

    uut2: entity work.rlshift port map (src  => d_bf2,
                                shft => R(8 downto 6),
                                res  => d_rls2);

    uut3: entity work.rlshift port map (src  => d_bf3,
                                shft => R(11 downto 9),
                                res  => d_rls3);
                                
                                
process begin
    
    R <= "000000000000"; -- no shift
    d_bf0 <= "00000001";
    d_bf1 <= "00000001";
    d_bf2 <= "00000001";
    d_bf3 <= "00000001";
    wait for 50ns;
    
    R <= "001001001001"; -- shift left once
    d_bf0 <= "00000001";
    d_bf1 <= "00000001";
    d_bf2 <= "00000001";
    d_bf3 <= "00000001";
    wait for 50ns;
    
    R <= "001001001001"; -- shift left once check that the rotation works
    d_bf0 <= "10000000";
    d_bf1 <= "10000000";
    d_bf2 <= "10000000";
    d_bf3 <= "10000000";
    wait for 50ns;
    
    R <= "100100100100"; -- shift left 4 times
    d_bf0 <= "00000011";
    d_bf1 <= "00000011";
    d_bf2 <= "00000011";
    d_bf3 <= "00000011";
    wait for 50ns;
    
    R <= "111111111111"; -- shift left 7 times
    d_bf0 <= "10000000";
    d_bf1 <= "10000000";
    d_bf2 <= "10000000";
    d_bf3 <= "10000000";
    wait for 50ns;
    
end process;


end Behavioral;
