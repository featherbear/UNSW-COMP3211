---- Network Co-processor
-- The core of the network interface
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity network_coprocessor_ASIP is
    port (
        clk : in std_logic;
        reset : in std_logic;
        
        -- External signals, passed into the PC Controller
        CTRL : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        
        -- External port used for operations to write to data#0
        extPort : in STD_LOGIC_VECTOR (15 downto 0);
        
        -- Incoming CPU data
        procData   : in STD_LOGIC_VECTOR (31 downto 0);
        procParity : in STD_LOGIC;
        
        -- Incoming network data
        netData      : in STD_LOGIC_VECTOR (39 downto 0);
        networkReady : in STD_LOGIC;
           
        -- Output signal (soft-error from parity, error from tag tamper)
        error : out STD_LOGIC;

        -- Output data
        procOut         : out STD_LOGIC_VECTOR (31 downto 0);
        procDataPresent : out STD_LOGIC;
        
        -- Output network data
        netOut         : out STD_LOGIC_VECTOR (39 downto 0);
        netDataPresent : out STD_LOGIC

    );
end network_coprocessor_ASIP;
    
architecture behavioural of network_coprocessor_ASIP is   
    -- Buffered outputs
    signal buffer_extPort    : std_logic_vector(15 downto 0);
    signal buffer_netData    : std_logic_vector(39 downto 0);
    signal buffer_procData   : std_logic_vector(31 downto 0);
    signal buffer_procParity : std_logic;
    
    -- Input stage signals
    signal pc_value               : std_logic_vector(3 downto 0);
    signal instruction_memory_out : std_logic_vector(15 downto 0);
    
    ----- IF/ID pipeline register signals
    signal if_id_extPort    : std_logic_vector (15 downto 0);
    signal if_id_procData   : std_logic_vector (31 downto 0);
    signal if_id_netData    : std_logic_vector (39 downto 0);
    signal if_id_procParity : std_logic;
    signal if_id_insn       : std_logic_vector(15 downto 0);
    
    ----- ID stage signals
    signal reg_file_out   : std_logic_vector(15 downto 0);
    signal sel_data       : std_logic_vector(31 downto 0);
    signal sel_tag_parity : std_logic_vector(7 downto 0);
    -- Control unit output signals
    signal ctrl_reg_write : std_logic;
    signal ctrl_is_net_op : std_logic;
    signal ctrl_mem_write : std_logic;
    signal ctrl_direction : std_logic;

    ----- ID/EX pipeline register signals
    signal id_ex_ctrl_is_net_op : std_logic;
    signal id_ex_ctrl_reg_write : std_logic;
    signal id_ex_ctrl_mem_write : std_logic;
    signal id_ex_ctrl_direction : std_logic;
    signal id_ex_data           : std_logic_vector(31 downto 0);
    signal id_ex_tag_parity     : std_logic_vector(7 downto 0);
    signal id_ex_ext_key        : std_logic_vector(15 downto 0);
    signal id_ex_key            : std_logic_vector(15 downto 0);
    
    ----- EX stage signals
    signal tag_generator_out    : std_logic_vector(7 downto 0);
    signal compare_tags_out     : std_logic;
    signal parity_generator_out : std_logic;
    signal parityCheck          : std_logic;
    
    ----- EX/MEM pipeline register signals
    signal ex_mem_ctrl_is_net_op : std_logic;
    signal ex_mem_ctrl_reg_write : std_logic;
    signal ex_mem_ctrl_mem_write : std_logic;
    signal ex_mem_ctrl_direction : std_logic;
    signal ex_mem_tag            : std_logic_vector(7 downto 0);
    signal ex_mem_tag_err        : std_logic;
    signal ex_mem_p_err          :  std_logic;
    signal ex_mem_data           : std_logic_vector(31 downto 0);
    signal ex_mem_ext_key        : std_logic_vector(15 downto 0);
    
    ---- Data signals ----
    signal sig_error       : std_logic;
    signal sig_data_out_en : std_logic;
    signal sig_write_data  : std_logic_vector(15 downto 0);
    
    ---- Constants -----
    constant KEY_ADDR       : std_logic_vector(3 downto 0) := "0000";
    constant DIRECTION_SEND : std_logic := '0';
    constant DIRECTION_RECV : std_logic := '1';
begin    

    ----------------------------------
    ---- INITIAL STAGE COMPONENTS ----
    ----------------------------------

    -- PC Controller controls the next PC address to load from
    pc_controller:      entity work.PCController       port map (clk => clk, network_ready => networkReady, ASIP_ready => CTRL(4), receive_request => CTRL(3), send_request => CTRL(2), loadkey_request => CTRL(1), loadext_request => CTRL(0), PC => pc_value);
    
    -- Network buffer stalls incoming CPU and network data for one cycle
    netbuffer:          entity work.networkBuffer      port map (clk => clk, extPort => extPort, extPort_out => buffer_extPort, procData => procData, procData_out => buffer_procData, netData => netData, netData_out => buffer_netData, procParity => procParity, procParity_out => buffer_procParity);
    
    -- Instruction memory holds PC-mapped instructions
    instruction_memory: entity work.instruction_memory port map (clk => clk, reset => reset, addr_in => pc_value, insn_out => instruction_memory_out);
    
    -- Stage pipeline
    pipeline_reg_if_id: entity work.pipeReg_IFID       port map (clk => clk, extPort => buffer_extPort, extPort_out => if_id_extPort, procData => buffer_procData, procData_out => if_id_procData, netData => buffer_netData, netData_out => if_id_netData, procParity => buffer_procParity, procParity_out => if_id_procParity, insn_in => instruction_memory_out, insn_out => if_id_insn);  



    ---------------------------------------------
    ---- INSTRUCTION DECODE STAGE COMPONENTS ----
    ---------------------------------------------
    
    -- Switch the data signals between CPU and network, depending on the required control direction
    sel_data       <= if_id_procData                 WHEN ctrl_direction = DIRECTION_SEND ELSE if_id_netData(31 downto 0);
    sel_tag_parity <= ("0000000" & if_id_procParity) WHEN ctrl_direction = DIRECTION_SEND ELSE if_id_netData(39 downto 32);
    
    -- Controller for internal signal
    control_unit: entity work.control_unit  port map (opcode => if_id_insn(15 downto 12), is_net_op  => ctrl_is_net_op, mem_write  => ctrl_mem_write, reg_write  => ctrl_reg_write, direction  => ctrl_direction);
    
    -- Register block for reading and writing data
    reg_file:     entity work.register_file port map (clk => clk, reset => reset, read_register_a => KEY_ADDR, read_register_b => KEY_ADDR, write_enable => ex_mem_ctrl_reg_write, write_data => sig_write_data, write_register => KEY_ADDR, read_data_a => reg_file_out);

    -- Stage pipeline
    pipeline_reg_id_ex: entity work.pipeReg_IDEX   port map (clk => clk, ctrl_is_net_op  => ctrl_is_net_op, ctrl_is_net_op_out  => id_ex_ctrl_is_net_op, ctrl_mem_write  => ctrl_mem_write, ctrl_mem_write_out  => id_ex_ctrl_mem_write, ctrl_reg_write  => ctrl_reg_write, ctrl_reg_write_out  => id_ex_ctrl_reg_write, ctrl_direction  => ctrl_direction, ctrl_direction_out  => id_ex_ctrl_direction,  data => sel_data, data_out => id_ex_data, tag_parity => sel_tag_parity, tag_parity_out => id_ex_tag_parity, ext_key => if_id_extPort, ext_key_out => id_ex_ext_key, key => reg_file_out, key_out => id_ex_key);



    ----------------------------------------------
    ---- INSTRUCTION EXECUTE STAGE COMPONENTS ----
    ----------------------------------------------
    ---- Note: Tag and parity generation are  ----
    ----       performed in parallel          ----
    ----------------------------------------------

    -- TAG OPERATION --
    ---- Tag generator
    tag_generator:      entity work.tag_generator  port map (D => id_ex_data, BF => id_ex_key(15 downto 12), R => id_ex_key(11 downto 0), T => tag_generator_out);
    ---- Tag comparator
    compare_tags:       entity work.nBitComparator generic map (n => 8) port map (inA => tag_generator_out, inB => id_ex_tag_parity, isNotEqual => compare_tags_out);

    -- PARITY BIT OPERATION --
    -- XOR each bit, then XOR with parity - should equal 0 for success
    ---- Parity bit generator
    parity_generator:   entity work.parity_unit    generic map (n => 32) port map (data => id_ex_data, parity => parity_generator_out);
    ---- When sending, the tag_parity signal should be zero, such that A XOR 0 = A
    parityCheck <= parity_generator_out XOR id_ex_tag_parity(0);
                                            
    -- Stage pipeline
    pipeline_reg_ex_mem: entity work.pipeReg_EXMEM port map (clk => clk, ctrl_is_net_op  => id_ex_ctrl_is_net_op, ctrl_is_net_op_out  => ex_mem_ctrl_is_net_op, ctrl_mem_write  => id_ex_ctrl_mem_write, ctrl_mem_write_out  => ex_mem_ctrl_mem_write, ctrl_reg_write  => id_ex_ctrl_reg_write, ctrl_reg_write_out  => ex_mem_ctrl_reg_write, ctrl_direction  => id_ex_ctrl_direction, ctrl_direction_out  => ex_mem_ctrl_direction,  tag => tag_generator_out, tag_out => ex_mem_tag, tag_err => compare_tags_out, tag_err_out => ex_mem_tag_err, p_err => parityCheck, p_err_out => ex_mem_p_err, data => id_ex_data, data_out => ex_mem_data, ext_key => id_ex_ext_key, ext_key_out => ex_mem_ext_key);



    ---------------------------------------------
    ---- MEMORY OPERATIONS STAGE COMPONENTS ----
    ---------------------------------------------

    -- Memory block for reading and writing data
    data_memory: entity work.data_memory port map (reset => reset, clk => clk, write_enable => ex_mem_ctrl_mem_write, write_data => ex_mem_ext_key, addr_in => KEY_ADDR, data_out => sig_write_data);

    -- Set HI error signal if there is a tag error when receiving, or a parity error when sending
    sig_error <= '1' WHEN (ex_mem_tag_err = '1' AND ex_mem_ctrl_direction = DIRECTION_RECV)
                       OR (ex_mem_p_err   = '1' AND ex_mem_ctrl_direction = DIRECTION_SEND)
                     ELSE '0';
    
    -- Output the error signal
    error <= sig_error;

    -- Data out enabler
    sig_data_out_en <= NOT(sig_error) AND ex_mem_ctrl_is_net_op;

    -- Output data to the correct port when required, else output zeros
    --- Network
    netOut         <= (ex_mem_tag & ex_mem_data) WHEN (ex_mem_ctrl_direction = DIRECTION_SEND AND sig_data_out_en = '1') ELSE (OTHERS => '0');
    netDataPresent <= '1'                        WHEN (ex_mem_ctrl_direction = DIRECTION_SEND AND sig_data_out_en = '1') ELSE '0';
    ---- CPU
    procOut         <= (ex_mem_data) WHEN (ex_mem_ctrl_direction = DIRECTION_RECV AND sig_data_out_en = '1') ELSE (OTHERS => '0');
    procDataPresent <= '1'           WHEN (ex_mem_ctrl_direction = DIRECTION_RECV AND sig_data_out_en = '1') ELSE '0';
    
end behavioural;
