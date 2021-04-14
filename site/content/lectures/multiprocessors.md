+++
categories = ["Lectures"]
date = 2021-04-11T08:07:42Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Multiprocessors"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Why

![](/uploads/snipaste_2021-04-11_18-48-37.png)

Increasing CPU frequency helps to increase performance

### Power Consumption

Power = Capacitive Load * Voltage² * Frequency

Reducing load, voltage and frequency can decrease power consumption

***

![](/uploads/snipaste_2021-04-11_19-25-10.png)  
CPU frequency has hit a "frequency wall" / "power wall" - hard to get faster. Instead of increasing the speed of a core, just add more cores!

***

# Multiprocessors

All processors perform in parallel, achieving high performance.  
Power consumption scales linearly.

## Processor Classes

* SISD - Single instruction, single data
* SIMD - Single instruction, multiple data
* MISD - Multiple instruction, single data
* MIMD - Multiple instruction, multiple data

![](/uploads/snipaste_2021-04-11_19-35-16.png)

## UMA (Uniform Memory Access)

![](/uploads/snipaste_2021-04-11_19-51-16.png)

All processors share a **single bus** to access memory and I/O resources.  
Allows for simple data sharing, but restricts performance (exclusive access).  
All memory locations have similar latencies - hence the **uniform** access.  
Each processor also has a local cache (which will be invalidated when memory updates??? * cache coherence *)

## NUMA (Non-Uniform Memory Access)

## Memory-connected Multiprocessors

![](/uploads/snipaste_2021-04-11_19-52-42.png)

Each processor has their own local memory, which is accessible to other processors over a network / bus

***

## Cache Coherence

Shared-memory multiprocessors have cache coherence problems - copies of the same data need to be updated in all locations. This can be performed in different ways

* Software Implementation
  * During compilation, the compiler identifies data items that may cause cache inconsistency, and disables the cache-ability of those items.
* Hardware Implementation
  * Snoop-based Protocol (for UMA)
    * Write-update - Update other caches
    * Write-invalidate - Mark data on other caches as invalid
  * Directory-based Protocol (for NUMA)

### MESI - Write-Invalid | Snoop

Uses four states in the cache line

* Modified - Data modified, data in specific cache
* Exclusive - Data same, data only in the current cache
* Shared  - Data same, data in other caches
* Invalid - Data invalid

### EG: Read Miss

> Processor 1 wants to access data that is only cached in processor 2

Processor 1 checks it cache (miss), then sends a read miss into the bus.  
Processor 2 changes its state from Exclusive to Shared  
Data is loaded from memory

> Processor 1 wants to access data that is cached by multiple processors

Processor 1 checks it cache (miss), then sends a read miss into the bus.  
The processors that contain the data change their state from Exclusive to Shared  
Data is loaded from memory

> Processor 1 wants to access data that has been cached AND modified by another processor 2

Processor 1 checks it cache (miss), then sends a read miss into the bus.  
Processor 2 sends an alert  
(Processor 1 waits)  
Processor 2 writes the updated value into the memory  
Data is loaded from memory

### EG: Read Hit

No state change, data is just read

### EG: Write Miss

Send RWITM signal (Read With Intent To Modify)  
When the line is loaded, it is immediately marked as modified (even before the modification)  
Write Policy: fetch-on-write

> Some other cache has a modified copy

The cache tells the processor that another processor has a copy of the modified data  
Processor surrenders the bus and waits  
Other processor access the bus and writes the modified data to main memory  
The other processor marks the cache line as invalid  
The processor then tries again

> No other cache has a modified copy

Other caches invalidate its own copy  
As usual

### EG: Write Hit

> Shared

Other caches will modify their state to invalid

> Exlusive

No control signal needs to be sent along the bus

> Modified

No control signal needs to be sent along the bus.  
Note: Other processors will already have their cache line marked as invalid

***

### Issues with Snooping

Scalability.  
A single bus and shared memory prevents processors from simultaneously accessing memory. In addition, each processor block needs to be queried for every operation.

### Directory Based Protocol (for NUMA)

Processors send signals directly to related processors to keep caches up to date.  
Uses a directory to keep track of the memory block status

Each processor has its own directory, which contains entries.  
Each entry contains a dirty bit, and a presence vector (length n, n is the number of processors)  
Each address has a 'home directory', given by the value of its address

![](/uploads/snipaste_2021-04-12_00-20-56.png)

![](/uploads/snipaste_2021-04-12_00-24-26.png)