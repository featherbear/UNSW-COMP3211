+++
categories = ["Quiz"]
date = 2021-03-28T15:30:28Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 5"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
> Which of the following statements is/are not true?

**a. Given a single cycle processor, if the datapath can be pipelined into 8 stages or 5 stages, the 8-stage pipeline always provides a higher throughput than the 5-stage pipeline.  
**_"always" is probably not true_  
**b. If the latency of switching to different memory bank can be ignored, the interleaved memory operation has a throughput no less than that of the non-interleaved operation.  
**_throughput can be increased, as we do not need to wait for the precharge delay_**  
**c. Burst mode memory operation is beneficial to accessing an array of data items.   
d. The reason that disk is much slower than DRAM is mainly because of the mechanical operations it involves.

***

> Figure below shows a pipelined processor. When both instruction and data memories are implemented using SRAMs, the processor can achieve a CPI of 1.2 for a given program. The program consists of 50% arithmetic/logic instructions, 30% load/store instructions, and 20% branch instructions. The SRAM has the same speed as the processor (namely, assessing SRAM takes one clock cycle).
>
> If each SRAM is replaced by a DRAM and accessing the DRAM takes extra 50 clock cylces, what is the CPI for the program now?

![](/uploads/pipe5.png)

a. 16.2  
b. 56.2  
c. 66.2  
d. none of the above

***

> Consider the direct-mapped cache design with 32-bit word address.
>
> For each of the following two cache configurations,
>
> 1. what is the cache line size (in words)?
> 2. how many entries does the cache have?

        Tag    Index   Offset
    a  31-10    9-4     3-0
    b  31-12   11-5     4-0

***

> Assume a sequence of byte addresses (written in the decimal format):  
> 1, 4, 8, 5, 20, 17, 19, 9, 11, 4, 5, 6 are referenced in a program execution.  
> Show the related hits and misses if a 2-way set-associative cache with two-byte blocks is used.  
> The cache size is 16 bytes.
>
> State any assumptions you need to make.