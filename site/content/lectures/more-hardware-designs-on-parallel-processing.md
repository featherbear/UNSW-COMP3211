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

#### (Hardware) Superscalar Architecture

## Thread Level

## System Level