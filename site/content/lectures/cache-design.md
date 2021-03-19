+++
categories = ["Lectures"]
date = 2021-03-19T06:42:12Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Cache Design"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Cache

A hardware component in the processor that is small, but fast!

To achieve a high cache hit rate, data blocks need to be dynamically transferred between the cache and main memory (i.e. _principle of locality_)

![](/uploads/snipaste_2021-03-19_17-55-52.png)

## Blocks

![](/uploads/snipaste_2021-03-19_18-01-46.png)  
\--> The tag is often the rest of the bits that weren't used to select the cache index

![](/uploads/snipaste_2021-03-19_18-12-41.png)

**If the cache is too small / block size is too big** - we may run into a 'thrashing' issue- where the contents in the cache constantly change -> negative impact as there will be a \~100% conflict miss

## Cache Structures

### Direct Mapped Cache

> A memory block can map to only one cache location

For a cache of 2^m blocks, a memory block with address X maps to the cache location `X mod 2^m` --> The least significant `m` bits of the memory block address

![](/uploads/snipaste_2021-03-19_17-49-48.png)

 Multiple addresses will map to the same cache block (and compete for use)

![](/uploads/snipaste_2021-03-19_18-00-06.png)  
![](/uploads/snipaste_2021-03-19_18-04-04.png)

### Set Associative Cache

### Fully Associative Cache

## Cache Concerns

### Where to put a memory block in cache?

Block Placement Strategy

### How to find a memory block in cache?

Block Identification

### If there are no free spaces, which block will be replaced?

Block Replacement

### When memory data is updated, how is the cache involved?

Write Strategy