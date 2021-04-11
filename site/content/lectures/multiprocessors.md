+++
categories = ["Lectures"]
date = 2021-04-11T08:07:42Z
draft = true
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