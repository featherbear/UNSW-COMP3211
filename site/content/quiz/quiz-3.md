+++
categories = ["Quiz"]
date = 2021-03-10T01:10:06Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 3"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
> Given an ISA, assume there are three types of implementations:  
> i) single cycle processor  
> ii) multi-cycle processor  
> iii) pipelined processor.
>
> Which of the following is/are true?

**a. Usually, the multi-cycle processor has the smallest average instruction latency.**  
**b. Usually, the pipelined processor has the highest instruction throughput.**  
c. No resource sharing is allowed in the single cycle processor design. Therefore, the single cycle processor takes more resources.  
d. All of the above.

Rationale for (a) - A multi-cycle processor can finish slightly faster than pipe-lined processors as there is no need to wait for the pipeline to be cleared  
Rationale for NOT (c) - Not _always_ true as pipelined/multicycle processors require extra resources too (pipeline registers).

***

> Assume the individual stages of a processor datapath have the following latencies
>
> IF - 250ps  
> ID - 300ps  
> EX - 150ps  
> MEM - 350ps  
> WB - 200ps
>
> Which of the following statements is/are true?

a. If pipelined, the processor can run at a clock frequency of 5 GHz.  
\**b. If not pipelined and with a multi-cycle processor design, the processor can run at a clock frequency of 1 GHz.  
\**c. If the processor is pipelined, the minimum latency for a load instruction is 1250ps.  
**d. If the processor is pipelined, the minimum latency for the ALU instruction is 1750ps.**

Rationale for NOT (c) - Each cycle is constrained to the slowest stage (i.e. MEM) - 350 x 5 = 1750  
Rationale for (d) - Even if the instruction finishes early (i.e. doesn't need to write back), the result isn't used until the end of the pipeline cycle

***

> The figure below shows a five-stage pipeline. Assume for a code execution there are no hazards and the instructions executed are broken down as follows.
>
> ALU - 50%  
> beq - 15%  
> lw - 20%  
> sw - 15%
>
> ![](/uploads/snipaste_2021-03-10_12-33-51.png)  
> What is the utilization of the data memory?
>
> Here the utilization is measured in terms of percentage of total execution clock cycles.

The data memory is used in `lw` and `sw`. So `20 + 15 = 35%`

***

> Figure below shows a pipelined datapath. Answer the follwoing two questions.
>
> ![](/uploads/snipaste_2021-03-10_12-33-57.png)
>
> 1. What is the size of each pipeline stage register (the control signals are not considered)?
> 2. Consider executing the following code on the pipeline. On the fifth cycle of the execution, which registers are accessed for read and which register is accessed for write?

```vhdl
add $1, $2, $3
add $4, $5, $6
add $7, $8, $9
add $10, $11, $12
add $13, $14, $15
```

(Assuming 32-bit addressing)  

* IF/ID - 2x32 = 64 bits
* ID/EX - 4x32 = 128 bits
* EX/MEM - 3x32 = 96 bits (ALU results either zero or ALU result - max(0,32) = 32)
* MEM/WB - 2x32 = 64 bits


On the fifth cycle...  
Read - $10, $11  
Write - $6

---

> Given the delay of each component in the pipeline shown below, how to determine the clock frequency for the pipeline?
> 
> 