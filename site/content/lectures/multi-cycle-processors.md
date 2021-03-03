+++
categories = ["Lectures"]
date = 2021-03-02T14:29:09Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Multi Cycle Processors"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
For a small set of instructions, it is relatively simple to design a single-cycle processor to implement the functionality for the instructions..

We may want to assume that control signals will be ready when data flows to a component

***

With a CPI = 1 processor, the clock cycle time is determined by the latency of the longest instruction - which means that all instructions take as much time as the slowest instruction.

In addition, we need to duplicate resources that are used more than once per instruction.

To improve this design, we can allow **instructions to span over multiple cycles**.  
In a way, we are able to 'quantize' the steps of the instruction.

This multi-cycle processor design can be implemented by partitioning the single-cycle datapath, where **each section takes one clock cycle to execute**. By repeating parts of the cycle, we also mitigate the need to duplicate resources

The time spent in each section should be balanced, as the clock cycle time is determined by the longest section delay. Registers should be inserted between sections, based on the operation of each section

![](/uploads/snipaste_2021-03-04_01-41-00.png)  
![](/uploads/snipaste_2021-03-04_02-10-03.png)

***

![](/uploads/snipaste_2021-03-04_02-12-44.png)

***

**R-Type Instructions** - Takes 4 cycles  
![](/uploads/snipaste_2021-03-04_02-17-25.png)

**I-Type Instructions** - Takes 4 cycles  
![](/uploads/snipaste_2021-03-04_02-17-56.png)

**LW Instruction** - Takes 5 cycles  
![](/uploads/snipaste_2021-03-04_02-18-23.png)

**SW Instruction** - Takes 4 cycles  
![](/uploads/snipaste_2021-03-04_02-19-45.png)

**BEQ Instruction** - Takes 4 cycles  
![](/uploads/snipaste_2021-03-04_02-20-23.png)

***

# Building Finite State Machines for Control

![](/uploads/snipaste_2021-03-04_02-21-02.png)

As instructions are no longer single-cycled, we can no longer use combinational logic to determine the control signals. Instead we need to use a FSM (and deal with it in steps).  
(Each horizontal level related to one clock cycle)