---------------------------------------------------------------------------
-- COMP3211 Assignment 2021. 
-- Lindsay, Malavika, Mariaa, Andrew, Gabriel
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity single_cycle_core is
    port ( reset  : in  std_logic;
           clk    : in  std_logic;

           -- 8 bits of incoming data, plus 8 bits for tag
           incoming_data    : in  std_logic_vector(15 downto 0);
           incoming_key     : in  std_logic_vector(15 downto 0);
           key_load         : in  std_logic;
           net_ready        : in  std_logic;

           data_output      : out std_logic_vector(7 downto 0);
           tag_output       : out std_logic_vector(7 downto 0);
           
           error_output     : out std_logic
           );
end single_cycle_core;

architecture structural of single_cycle_core is

-- ############################################################################
-- THE OLD COMPONENTS**********************************************************
-- ############################################################################
component program_counter is
    port ( reset    : in  std_logic;
           clk      : in  std_logic;
           addr_in  : in  std_logic_vector(3 downto 0);
           addr_out : out std_logic_vector(3 downto 0);

           stall        : in  std_logic;
           prev_addr    : in std_logic_vector(3 downto 0));
end component;

component instruction_memory is
    port ( reset    : in  std_logic;
           clk      : in  std_logic;
           addr_in  : in  std_logic_vector(3 downto 0);
           insn_out : out std_logic_vector(15 downto 0) );
end component;

component mux_2to1_4b is
    port ( mux_select : in  std_logic;
           data_a     : in  std_logic_vector(3 downto 0);
           data_b     : in  std_logic_vector(3 downto 0);
           data_out   : out std_logic_vector(3 downto 0) );
end component;

component mux_2to1_16b is
    port ( mux_select : in  std_logic;
           data_a     : in  std_logic_vector(15 downto 0);
           data_b     : in  std_logic_vector(15 downto 0);
           data_out   : out std_logic_vector(15 downto 0) );
end component;

component control_unit is
    port ( opcode     : in  std_logic_vector(3 downto 0);
           networkKey : in  std_logic;
           ready      : in  std_logic;
           mem_write  : out std_logic;
           reg_write  : out std_logic;
           branch     : out std_logic;
           key_select : out std_logic;
           direction  : out std_logic );
end component;

component register_file is
    port ( reset           : in  std_logic;
           clk             : in  std_logic;
           read_register_a : in  std_logic_vector(3 downto 0);
           read_register_b : in  std_logic_vector(3 downto 0);
           write_enable    : in  std_logic;
           write_register  : in  std_logic_vector(3 downto 0);
           write_data      : in  std_logic_vector(15 downto 0);
           read_data_a     : out std_logic_vector(15 downto 0);
           read_data_b     : out std_logic_vector(15 downto 0) );
end component;

component adder_4b is
    port ( src_a     : in  std_logic_vector(3 downto 0);
           src_b     : in  std_logic_vector(3 downto 0);
           sum       : out std_logic_vector(3 downto 0);
           carry_out : out std_logic );
end component;

component data_memory is
    port ( reset        : in  std_logic;
           clk          : in  std_logic;
           write_enable : in  std_logic;
           write_data   : in  std_logic_vector(15 downto 0);
           addr_in      : in  std_logic_vector(3 downto 0);
           data_out     : out std_logic_vector(15 downto 0) );
end component;

-------------------------------------------------------------------------------
-- Pipeline Registers
component pipeReg_IFID is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        --in
        pc4_in      : in  std_logic_vector(3 downto 0);
        insn_in     : in  std_logic_vector(15 downto 0);
        -- out
        pc4_out     : out std_logic_vector(3 downto 0);
        insn_out    : out std_logic_vector(15 downto 0) 
    );
end component;

component pipeReg_IDEX is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        --control lines
        EX_in   : in  std_logic_vector(3 downto 0); -- FIXME: set these
        M_in    : in  std_logic_vector(2 downto 0);
        EX_out  : out std_logic_vector(3 downto 0);
        M_out   : out std_logic_vector(2 downto 0);
        --IN
        data_in     : in  std_logic_vector(31 downto 0);
        tag_in      : in  std_logic_vector(15 downto 0);
        pc4_in      : in  std_logic_vector(3 downto 0);
        rd_in       : in  std_logic_vector(3 downto 0); --FIXME: think is is off
        key_in      : in  std_logic_vector(15 downto 0); -- secret key in reg
        dataReg_in  : in  std_logic_vector(15 downto 0);
        --OUT
        data_out    : out std_logic_vector(31 downto 0);
        tag_out     : out std_logic_vector(15 downto 0);
        pc4_out     : out std_logic_vector(3 downto 0);
        rd_out      : out std_logic_vector(3 downto 0);
        key_out     : out std_logic_vector(15 downto 0);
        dataReg_out : out std_logic_vector(15 downto 0)
    );
end component;

component pipeReg_EXMEM is
    port (
        clk     : in  std_logic;
        --control
        M_in   : in  std_logic_vector(1 downto 0);
        M_out  : out  std_logic_vector(1 downto 0);
        -- IN
        tag_in      : in  std_logic_vector(15 downto 0);
        tag_err_in  : in  std_logic;
        p_err_in    : in  std_logic;
        p_in        : in  std_logic;
        data_in     : in  std_logic_vector(31 downto 0);
        jmpAddr_in  : in  std_logic_vector(31 downto 0);
        rd_in       : in  std_logic_vector(3 downto 0);

        --OUT
        tag_out     : out std_logic_vector(15 downto 0);
        tag_err_out : out std_logic;
        p_err_out   : out std_logic;
        p_out       : out std_logic
        data_out    : out std_logic_vector(31 downto 0);
        jmpAddr_out : out std_logic_vector(31 downto 0);
        rd_out      : out std_logic_vector(3 downto 0)
    );
end component;

-- ############################################################################
-- OUR NEW ASSIGNMENT COMONENTS ***********************************************
-- ############################################################################
component parity_unit is
    port (  data:   in std_logic_vector(7 downto 0);
            parity: out std_logic );
end component;

component tag_generator is
    port (  D  : in  std_logic_vector(31 downto 0);
            BF : in  std_logic_vector(3 downto 0);
            R  : in  std_logic_vector(11 downto 0);
            T  : out std_logic_vector(7 downto 0));
end component;

-- ############################################################################
-- SIGNALS ********************************************************************
-- ############################################################################
signal sig_insn         : std_logic_vector(15 downto 0);
signal sig_write_data   : std_logic_vector(15 downto 0);
signal sig_read_data_a  : std_logic_vector(15 downto 0);
signal sig_read_data_b  : std_logic_vector(15 downto 0);
signal sig_data_mem_out : std_logic_vector(15 downto 0);
-------------------------------------------------------------------------------
-- Control ********************************************************************
-------------------------------------------------------------------------------
signal sig_mem_write    : std_logic;
signal sig_reg_write    : std_logic;
signal sig_branch       : std_logic;
signal sig_key_sel      : std_logic;
signal sig_direction    : std_logic;

signal sig_EX_ctrl      : std_logic_vector(3 downto 0);
signal sig_M_ctrl       : std_logic_vector(2 downto 0);
-------------------------------------------------------------------------------
-- Branch jumping *************************************************************
-------------------------------------------------------------------------------
signal sig_next_pc      : std_logic_vector(3 downto 0);
signal sig_curr_pc      : std_logic_vector(3 downto 0);
signal sig_one_4b       : std_logic_vector(3 downto 0);
signal sig_pc_carry_out : std_logic;
signal sig_PC4          : std_logic_vector(3 downto 0);
signal sig_calc_branch  : std_logic_vector(3 downto 0);
-------------------------------------------------------------------------------
-- Pipeline registers *********************************************************
-------------------------------------------------------------------------------
--IFID 
signal sig_IFID_pc4     : std_logic_vector(3 downto 0);
signal sig_IFID_insn    : std_logic_vector(15 downto 0);
--IDEX
signal sig_IDEX_EX      : std_logic_vector(3 downto 0);
signal sig_IDEX_M       : std_logic_vector(2 downto 0);
signal sig_IDEX_data    : std_logic_vector(31 downto 0);
signal sig_IDEX_tag     : std_logic_vector(15 downto 0);
signal sig_IDEX_pc4     : std_logic_vector(3 downto 0);
signal sig_IDEX_sig_ex  : std_logic_vector(3 downto 0);
signal sig_IDEX_key     : std_logic_vector(15 downto 0);
signal sig_IDEX_dataReg : std_logic_vector(15 downto 0);
--EXMEM
signal sig_EXMEM_M      : std_logic_vector(2 downto 0);
signal sig_EXMEM_tag    : std_logic_vector(15 downto 0);
signal sig_EXMEM_tagErr : std_logic;
signal sig_EXMEM_pErr   : std_logic;
signal sig_EXMEM_parity : std_logic;
signal sig_EXMEM_data   : std_logic_vector(31 downto 0);
signal sig_EXMEM_tagErr : std_logic;
signal sig_EXMEM_jmpbr  : std_logic_vector(31 downto 0);
signal sig_EXMEM_rd     : std_logic_vector(3 downto 0);

-------------------------------------------------------------------------------
-- Parity, tag ****************************************************************
-------------------------------------------------------------------------------
signal sig_tag_gen      : std_logic_vector(15 downto 0);
signal sig_tag_comp     : std_logic;
signal sig_parity_gen   : std_logic;
signal sig_parity_comp  : std_logic;

signal sig_tag_err      : std_logic; -- Outputs of and gates
signal sig_p_err        : std_logic;

signal sig_tag_output   : std_logic_vector(15 downto 0);
signal sig_data_output1 : std_logic_vector(15 downto 0);
signal sig_data_output2 : std_logic_vector(15 downto 0);

-- ############################################################################
-- MAIN PROCESSES *************************************************************
-- ############################################################################
begin
    -- Split the incoming signal to data and tag/parity
    sig_incoming_data <= incoming_signal(15 downto 8);
    sig_incoming_tag  <= incoming_signal(7 downto 0); -- this includes the parity
    sig_incoming_key  <= incoming_key;

    -- Our control unit signals
    sig_EX_ctrl(0)  <= '0';
    sig_EX_ctrl(1)  <= '0';
    sig_EX_ctrl(3)  <= '0';

    sig_M_ctrl(0)   <= sig_branch;
    sig_M_ctrl(1)   <= sig_direction;
    sig_M_ctrl(2)   <= sig_mem_write;

    ---------------------------------------------------------------------------
    -- Program Counter Functions **********************************************
    ---------------------------------------------------------------------------
    pc : program_counter
    port map (  reset     => reset,
                clk       => clk,
                addr_in   => sig_next_pc,
                addr_out  => sig_curr_pc,
                stall     => sig_haz_stall,
                prev_addr => sig_lagged_pc );

    -- First the simple PC = PC + 4 at fetch stage
    sig_one_4b <= "0001";
    next_pc : adder_4b 
    port map ( src_a     => sig_curr_pc, 
               src_b     => sig_one_4b,
               sum       => sig_PC4 );
               --carry_out => sig_pc_carry_out ); -- FIXME: can this be removed?
    
    -- Now for the branch address
    branch_calc : adder_4b
    port map (  src_a     => sig_IDEX_pc4, 
                src_b     => sig_IDEX_rd,   --Ignoring extension for now
                sum       => sig_calc_branch);

    -- And now to decide which calculated number to use
    PC_mux  : mux_2to1_4b
    port map (  mux_select  => sig_EXMEM_M(0),
                data_a      => sig_PC4,
                data_b      => sig_EXMEM_jmpbr,
                data_out    => sig_next_pc);

    ---------------------------------------------------------------------------
    -- Some boring modules ****************************************************
    ---------------------------------------------------------------------------
    insn_mem : instruction_memory 
    port map ( reset    => reset,
               clk      => clk,
               addr_in  => sig_curr_pc,
               insn_out => sig_insn );

    ctrl_unit : control_unit 
    port map (  -- Inputs first
                opcode     => sig_IFID_insn(15 downto 12),
                networkKey => key_load,
                ready      => net_ready,
                -- And now the outputs
                mem_write  => sig_mem_write,
                reg_write  => sig_reg_write,
                branch     => sig_branch,
                key_select => sig_key_select,
                direction  => sig_direction );

    reg_file : register_file 
    port map ( reset           => reset, 
               clk             => clk,
               read_register_a => sig_IFID_insn(11 downto 8),
               read_register_b => sig_IFID_insn(7 downto 4),
               write_enable    => sig_MEMWB_WB(1),
               write_register  => sig_MEMWB_rd,
               write_data      => sig_write_data,
               read_data_a     => sig_read_data_a,
               read_data_b     => sig_read_data_b );

    data_mem : data_memory 
    port map ( reset        => reset,
               clk          => clk,
               write_enable => sig_EXMEM_M(2),
               write_data   => sig_EXMEM_data,
               addr_in      => sig_EXMEM_ALUres(3 downto 0),
               data_out     => sig_data_mem_out );
    
    ---------------------------------------------------------------------------
    -- Pipeline Registers *****************************************************
    ---------------------------------------------------------------------------
    IFID : pipeReg_IFID
    port map (
        clk         => clk,
        reset       => reset,
        pc4_in      => sig_IFID_pc4_write,
        insn_in     => sig_IFID_insn_write,
        pc4_out     => sig_IFID_pc4,
        insn_out    => sig_IFID_insn
    );
    -------------------------------------------------
    IDEX : pipeReg_IDEX
    port map (
        clk         => clk,
        reset       => reset,
        --Control Signals
        EX_in       => sig_EX_ctrl,
        EX_out      => sig_IDEX_EX,
        M_in        => sig_M_ctrl,
        M_out       => sig_IDEX_M,
        -- Actual data
        data_in     => sig_incoming_data,
        tag_in      => sig_incoming_tag,
        pc4_in      => sig_IFID_pc4,
        rd_in       => sig_IFID_insn(3 downto 0),
        key_in      => sig_read_data_a,
        dataReg_in  => sig_read_data_b,
        -----------------------------------------
        data_out    => sig_IDEX_data,
        tag_out     => sig_IDEX_tag,
        pc4_out     => sig_IDEX_pc4,
        rd_out      => sig_IDEX_rd,
        key_out     => sig_IDEX_key,
        dataReg_out => sig_IDEX_dataReg
    );
    -------------------------------------------------
    EXMEM : pipeReg_EXMEM
    port map (
        clk         => clk,
        reset       => reset,
        -- Control Signals
        M_in        => sig_IDEX_M,
        WB_in       => sig_IDEX_WB,
        M_out       => sig_EXMEM_M,
        WB_out      => sig_EXMEM_WB,
        -- Actual data
        tag_in      => sig_tag_gen,
        tag_err_in  => sig_tag_comp,
        p_err_in    => sig_parity_comp,
        p_in        => sig_parity_gen,
        data_in     => sig_IDEX_data,
        jmpaddr_in  => sig_calc_branch,
        rd_in       => sig_IDEX_rd,
        -----------------------------------------
        tag_out     => sig_EXMEM_tag,
        tag_err_out => sig_EXMEM_tagErr,
        p_err_out   => sig_EXMEM_pErr,
        p_out       => sig_EXMEM_parity
        data_out    => sig_EXMEM_data,
        jmpaddr_out => sig_EXMEM_jmpbr,
        rd_out      => sig_EXMEM_rd
    );

    ---------------------------------------------------------------------------
    -- Parity and Tagging *****************************************************
    --------------------------------------------------------------------------- 
    parity_unit : parity_module
    port map (
        data    => sig_IDEX_tag(0 downto 0),
        parity  => sig_parity_gen );
    -- XOR to check the received parity_bit
    sig_parity_comp <= sig_parity_gen XOR sig_IDEX_tag(0 downto 0);
    
    tag_gen : tag_generator is
    port map( 
        D   => sig_data2tag,
        BF  => sig_IDEX_data1(15 downto 12), -- key always first reg
        R   => sig_IDEX_data1(11 downto 0),
        T   => sig_generated_tag );

    tag_ok : tag_comparator is 
    port map (
        T1 => sig_data2tag,
        T2 => sig_tag_recv,
        OK => sig_tag_ok );
        
    ---------------------------------------------------------------------------
    -- Tag and Data Outputs ***************************************************
    ---------------------------------------------------------------------------
    -- Are we outputting a tag or a parity bit?
    tag_p_mux : mux_2to1_16b is
        port map (
            mux_select => direction,
            data_a     => sig_EXMEM_tag,
            data_b     => sig_EXMEM_tag(0 downto 0),
            data_out   => sig_tagP_ready );
    
    -- Is there an error? If so don't output
    tag_p_out_mux : mux_2to1_16b is
    port map (
        mux_select => sig_error,
        data_a     => sig_tagP_ready,
        data_b     => 0x"0000",
        data_out   => tag_output );
    
    -- Now the data, being cheap just use two 16b muxes
    data_out_mux1 : mux_2to1_16b is
    port map (
        mux_select => sig_error,
        data_a     => sig_EXMEM_data(15 downto 0),
        data_b     => 0x"0000",
        data_out   => sig_data_output1 );
    data_out_mux1 : mux_2to1_16b is
    port map (
        mux_select => sig_error,
        data_a     => sig_EXMEM_data(31 downto 16),
        data_b     => 0x"0000",
        data_out   => sig_data_output2 );
    -- And now combine those two signals to one
    data_output(15 downto 0)  <= sig_data_output1;
    data_output(31 downto 16) <= sig_data_output2;

    ---------------------------------------------------------------------------
    -- Error signal ***********************************************************
    ---------------------------------------------------------------------------
    sig_p_err    <= sig_EXMEM_M(1)        AND sig_EXMEM_pErr;
    sig_tag_err  <= (not sig_EXMEM_M(1) ) AND sig_EXMEM_tagErr;
    error_output <= sig_p_err             OR  sig_tag_err;
end structural;
