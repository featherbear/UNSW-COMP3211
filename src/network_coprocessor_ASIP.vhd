---------------------------------------------------------------------------
-- COMP3211 Assignment 2021. 
-- Lindsay, Malavika, Mariaa, Andrew, Gabriel
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity network_coprocessor_ASIP is
    port (
        clk : in std_logic;
        
        networkReady : in STD_LOGIC;
        extPort : in STD_LOGIC_VECTOR (15 downto 0);
        procData : in STD_LOGIC_VECTOR (31 downto 0);
        netData : in STD_LOGIC_VECTOR (39 downto 0);
        procParity : in STD_LOGIC;
           
        error : out STD_LOGIC;
        netOut : out STD_LOGIC_VECTOR (39 downto 0)
    );
end network_coprocessor_ASIP;
    
architecture behavioural of network_coprocessor_ASIP is
    signal reset : std_logic;
    
    signal ctrl_direction : std_logic;
    signal ctrl_mem_write : std_logic;
    signal ctrl_reg_write : std_logic;
    signal ctrl_is_net_op : std_logic;
    
    signal sel_data : std_logic_vector(31 downto 0);
    signal sel_tag_parity : std_logic_vector(7 downto 0);

    signal pc_value : std_logic_vector(3 downto 0);
    signal instruction_memory_out : std_logic_vector(15 downto 0);
    
    signal if_id_insn : std_logic_vector(15 downto 0);
    
    signal reg_file_out : std_logic_vector(15 downto 0);

    signal id_ex_data : std_logic_vector(31 downto 0);
    signal id_ex_tag_parity: std_logic_vector(7 downto 0);
    signal id_ex_ext_key: std_logic_vector(15 downto 0);
    signal id_ex_key: std_logic_vector(15 downto 0);
    
    signal tag_generator_out : std_logic_vector(7 downto 0);
    signal compare_tags_out : std_logic;
    signal parity_generator_out : std_logic;
    signal parityCheck : std_logic;
    
    signal ex_mem_tag : std_logic_vector(7 downto 0);
    signal ex_mem_tag_err : std_logic;
    signal ex_mem_p_err :  std_logic;
    signal ex_mem_data : std_logic_vector(31 downto 0);
    signal ex_mem_ext_key : std_logic_vector(15 downto 0);
    
    signal sig_error : std_logic;
    signal sig_write_data : std_logic_vector(15 downto 0);
    
    constant KEY_ADDR : std_logic_vector(3 downto 0) := "0000";
    constant DIRECTION_SEND : std_logic := '0';
    constant DIRECTION_RECV : std_logic := '1';
begin    
    reset <= '0'; 
    
    sel_data <= procData WHEN ctrl_direction = DIRECTION_SEND ELSE netData(31 downto 0);
    sel_tag_parity <= ("0000000" & procParity) WHEN ctrl_direction = DIRECTION_SEND ELSE netData(39 downto 32);
    
    instruction_memory: entity work.instruction_memory port map ( reset => reset, clk => clk, addr_in => pc_value, insn_out => instruction_memory_out);
    pipeline_reg_if_id: entity work.pipeReg_IFID port map (clk => clk, insn_in => instruction_memory_out, insn_out => if_id_insn);  
    
        
    control_unit: entity work.control_unit port map (
        opcode     => if_id_insn(15 downto 12),
        is_net_op  => ctrl_is_net_op,
        mem_write  => ctrl_mem_write,
        reg_write  => ctrl_reg_write,
        direction  => ctrl_direction
    );
    
    reg_file: entity work.register_file port map (
        clk => clk,
        reset => reset,
        read_register_a => KEY_ADDR,
        read_register_b => KEY_ADDR,
        write_enable => ctrl_reg_write,
        write_data => sig_write_data,
        write_register => KEY_ADDR,
        read_data_a => reg_file_out
    );
    
    pipeline_reg_id_ex: entity work.pipeReg_IDEX port map (clk => clk, 
        data => sel_data,
        data_out => id_ex_data,
        tag_parity => sel_tag_parity,
        tag_parity_out => id_ex_tag_parity,
        ext_key => extPort,
        ext_key_out => id_ex_ext_key,
        key => reg_file_out,
        key_out => id_ex_key
    
    );

    tag_generator: entity work.tag_generator port map (
        D => id_ex_data,
        BF => id_ex_key(15 downto 12),
        R => id_ex_key(11 downto 0),
        T => tag_generator_out
    );
    
    compare_tags: entity work.nBitComparator generic map (n => 8) port map (
        inA => tag_generator_out,
        inB => id_ex_tag_parity,
        -- TODO: Confirm right logic
        isNotEqual => compare_tags_out
    );
    
    -- XOR each bit, then XOR with parity - should equal 0
    parity_generator: entity work.parity_unit port map (
        data => id_ex_data,
        parity => parity_generator_out
    );
                                            -- When sending, the tag_parity signal should be zero, so A XOR 0 = A
    parityCheck <= parity_generator_out XOR id_ex_tag_parity(0);
    
    pipeline_reg_ex_mem: entity work.pipeReg_EXMEM port map ( clk => clk, tag => tag_generator_out, tag_out => ex_mem_tag, tag_err => compare_tags_out, tag_err_out => ex_mem_tag_err, p_err => parityCheck, p_err_out => ex_mem_p_err, data => id_ex_data, data_out => ex_mem_data, ext_key => id_ex_ext_key, ext_key_out => ex_mem_ext_key );

    sig_error <= '1' WHEN (ex_mem_tag_err = '1' AND ctrl_direction = DIRECTION_RECV) OR (ex_mem_p_err = '1' AND ctrl_direction = DIRECTION_SEND) else '0';
    error <= sig_error;
    
    netOut <= (ex_mem_tag & ex_mem_data) WHEN (ctrl_direction = DIRECTION_SEND AND sig_error = '0') else (others => '0');

    data_memory: entity work.data_memory port map (
        reset => reset,
        clk => clk,
        write_enable => ctrl_mem_write,
        write_data => ex_mem_ext_key,
        addr_in => KEY_ADDR,
        data_out => sig_write_data
    );
    
end behavioural;
