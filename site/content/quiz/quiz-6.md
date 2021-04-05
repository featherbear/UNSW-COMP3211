+++
categories = ["Quiz"]
date = 2021-04-05T16:35:42Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 6"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
> Which of the following statement is/are not true?

**a. For the direct-mapped cache, the random replacement policy is usually better than the least recently used policy.**  
**b. There is no way to reduce compulsory misses.**  
c. Fully associative cache has no conflict misses.  
d. The cache performance is measured by cache miss rate.

_b- Well actually, you could attempt to preload the cache. Hmph._

***

> The figure below shows a processor system. The write buffer can hold the data of four writes. Assume the data memory access time is 20 clock cycles.  
> How frequently can the processor write data to memory without the write buffer saturation?
>
> ![](/uploads/cache-with-write-buffer.png)

**a. On average, one write every 20 clock cycles.**  
b. On average, one write per 4 clock cycles.  
c. On average, one write per 5 clock cycles.  
d. None of the above

***

> Given a program execution that has a fixed number of write operations, is it true that the write back policy is always better than the Write Through policy in terms of performance?
>
> Explain your answer.

No - WB is not ALWAYS better than WT.

WB policy performs well when the same piece of data is constantly updated, and when there is spatial locality between target addresses.

However, in the event that address selection is rather arbitrary, the extra time overhead for dirty-bit related operations will incur a negative performance penalty

Also there may be synchronisation issues if the same address is requested by two separate components

***

> The figure (a) below shows the initial contents of a direct mapped cache.
>
> Its controller is given in figure (b).
>
> List the controller state transition sequence when the following memory accesses are made by the processor.
>
> 10110 (read), 11010 (read), 10110 (read), 00010 (write)
>
> ![](/uploads/cache-controller.png)

\[Idle\]  
  
:: request address 10110 :: -> \[Compare Tag\]  
Cache Miss -> \[Allocate\]  
Memory Ready -> \[Compare Tag\]  
Mark Cache Ready -> \[Idle\]

  
:: request address 11010 :: -> \[Compare Tag\]  
Cache Miss -> \[Allocate\]  
Memory Ready -> \[Compare Tag\]  
Mark Cache Ready -> \[Idle\]  
  
:: request address 10110 :: -> \[Compare Tag\]  
Cache Hit -> \[Idle\]  
  
:: request address 00010 :: -> \[Compare Tag\]  
Cache Miss (tag mismatch) -> \[Allocate\]  
Memory Ready -> \[Compare Tag\]  
Set Dirty bit, Mark Cache Ready -> \[Idle\]