+++
categories = ["Lectures"]
date = 2021-03-15T14:46:04Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Introduction to Memory"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++

![](Snipaste_2021-03-15_04-14-49.png)

## SRAM

![](Snipaste_2021-03-15_03-26-21.png)

**16-word 4-bit SRAM structure**

![](Snipaste_2021-03-15_03-31-04.png)

![](Snipaste_2021-03-15_03-32-44.png)

* Precharge required to get the electrical components to their required voltage/energy

## DRAM

![](Snipaste_2021-03-15_03-37-05.png)

![](Snipaste_2021-03-15_03-37-33.png)

**Typical DRAM bank**

![](Snipaste_2021-03-15_03-38-34.png)

Only half the number of address bits is required, as we can switch usage of the input as a row or column selector

**1-transistor DRAM cell**

![](Snipaste_2021-03-15_03-41-02.png)

As a result of the circuit configuration, the voltage/current in the capacitor can drain over time. Therefore a refresh is required (i.e. doing a dummy read/write to every cell in a row) - which is often performed by special hardware refresh control components. This operation is power hungry and sacrifices performance.

![](Snipaste_2021-03-15_03-45-29.png)

**DRAM Access Cycle**

> The entire row must be read at a time

1. Open the row related to the memory location (and precharge)
2. Access the column (read / write)
3. Precharge the bit lines for the next different row access

**Performance**

![](Snipaste_2021-03-15_03-47-29.png)

### Increasing Data Throughput

**Burst Mode** - Consecutive accesses without the need to send the address of each word in the row.  
Saves T\_rac (row access delay), by only sending the other required column (word) addressess  
![](Snipaste_2021-03-15_03-53-17.png)  

**Multi-bank Interleaved Access** - Access different banks at the same time.  
![](Snipaste_2021-03-15_03-55-20.png)

**Wide memory data bus** - Transfer multiple words at the same time along the data bus line  
![](Snipaste_2021-03-15_03-56-13.png)  
![](Snipaste_2021-03-15_03-58-47.png)

### Increasing Data Rate

**DDR DRAM** (Double Data Rate) - Transfer on both rising and falling clock edges  
**QDR DRAM** (Quad Data Rate) - DDR functionality on separate input and output port

## Hard Disk Drives (HDD)

Disks contains magnetically-coated platters, which contain tracks that are split into sectors.  
The magnetic orientation of the field represents a bit.  

The controller handles the read/write mechanism, motor operation, etc.

**Performance / Delays**

* Seek time - time between file request and when the first byte is received (~10-20ms)
* Rotational latency - time required for the first bit of the data sector to pass through the read/write head (~2-4ms)
* Data rate - bytes per second that the drive can deliver to the CPU 

## Solid State Disks (SSD) and Flash

* Everything is electronic - no mechanical moving parts
* Each cell is a modified transistor with a floating gate and a control gate
* The two gates are separated by a thin oxide layer
* The floating gate 'links' to the word line throug the control gate with a small threshold
  * When linked, the cell has a value of `1`, else `0`
  * When unlinked (through negative electrons acting as a barrier), there is a large threshold; preventing current from flowing
![](Snipaste_2021-03-15_04-09-16.png)
![](Snipaste_2021-03-15_04-08-11.png)

---

## Trends | CPU vs Memory improvements

![](Snipaste_2021-03-15_04-10-49.png)

---

![](Snipaste_2021-03-15_04-12-25.png)