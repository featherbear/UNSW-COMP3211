+++
date = 2021-02-21T14:46:04Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Single Cycle Processors"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Steps to Build a Processor

1) Analyse instruction set to determine datapath requirements

2) Select a set of hardware components for the datapath and establish clocking methodology

3) Assemble datapath to meet the requirements

4) Analyse implementation of each instruction to determine control points

5) Assemble the control logic

***

## Analyse instruction set to determine datapath requirements

The requirements of each register can be identified as a set of register transfer operations. Data transferred from one storage location to another may go through a combinational logic to occur.

Register-level Transfer Language (RTL) is used to describe the instruction execution.  
e.g. `$3 <- $1 + $2` for `ADDU $3, $1, $2`

The datapath must support each transfer operation

All instructions start by first fetching the instruction from memory.

> In MIPS-Lite, all instructions are either `op | rs | rt | rd | shamt | funct` or `op | rs | rt | imm16`  
> Some of these instructions (e.g) do the following register transfers:
>
> ![](/uploads/snipaste_2021-02-18_18-40-41.png)
>
> To support these, the instruction set must have some sort of **memory** (instruction and data), **program counter** (PC), **registers** (to read/write `rs`/`rt`/`rd`), add/sub/or operations for registers or extended immediate values, and to increase the program counter

## Select a set of components for the datapath and establish clocking methodology

### Combinational Elements

Adders, Muxers, ALU

### Storage Elements

#### Registers

A set of flip-flop components.

![](/uploads/snipaste_2021-02-22_02-20-39.png)

#### Register File

A set of registers

![](/uploads/snipaste_2021-02-22_02-22-03.png)

#### Memory

* One input port/bus for data in
* One output port/bus for data out

![](/uploads/snipaste_2021-02-22_02-48-02.png)

The memory word is selected by the address.

### Clocking Methodology

Edge triggered clocking - all storage elements are clocked by the same clocked edge

Need to consider the following issues

* Clock skew - difference in the arrival of the clock signal
* Setup time - period of stable input for the register to read successfully
* Hold time - period of stable output for the register output

\-

* Cycle time >= `Clk-to-Q` + longest delay path + setup + clock skew
* `Clk-to-Q` + shortest delay path - clock skew > hold time

(`Clk-to-Q` - The delay of the register)

![](/uploads/snipaste_2021-02-22_02-58-46.png)

## Assemble datapath to meet the requirements

> Put the selected components together based on the register transfer requirements

At the start of each clock cycle, fetch the instruction from `MEM[PC]`.

At the end of the cycle, update the program counter.  
Either `PC <- PC + 4` or `PC <- ...` (branch)

### ADDU / SUBU

![](/uploads/snipaste_2021-02-22_03-47-06.png)

### ORI

![](/uploads/snipaste_2021-02-22_04-11-32.png)

The second input to the ALU is switched by a multiplexer between BUS B and a 16-bit immediate value (zero extended to 32 bits). Rw is also switched by a multiplexer

### LW

![](/uploads/snipaste_2021-02-22_04-15-35.png)

### SW

![](/uploads/snipaste_2021-02-22_04-17-16.png)

### BEG

![](/uploads/snipaste_2021-02-22_04-17-53.png)

![](/uploads/snipaste_2021-02-22_04-19-30.png)