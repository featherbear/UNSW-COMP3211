---------------------------------------------------------------------------
-- instruction_memory.vhd - Implementation of A Single-Port, 16 x 16-bit
--                          Instruction Memory.
-- 
-- Notes: refer to headers in single_cycle_core.vhd for the supported ISA.
--
-- Copyright (C) 2006 by Lih Wen Koh (lwkoh@cse.unsw.edu.au)
-- All Rights Reserved. 
--
-- The single-cycle processor core is provided AS IS, with no warranty of 
-- any kind, express or implied. The user of the program accepts full 
-- responsibility for the application of the program and the use of any 
-- results. This work may be downloaded, compiled, executed, copied, and 
-- modified solely for nonprofit, educational, noncommercial research, and 
-- noncommercial scholarship purposes provided that this notice in its 
-- entirety accompanies all copies. Copies of the modified software can be 
-- delivered to persons who use it solely for nonprofit, educational, 
-- noncommercial research, and noncommercial scholarship purposes provided 
-- that this notice in its entirety accompanies all copies.
--
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_memory is
    port ( reset    : in  std_logic;
           clk      : in  std_logic;
           addr_in  : in  std_logic_vector(3 downto 0);
           insn_out : out std_logic_vector(15 downto 0) );
end instruction_memory;

architecture behavioral of instruction_memory is

type mem_array is array(0 to 15) of std_logic_vector(15 downto 0);
signal sig_insn_mem : mem_array;

begin
    mem_process: process ( clk,
                           addr_in ) is
  
    variable var_insn_mem : mem_array;
    variable var_addr     : integer;
  
    begin
        if (reset = '1') then

            -- :: python3 ::
            -- toBin = lambda x: re.findall('....', bin(x)[2:].zfill(16))
            -- toHex = lambda x: hex(int("".join(x), 2))
            -- :::::::::::::
            
            var_insn_mem(0)  := X"1010"; --  insn_0 : load  $1, $0, 0   - load data 0($0) into $1
            var_insn_mem(1)  := X"1021"; --  insn_1 : load  $2, $0, 1   - load data 1($0) into $2
            var_insn_mem(2)  := X"8013"; --  insn_2 : add   $3, $0, $1  - $3 <- $0 + $1
            var_insn_mem(3)  := X"8124"; --  insn_3 : add   $4, $1, $2  - $4 <- $1 + $2
            var_insn_mem(4)  := X"3032"; --  insn_4 : store $3, $0, 2   - store data $3 into 2($0)
            var_insn_mem(5)  := X"3043"; --  insn_5 : store $4, $0, 3   - store data $4 into 3($0)
            
            -- sll $5, $1, $3 ($5 = 5 << 5)
            ---- toHex(['1100', '0001', '0011', '0101'])
            var_insn_mem(6)  := X"C135";
            
            -- sll $6, $1, $2 ($6 = 5 << 8)
            ---- toHex(['1100', '0001', '0010', '0110'])    
            var_insn_mem(7)  := X"C126";
            
            -- bne $2, $2, 0
            ---- toHex(['1101', '0010', '0010', '0000'])
            ---- shouldn't jump
            var_insn_mem(8)  := X"D220";
            
            -- bne $1, $3, 0
            ---- toHex(['1101', '0001', '0011', '0000'])
            ---- shouldn't jump
            var_insn_mem(9)  := X"D130";
            
            -- bne $2, $3, 0
            ---- toHex(['1101', '0010', '0011', '0000'])
            ---- should jump to instruction 0
            var_insn_mem(10) := X"D230";
            
            var_insn_mem(11) := X"0000";
            var_insn_mem(12) := X"0000";
            var_insn_mem(13) := X"0000";
            var_insn_mem(14) := X"0000";
            var_insn_mem(15) := X"0000";
        
        elsif (rising_edge(clk)) then
            -- read instructions on the rising clock edge
            var_addr := conv_integer(addr_in);
            insn_out <= var_insn_mem(var_addr);
        end if;

        -- the following are probe signals (for simulation purpose)
        sig_insn_mem <= var_insn_mem;

    end process;
  
end behavioral;
