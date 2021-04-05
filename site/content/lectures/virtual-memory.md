+++
categories = ["Lectures"]
date = 2021-04-05T15:28:51Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Virtual Memory"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
Virtual memory is a memory management technique that uses the main memory and disk to create an illusion of very large memory to the user. It acts as a redirection layer to make user-based memory access easy.

* Each program has its own allocated virtual memory region, and they unaware of any redirection - virtual memory is transparent

![](/uploads/snipaste_2021-04-06_01-32-29.png)

* Page - A virtual block
* Page table - information of page mapping - located in the main memory
* Page hit - data accessed is found in the page table
* Page fault - data accessed is not found in the page table

![](/uploads/snipaste_2021-04-06_01-33-45.png)

![](/uploads/snipaste_2021-04-06_01-34-34.png)

![](/uploads/snipaste_2021-04-06_01-35-23.png)

## Page Table

![](/uploads/snipaste_2021-04-06_02-12-59.png)  
![](/uploads/snipaste_2021-04-06_02-13-18.png)

![](/uploads/snipaste_2021-04-06_02-19-09.png)  
![](/uploads/snipaste_2021-04-06_02-22-07.png)  
question kinda bad.  
Of the requested address, the first 12 bits are the page index, and the last 12 bits are the offset. (8KB -> 2**13 , round down is 12 bits)  
  
PTR + first 12 bits of the virtual address = PA frame

PA frame || 0x20 = 0x45020 ---> 0x6676

## Multi-level Page Tables

![](/uploads/snipaste_2021-04-06_02-27-55.png)

* Better if memory availability is sparse / not contiguous
* n'th level tables can be left un-initialised if not needed

## TLB (Translation Lookaside Buffer)

Small cache for the page table lookups.  
As the cache is small, cache design can be full aassociative.  
For mid-range machines, a small n-way set associative architecture may be used instead

![](/uploads/snipaste_2021-04-06_02-33-22.png)  
![](/uploads/snipaste_2021-04-06_02-33-45.png)  
![](/uploads/snipaste_2021-04-06_02-34-05.png)  
![](/uploads/snipaste_2021-04-06_02-34-51.png)

# Hardware Address Translation

![](/uploads/snipaste_2021-04-06_01-36-52.png)