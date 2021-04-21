library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCController is
    Port (
        clk : in std_logic;
        
        network_ready : in std_logic;

        ASIP_ready : in std_logic;
        receive_request : in std_logic;
        send_request : in std_logic;
        loadkey_request : in std_logic;
        loadext_request : in std_logic;
        
        PC : out std_logic_vector(3 downto 0)
    );
end PCController;

architecture Behavioral of PCController is
    constant PC_NOP     : std_logic_vector(3 downto 0) := "0000";
    constant PC_RECEIVE : std_logic_vector(3 downto 0) := "0001";
    constant PC_SEND    : std_logic_vector(3 downto 0) := "0010";
    constant PC_LOADKEY : std_logic_vector(3 downto 0) := "0011";
    constant PC_LOADEXT : std_logic_vector(3 downto 0) := "0100";
begin
    func: process(clk) is begin
        if (rising_edge(clk)) then
            PC <= PC_NOP;
            
            if ASIP_ready = '1' then
                if receive_request = '1' AND network_ready = '1' then
                    PC <= PC_RECEIVE;
                elsif send_request = '1' then
                    PC <= PC_SEND;
                elsif loadkey_request = '1' then
                    PC <= PC_LOADKEY;
                elsif loadext_request = '1' then
                    PC <= PC_LOADEXT;
                end if;                                         
            end if;
        end if;
    end process;

end Behavioral;
