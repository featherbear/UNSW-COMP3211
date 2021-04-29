+++
categories = ["Lectures"]
date = 2021-04-27T15:03:44Z
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

#### (Hardware) Superscalar Architecture

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

![](/uploads/snipaste_2021-04-29_17-22-10.png)  
The state table holds the a link to the execution unit index that is using the register

![](/uploads/snipaste_2021-04-29_17-31-46.png)

##### Dynamic Execution with Speculation

* Issue, Execute, Write Result, and COMMIT

The commit step allows instructions to execute out of order, but force them to commit in the correct execution order

![](/uploads/snipaste_2021-04-29_17-38-23.png)

![](/uploads/snipaste_2021-04-29_17-38-47.png)

## Thread Level

### Multithreaded Processors

When one thread is not available due to an operation delay (i.e. memory access taking a long time), the processor can switch to another thread

#### Hardware level multithreading

> Thread switching has less overhead than context-switching

* Fast switching between threads
* Requires extra resources: replicated registers, PC, etc

##### Fine-grained Multithreading

> Round-robin approach

* Switch threads after each cycle
* If one thread stalls, another is executed

##### Coarse-grained Multithreading

* Only switch threads on long stalls (i.e. L2-cache miss)

![](/uploads/snipaste_2021-04-30_00-43-48.png)

#### Simultaneous Multithreading (SMT)

* A variation of HW multithreading that uses the resources of superscalar architecture
* Exploits both instruction-level parallelism and thread-level parallelism

![](/uploads/snipaste_2021-04-30_00-59-17.png)

![](/uploads/snipaste_2021-04-30_01-02-07.png)

## System Level - GPUs

Graphics Processing Units are processors developed for processing lots of data at once (i.e. all the pixels on a screen)

### Typical Tasks

* HSR - Hidden Surface Removal (Remove hidden parts of a 3D object to be shown on a \[2D\] screen)
* Shading - Making a flat object look more 3D-like
* Texture Mapping - Providing high frequency details, surface texture, colour information

Many tasks require a huge level of parallelism, however it is common that all tasks are independent (do not rely on each other)

### Example: Powerful but single threaded

![](/uploads/snipaste_2021-04-30_01-10-55.png)

### Example: Cheap but multiple processors

![](/uploads/snipaste_2021-04-30_01-13-33.png)

#### BRRRR

![](/uploads/snipaste_2021-04-30_01-14-35.png)

### SIMD

Since multiple processors are performing the same instruction, just on different data fragments, the instructions can be shared (same fetcher/decoder).

Each execution unit has its own local memory, and they all share a larger memory

![](/uploads/snipaste_2021-04-30_01-16-28.png)

![](/uploads/snipaste_2021-04-30_01-17-11.png)

In the event that there is a stall (i.e. data not available), then the processors can thread-switch to another thread for continued execution

**Remarks**

* Use many cheap cores and run them in parallel
  * Easier than improving a single core by `n` times
* Pack cores full of ALUs and share instruction streams across groups of data sets
  * i.e. SIMD vector
* Avoid long stalls by interleaving execution of many threads

***

# Note: CUDA

CUDA (Compute Unified Device Architecture) is NVIDIA's platform to use their GPUs for arbitrary operations that require parallel computation.

It is executed with some C-like programming language, and unifies all forms of GPU parallelism as a CUDA thread.

![](/uploads/snipaste_2021-04-30_01-24-25.png)