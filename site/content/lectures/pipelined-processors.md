+++
categories = ["Lectures"]
date = 2021-03-07T11:37:17Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Pipelined Processors"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
Pipelining involves performing several tasks at relatively the same time.  
Since a multi-cycle processor instruction has its tasks split into stages, previous stages of the current instruction can be used by other instructions; in order to speed up execution.

> i.e. a task uses stages A, B, C, D. When the task is on stage B, another task can use the resources in stage A

Compared to the [example in multicycle processors](multi-cycle-processors), a pipelined design can execute the instructions in 8 clock cycles

***

# MIPS Pipelined Datapath

## Stages

1. IF - **I**nstruction **F**etch from memory
2. ID - **I**nstruction **D**ecode and register read
3. EX - **EX**ecute operation or calculate address
4. MEM - access **MEM**ory operand
5. WB - **W**rite result **B**ack to register

## MIPS Design

* All instructions are 32-bits - easy to fetch in one cycle
* Few and regular instruction formats - can decode and read all in one step
* Load/store addressing - Can calculate the address in the ALU at an early stage, allowing access in a later stage
* Alignment of memory operands - allows memory access to take "one cycle"
* Most resources are available

![](/uploads/snipaste_2021-03-07_22-56-29.png)

***

# Partitioning

Partition the single cycle datapath into sections - each section forms a stage.

* Try to balance the stages for similar stage delays (reduce clock cycle time)
* Try to make data flow in the same directions (avoid pipeline hazards)
* Make sure the correct data is used for each instruction

![](/uploads/snipaste_2021-03-07_23-48-45.png)

* Shaded|Unshaded - Write into
* Unshaded|Shaded - Read from

Find the shaded part of the component, that's the data direction

# Pipeline Registers

To retain the values of an instruction to be used in other stages, the values are saved in **pipeline registers**. They are named by combining the two stages using that register.

e.g. IF/ID register

Each logical component (i.e. instruction memory, register read ports can only be used in a single pipeline stage.

***

# Pipeline Control

Pipeline processes need to be controlled

* Label control points
* Determine control settings
* Design control logic

![](/uploads/snipaste_2021-03-08_02-16-29.png)

***

![](/uploads/snipaste_2021-03-08_02-18-58.png)

![](/uploads/snipaste_2021-03-08_02-30-23.png)

![](/uploads/snipaste_2021-03-08_02-57-09.png)

***

# Hazards

Situations where the instruction execution cannot proceed in the pipeline

## Structural Hazard

> The required resource is busy

![](/uploads/snipaste_2021-03-08_03-01-34.png)

## Data Hazard

> Need to wait for the previous instruction to update its data

![](/uploads/snipaste_2021-03-08_03-02-25.png)

### Data Dependency types

* RAR - Read after Read
* WAW - Write after Write
* WAR - Write after Read
* RAW - Read after Write

## Control Hazard

> The control decision cannot be made until the condition check by the previous instruction is completed

![](/uploads/snipaste_2021-03-08_03-04-57.png)

# Mitigating Hazards

## Mitigating Structural Hazards

> Never access a resource more than once per cycle

* Allocate each resource to a single pipeline stage
  * Duplicate resources if necessary (_e.g. IMEM, DMEM_)
* Every instruction must follow the same sequence of cycles/stages
  * _Skipping a stage can introduce structural hazards_
  * However, some trailing cycles/stages can be dropped
    * i.e. `BRA` / `JMP` -  don't need WB or MEM

![](/uploads/snipaste_2021-03-08_03-19-19.png)  
In an ideal case, CPI = 1 (given a constant stream of instructions, each cycle a new instruction starts, but another instruction finishes)

In a one-memory case, the CPI increases to 1.2 as DM and IM stages can't occur concurrently

## Mitigating Data Hazards

> Properly schedule / partition tasks in the pipeline

To detect data hazards, we check for data dependencies between instructions and its preceding instructions

* Eliminate WAR (write after read) by always fetching operands early in the pipeline
  * ID stage
* Eliminate WAW (write after write) by doing all WBs in order
  * Single stage for writing

> Mitigating RAW (read after write)

![](/uploads/snipaste_2021-03-08_03-44-21.png)

If instructions depend on the result of a previous instruction, we need to delay that instruction from occurring...

### Stalling - stall the instruction execution

Load Use Hazard (LUH) - When a load instruction is followed by an instruction dependent on the memory data (i.e. "not yet")

Prevent PC and IF/ID registers from changing

Set the EX, MEM and WB control fields of the ID/EX register to 0 to perform a `no-op`

This is performed by a Hazard Detection Unit, which reads the states of the different pipeline registers, and controls the writeability of the IF/ID register

![](/uploads/snipaste_2021-03-08_04-27-01.png)

### Forwarding - if the correct data is available, forward the data to where it is required

Update a pipeline register to contain the correct value, so that it can be used

***

![](/uploads/snipaste_2021-03-08_04-14-12.png)

![](/uploads/snipaste_2021-03-08_04-18-12.png)

### Stall AND Forward

Ooooh smart!

***

# Static Predictions

Predicts that all branch instructions have the same behaviour - either never, or always taken

* When the prediction (never taken\[?\]) is correct, the pipeline continues processing
* When the prediction is wrong, the instruction(s?) after the branch instruction are discarded 

> Load each instruction every clock cycle, but discard the latter instructions if a branch occurs

## Pipeline Flush

![](/uploads/screenshot-from-2021-03-13-15-45-25.png)

If the prediction is wrong, 3 instructions need to be flushed.

To mitigate the performance penalty from flushing, there are several improvement methods.

* Make the decision for branching earlier
  * Calculate the target address in the ID stage
  * Compare register contents in the ID stage (using bitwise XOR)
  * Require forwarding to ID stage and hazard detection
    * (Only if the branch is dependent upon the result of an R-type or LOAD instruction that is still in the pipeline)  
* Flush only one instruction
  * `IF.Flush` control signal sets the instruction field of the IF/ID register to 0

![](/uploads/screenshot-from-2021-03-13-15-52-18.png)

***

![](/uploads/screenshot-from-2021-03-13-15-40-29.png)  
4N / (xN * 1 + (1-x)N * 4)  
4/(4-3x)