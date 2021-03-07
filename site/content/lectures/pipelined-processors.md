+++
categories = ["Lectures"]
date = 2021-03-07T11:37:17Z
draft = true
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

1) IF - **I**nstruction **F**etch from memory  
2) ID - **I**nstruction **D**ecode and register read  
3) EX - **EX**ecute operation or calculate address  
4) MEM - access **MEM**ory operand  
5) WB - **W**rite result **B**ack to register

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