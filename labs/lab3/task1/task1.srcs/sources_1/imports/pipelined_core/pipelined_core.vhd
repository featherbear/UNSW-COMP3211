---------------------------------------------------------------------------
-- pipelined_core.vhd - A Single-Cycle Processor Implementation
--
-- Notes : 
--
-- See pipelined_core.pdf for the block diagram of this single
-- cycle processor core.
--
-- Instruction Set Architecture (ISA) for the single-cycle-core:
--   Each instruction is 16-bit wide, with four 4-bit fields.
--
--     noop      
--        # no operation or to signal end of program
--        # format:  | opcode = 0 |  0   |  0   |   0    | 
--
--     load  rt, rs, offset     
--        # load data at memory location (rs + offset) into rt
--        # format:  | opcode = 1 |  rs  |  rt  | offset |
--
--     store rt, rs, offset
--        # store data rt into memory location (rs + offset)
--        # format:  | opcode = 3 |  rs  |  rt  | offset |
--
--     add   rd, rs, rt
--        # rd <- rs + rt
--        # format:  | opcode = 8 |  rs  |  rt  |   rd   |
--
--     sll   rd, rs, rt
--        # rd <- rs << rt
--        # format:  | opcode = 12 |  rs  |  rt  |  rd  | 
--
--     bne   rs, rt, imm
--        # if rs != rt, PC <- imm
--        # format:  | opcode = 13 |  rs  |  rt  |  imm  | 
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

entity pipelined_core is
    port ( reset  : in  std_logic;
           clk    : in  std_logic );
end pipelined_core;

architecture structural of pipelined_core is

signal sig_next_pc              : std_logic_vector(3 downto 0);
signal sig_curr_pc              : std_logic_vector(3 downto 0);
signal sig_one_4b               : std_logic_vector(3 downto 0);
signal sig_pc_carry_out         : std_logic;
signal sig_insn                 : std_logic_vector(15 downto 0);
signal sig_sign_extended_offset : std_logic_vector(15 downto 0);
signal sig_reg_dst              : std_logic;
signal sig_reg_write            : std_logic;
signal sig_alu_src              : std_logic;
signal sig_mem_write            : std_logic;
signal sig_mem_to_reg           : std_logic;
signal sig_write_register       : std_logic_vector(3 downto 0);
signal sig_write_data           : std_logic_vector(15 downto 0);
signal sig_read_data_a          : std_logic_vector(15 downto 0);
signal sig_read_data_b          : std_logic_vector(15 downto 0);
signal sig_alu_src_b            : std_logic_vector(15 downto 0);
signal sig_alu_result           : std_logic_vector(15 downto 0); 
signal sig_alu_carry_out        : std_logic;
signal sig_data_mem_out         : std_logic_vector(15 downto 0);

--
signal sig_alu_operation        : std_logic;

signal sig_enable_jump_pc       : std_logic;
signal sig_use_jump_pc          : std_logic;
signal sig_next_pc_standard     : std_logic_vector(3 downto 0);

--

signal sig_insn_src             : std_logic_vector(15 downto 0);

signal sig_write_register_src   : std_logic_vector(3 downto 0);
signal sig_write_register_src_ex_mem  : std_logic_vector(3 downto 0);
signal sig_write_register_src_mem_wb  : std_logic_vector(3 downto 0);

signal sig_mem_to_reg_src           : std_logic;
signal sig_mem_to_reg_src_ex_mem           : std_logic;
signal sig_mem_to_reg_src_mem_wb           : std_logic;

signal sig_reg_write_src            : std_logic;
signal sig_reg_write_src_ex_mem            : std_logic;
signal sig_reg_write_src_mem_wb          : std_logic;

signal sig_enable_jump_pc_src       : std_logic;
signal sig_enable_jump_pc_src_ex_mem       : std_logic;

signal sig_mem_write_src            : std_logic;
signal sig_mem_write_src_ex_mem            : std_logic;

signal sig_alu_src_src              : std_logic;

signal sig_alu_operation_src        : std_logic;

signal sig_read_data_a_src          : std_logic_vector(15 downto 0);
signal sig_read_data_b_src          : std_logic_vector(15 downto 0);

signal sig_sign_extended_offset_src : std_logic_vector(15 downto 0);

signal sig_alu_carry_out_src        : std_logic;

signal sig_alu_result_src           : std_logic_vector(15 downto 0); 

signal sig_read_data_b_ex_mem          : std_logic_vector(15 downto 0);

signal sig_alu_result_mem_wb           : std_logic_vector(15 downto 0); 

signal sig_data_mem_out_src         : std_logic_vector(15 downto 0);

signal sig_potential_pc_id_ex : std_logic_vector(3 downto 0);
signal sig_potential_pc_ex_mem : std_logic_vector(3 downto 0);

signal sig_freeze : std_logic;
signal sig_next_pc_standard_staging              : std_logic_vector(3 downto 0);

signal resetReg  : std_logic;
signal reset_ex_mem  : std_logic;
--

begin

    sig_one_4b <= "0001";
    sig_use_jump_pc <= sig_enable_jump_pc and sig_alu_carry_out;
    
    holdUnit: entity work.holdUnit
        port map (
            src_a => sig_insn(11 downto 8),
            src_b => sig_insn(7 downto 4),
            check_1_a => sig_reg_write_src_ex_mem,
            check_1_b => sig_write_register_src_ex_mem,
            check_2_a => sig_reg_write_src_mem_wb,
            check_2_b => sig_write_register_src_mem_wb,
            check_3_a => sig_reg_write,
            check_3_b => sig_write_register,
            
            res => sig_freeze
        );

    pc : entity work.program_counter
    port map ( reset    => reset,
               clk      => clk,
               addr_in  => sig_next_pc,
               addr_out => sig_curr_pc ); 

    next_pc_standard : entity work.adder_4b 
    port map ( src_a     => sig_curr_pc, 
               src_b     => sig_one_4b,
               sum       => sig_next_pc_standard_staging,   
               carry_out => sig_pc_carry_out );
    
    next_pc_hold : entity work.mux_2to1_4b
        port map (
            mux_select => sig_freeze,
            data_a => sig_next_pc_standard_staging,
            data_b => sig_curr_pc,
            data_out => sig_next_pc_standard
        );

    next_pc : entity work.mux_2to1_4b
    port map (
        mux_select => sig_use_jump_pc,
        data_a => sig_next_pc_standard,
        data_b => sig_potential_pc_ex_mem,
        data_out => sig_next_pc  
    );
    
   
    insn_mem : entity work.instruction_memory 
    port map ( reset    => reset,
               clk      => clk,
               addr_in  => sig_curr_pc,
               insn_out => sig_insn_src );

    sign_extend : entity work.sign_extend_4to16 
    port map ( data_in  => sig_insn(3 downto 0),
               data_out => sig_sign_extended_offset_src );

    ctrl_unit : entity work.control_unit 
    port map ( opcode     => sig_insn(15 downto 12),
               reg_dst    => sig_reg_dst,
               reg_write  => sig_reg_write_src,
               alu_src    => sig_alu_src_src,
               mem_write  => sig_mem_write_src,
               mem_to_reg => sig_mem_to_reg_src,
               --
               alu_operation => sig_alu_operation_src,
               enable_jump_pc => sig_enable_jump_pc_src
               --
               );

    mux_reg_dst : entity work.mux_2to1_4b 
    port map ( mux_select => sig_reg_dst,
               data_a     => sig_insn(7 downto 4),
               data_b     => sig_insn(3 downto 0),
               data_out   => sig_write_register_src );

    reg_file : entity work.register_file 
    port map ( reset           => reset, 
               clk             => clk,
               read_register_a => sig_insn(11 downto 8),
               read_register_b => sig_insn(7 downto 4),
               write_enable    => sig_reg_write,
               write_register  => sig_write_register,
               write_data      => sig_write_data,
               read_data_a     => sig_read_data_a_src,
               read_data_b     => sig_read_data_b_src );
    
    mux_alu_src : entity work.mux_2to1_16b 
    port map ( mux_select => sig_alu_src,
               data_a     => sig_read_data_b,
               data_b     => sig_sign_extended_offset,
               data_out   => sig_alu_src_b );

    alu : entity work.alu_device 
    port map ( 
               src_a     => sig_read_data_a,
               src_b     => sig_alu_src_b,
               result    => sig_alu_result_src,
               flag      => sig_alu_carry_out_src,
               ---
               operation => sig_alu_operation
               ---
                );

    data_mem : entity work.data_memory 
    port map ( reset        => reset,
               clk          => clk,
               write_enable => sig_mem_write,
               write_data   => sig_read_data_b_ex_mem,
               addr_in      => sig_alu_result(3 downto 0),
               data_out     => sig_data_mem_out_src );
               
    mux_mem_to_reg : entity work.mux_2to1_16b 
    port map ( mux_select => sig_mem_to_reg,
               data_a     => sig_alu_result_mem_wb,
               data_b     => sig_data_mem_out,
               data_out   => sig_write_data );

    
    resetReg <= reset or sig_use_jump_pc;
    pipeline_if_id: entity work.PipelineReg_IF_ID
        port map (
          clk => clk,
          rst => resetReg,
          instrIn => sig_insn_src,
          instr => sig_insn,
          writeDisable => sig_freeze
        );
        
    pipeline_id_ex: entity work.PipelineReg_ID_EX
        port map (
          clk => clk,
          rst => resetReg,
          WBAddrIn => sig_write_register_src,
          WBAddr => sig_write_register_src_ex_mem,
          ctrl_MemToRegIN => sig_mem_to_reg_src,
          ctrl_MemToReg => sig_mem_to_reg_src_ex_mem,
          ctrl_RegWriteIN => sig_reg_write_src,
          ctrl_RegWrite => sig_reg_write_src_ex_mem,
          ctrl_EnableJumpPCIN => sig_enable_jump_pc_src ,
          ctrl_EnableJumpPC => sig_enable_jump_pc_src_ex_mem      ,
          ctrl_MemWriteIN => sig_mem_write_src ,
          ctrl_MemWrite => sig_mem_write_src_ex_mem  ,
          ctrl_ALUSrcIN => sig_alu_src_src,
          ctrl_ALUSrc => sig_alu_src,
          ctrl_ALUOperationIN => sig_alu_operation_src,
          ctrl_ALUOperation => sig_alu_operation,
          RegData1IN => sig_read_data_a_src,
          RegData1 =>  sig_read_data_a,
          RegData2IN => sig_read_data_b_src,
          RegData2 =>  sig_read_data_b,
          SignExtendDataIN => sig_sign_extended_offset_src,
          SignExtendData => sig_sign_extended_offset,
          PotentialPCIN => sig_insn(3 downto 0),
          PotentialPC => sig_potential_pc_id_ex
        );
        

    -- >:(        
    reset_ex_mem <= sig_freeze or resetReg;

    pipeline_ex_mem: entity work.PipelineReg_EX_MEM
        port map (
          clk => clk,
          rst => reset_ex_mem,
          WBAddrIn => sig_write_register_src_ex_mem,
          WBAddr => sig_write_register_src_mem_wb,
          ctrl_MemToRegIN => sig_mem_to_reg_src_ex_mem,
          ctrl_MemToReg => sig_mem_to_reg_src_mem_wb,
          ctrl_RegWriteIN => sig_reg_write_src_ex_mem,
          ctrl_RegWrite => sig_reg_write_src_mem_wb,
          ctrl_EnableJumpPCIN => sig_enable_jump_pc_src_ex_mem ,
          ctrl_EnableJumpPC => sig_enable_jump_pc,
          ctrl_MemWriteIN => sig_mem_write_src_ex_mem ,
          ctrl_MemWrite => sig_mem_write,
          ctrl_ALUFlagIN => sig_alu_carry_out_src,
          ctrl_ALUFlag => sig_alu_carry_out,
          ALUResultIN => sig_alu_result_src,
          ALUResult => sig_alu_result,
          dataMemoryWriteIN => sig_read_data_b,
          dataMemoryWrite => sig_read_data_b_ex_mem,
          PotentialPCIN => sig_potential_pc_id_ex,
          PotentialPC => sig_potential_pc_ex_mem
        );
        
    pipeline_mem_wb: entity work.PipelineReg_MEM_WB
        port map (
          clk => clk,
          WBAddrIn => sig_write_register_src_mem_wb,
          WBAddr => sig_write_register,
          ctrl_MemToRegIN => sig_mem_to_reg_src_mem_wb,
          ctrl_MemToReg => sig_mem_to_reg,
          ctrl_RegWriteIN => sig_reg_write_src_mem_wb,
          ctrl_RegWrite => sig_reg_write,
          ALUResultIN => sig_alu_result,
          ALUResult => sig_alu_result_mem_wb,
          dataMemoryIN => sig_data_mem_out_src,
          dataMemory => sig_data_mem_out
        );
end structural;
