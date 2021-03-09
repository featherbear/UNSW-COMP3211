+++
categories = ["Labs"]
date = 2021-03-09T18:15:50Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Lab 2"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Task 1

## Implementation Overview

| Original | SLL | BNE |
| :---: | :---: | :---: |
|  |  |  |

* Added a bit-shifter and comparator into the ALU. The ALU switches the result and miscellaneous flag bit depending on an introduced **ALUOperation** control signal.
* Added a multiplexer that switches between the next "standard" PC address, and the 4-bit address in the instruction, controlled by an introduced **EnableJumpPC** control signal that is AND gated with the ALU output flag
* Highly opinionated design (i.e. ALU flag defaults to comparator output for all instructions except for ADD)

### Introduced Instructions

```vhdl
--     sll   rd, rs, rt
--        # rd <- rs << rt
--        # format:  | opcode = 12 |  rs  |  rt  |  rd  | 
--
--     bne   rs, rt, imm
--        # if rs != rt, PC <- imm
--        # format:  | opcode = 13 |  rs  |  rt  |  imm  | 
```

### Introduced Control Signals

```vhdl
--     alu_operation : asserted for SLL instructions, so that the ALU will use
--                     the results of the SLL unit instead of the ADD unit
--     enable_jump_pc : asserted for BEQ instructions, allows possible PC rewrite    
```

## Step 0 (Original)

![](/uploads/base.png)

## Implement SLL

![](/uploads/sll.png)

## Implement BNE

![](/uploads/beq.png)

## Simulation

![](/uploads/signal.png)

```vhdl
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
var_insn_mem(8)  := X"D22E";

-- bne $1, $3, 0
---- toHex(['1101', '0001', '0011', '0000'])
---- shouldn't jump
var_insn_mem(9)  := X"D13E";

-- bne $2, $3, 0
---- toHex(['1101', '0010', '0011', '0000'])
---- should jump to instruction 0
var_insn_mem(10) := X"D23E";

var_insn_mem(11) := X"0000";
var_insn_mem(12) := X"0000";
var_insn_mem(13) := X"0000";
var_insn_mem(14) := X"0000";
var_insn_mem(15) := X"0000";
```