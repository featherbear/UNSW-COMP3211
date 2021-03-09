---------------------------------------------------------------------------
-- control_unit.vhd - Control Unit Implementation
--
-- Notes: refer to headers in single_cycle_core.vhd for the supported ISA.
--
--  control signals:
--     reg_dst    : asserted for ADD instructions, so that the register
--                  destination number for the 'write_register' comes from
--                  the rd field (bits 3-0). 
--     reg_write  : asserted for ADD and LOAD and SLL instructions, so that the
--                  register on the 'write_register' input is written with
--                  the value on the 'write_data' port.
--     alu_src    : asserted for LOAD and STORE instructions, so that the
--                  second ALU operand is the sign-extended, lower 4 bits
--                  of the instruction.
--     mem_write  : asserted for STORE instructions, so that the data 
--                  memory contents designated by the address input are
--                  replaced by the value on the 'write_data' input.
--     mem_to_reg : asserted for LOAD instructions, so that the value fed
--                  to the register 'write_data' input comes from the
--                  data memory.
--     alu_operation : asserted for SLL instructions, so that the ALU will use
--                     the results of the SLL unit instead of the ADD unit
--     enable_jump_pc : asserted for BEQ instructions, allows possible PC rewrite    
--
--
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

entity control_unit is
    port ( opcode     : in  std_logic_vector(3 downto 0);
           reg_dst    : out std_logic;
           reg_write  : out std_logic;
           alu_src    : out std_logic;
           mem_write  : out std_logic;
           mem_to_reg : out std_logic;
           --
           alu_operation : out std_logic;
           enable_jump_pc : out std_logic
           --
           );
end control_unit;

architecture behavioural of control_unit is

constant OP_LOAD  : std_logic_vector(3 downto 0) := "0001";
constant OP_STORE : std_logic_vector(3 downto 0) := "0011";
constant OP_ADD   : std_logic_vector(3 downto 0) := "1000";
constant OP_SLL   : std_logic_vector(3 downto 0) := "1100";
constant OP_BNE   : std_logic_vector(3 downto 0) := "1101";

begin

    reg_dst    <= '1' when (opcode = OP_ADD
                            or opcode = OP_SLL) else
                  '0';
                  
    --
    alu_operation <= '1' when (opcode = OP_SLL
                               or opcode = OP_BNE -- Switches ALU carry/flag
                              ) else '0';
    
    enable_jump_pc <= '1' when (opcode = OP_BNE) else '0';
    --
    
    reg_write  <= '1' when (opcode = OP_ADD 
                            or opcode = OP_LOAD
                            or opcode = OP_SLL) else
                  '0';
    
    alu_src    <= '1' when (opcode = OP_LOAD 
                           or opcode = OP_STORE) else
                  '0';
                 
    mem_write  <= '1' when opcode = OP_STORE else
                  '0';
                 
    mem_to_reg <= '1' when opcode = OP_LOAD else
                  '0';

end behavioural;
