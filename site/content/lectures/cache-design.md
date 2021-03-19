+++
categories = ["Lectures"]
date = 2021-03-19T06:42:12Z
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

### Cache Too Small?

**If the cache is too small / block size is too big** - we may run into a 'thrashing' issue- where the contents in the cache may start to constantly change -> negative impact as there will be a \~100% conflict miss.

i.e. if there are 4 cache blocks, but 5 items that need to be accessed. After the first four cache items populate, the fifth block will replace the first item; but then the first block will need to be read from the cache

* Solution 1 - Increase the cache size
* Solution 2 - Multiple entries for a memory block (a memory block can map to multiple cache blocks) -> refer to associative cache

## Cache Structures

### Direct Mapped Cache

> A memory block can map to only one cache location

For a cache of 2^m blocks, a memory block with address X maps to the cache location `X mod 2^m` --> The least significant `m` bits of the memory block address

![](/uploads/snipaste_2021-03-19_17-49-48.png)

 Multiple addresses will map to the same cache block (and compete for use)

![](/uploads/snipaste_2021-03-19_18-00-06.png)  
![](/uploads/snipaste_2021-03-19_18-04-04.png)

### Set Associative Cache

> n-way set associative cache

The cache is divided into sets, each that contains `n` blocks. A memory block is mapped to a set, and can be stored in any location in the set.

* `n` comparators are required to search a block in a set

![](/uploads/snipaste_2021-03-19_19-44-30.png)

> Given an 8-block cache, how is the memory block 12 placed in the cache using a 2-way set associative cache?

There are 4 sets of 2-block caches, so 12 % 4 = 0 -> Set 0 will be used

![](/uploads/snipaste_2021-03-19_19-53-26.png)

* `2` -> Block size is 4 byte = 2^2
* `3` -> 64 byte cache / (2 * 4 byte blocks) = 8 sets of 2 blocks; 8 = 2^3

### Fully Associative Cache

A memory block can be mapped to any location in the cache; however this increases the cache search time, as the full cache needs to be searched for a memory block

![](/uploads/snipaste_2021-03-19_19-13-19.png)

***

## Cache Concerns

### Where to put a memory block in cache?

Block Placement Strategy

### How to find a memory block in cache?

Block Identification

### If there are no free spaces, which block will be replaced?

Block Replacement

### When memory data is updated, how is the cache involved?

Write Strategy