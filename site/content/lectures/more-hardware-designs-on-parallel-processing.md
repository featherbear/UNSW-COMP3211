+++
categories = ["Lectures"]
date = 2021-04-27T15:03:44Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "More Hardware Designs on Parallel Processing"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Improving Performance

## Parallelism

* Widen the basic word length of the machine
  * 8 bit
  * 16 bit
  * 32 bit
  * 64 bit
* Vector execution
  * Execute a single instruction on multiple pieces of data
* **Parallel-ise instructions**

## Instruction-level Pipelining

### Deep Pipeline

The depth of the pipeline is increased to achieve higher clock frequencies (more stages).

![](/uploads/snipaste_2021-04-28_01-43-25.png)

Limitations

* Stage delay cannot be arbitrarily reduced
* There is a delay for each register pipeline required
* Pipeline flush penalty will discard more instruction
* Memory hierarchy can stall executions

### CPU with Parallel Processing

Multiple execution components can be performed simultaneously by having parallel groups of instructions

![](/uploads/snipaste_2021-04-28_01-48-13.png)

#### (Software) VLIW Architecture

> VLIW - Very Long Instruction Word

![](/uploads/snipaste_2021-04-28_01-53-52.png)

* Issues with more instructions in parallel
  * May create more data hazards
  * Forwarding in the pipelined datapath becomes hard
  * Identifying parallel instructions is not easy
* More aggressive scheduling is required

![](/uploads/snipaste_2021-04-29_00-23-40.png)  
Above: The SUB.D instruction does not use the previous `F8` register value. To increase performance, we could change the register used for SUB.D - which allows the instructions to be run in parallel as they no longer have a data dependency.

  
![](/uploads/snipaste_2021-04-29_00-23-49.png)

##### Dynamic Scheduling

> TL;DR - Each execution unit has its own queue

The hardware issue component in the processor schedules instructions to different parallel execution units

* Track instruction dependencies to allow instruction execution as soon as all operands are available
* Renaming registers to avoid WAR and WAW hazards

**Issue**

* Get next instruction from the queue
* Issue the instruction and related available operands from the register file to a matching reservation station entry if available, else stall

**Execute**

* Execute ready instructions in the reservation stations
* Monitor the CDB (Common data bus) for the operands of not-ready instructions
* Execution unit idles until a ready instruction is available

**Write Result**

* Results from the EU are sent through the CDB to destinations
  * Reservation station
  * Memory load buffers
  * Register file
* The write operations to the destinations should be controlled to avoid data hazards

![](/uploads/snipaste_2021-04-29_00-28-34.png)

Special data structures in the register file, reservation stations and memory buffers are used to detect and eliminate hazards

**Reservation Station**

![](/uploads/snipaste_2021-04-29_00-55-25.png)   
![](/uploads/snipaste_2021-04-29_01-09-38.png)

1:03:22

#### (Hardware) Superscalar Architecture

## Thread Level

## System Level