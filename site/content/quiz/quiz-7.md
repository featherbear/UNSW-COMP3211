+++
categories = ["Quiz"]
date = 2021-04-11T15:39:15Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 7"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
> Which of the following statements is/are not true?

a. Vector processor is good for manipulating vectors.  
b. Uniprocessor does not possess any parallel computing architecture.  
**c. Multiple cores in a UMA multiprocessor can send data to each other simultaneously.**  
d. If the memory in a shared-memory multiprocessor is very slow, it may be helpful to use level-2 cache to reduce the average memory access time.

***

> Consider the following portions of programs running in parallel on four processor cores in a UMA multiprocessor.
>
> Assume before the code portions are executed, both x and y are 0.
>
>                    Core 1: x=2;
>     
>                    Core 2: y=2;
>     
>                    Core 3: w = x+y+1;
>     
>                    Core 4: z=x+y;
>
> What are the possible resulting values for w, x, y, and z?

The factors that affect the resulting values include the following

* Which core accesses the memory first
* If the core stalls

w will always result in 2
y will always result in 2

* w,x,y,z
* 2,2,1,0
* 2,2,1,2
* 2,2,1,4
* 2,2,3,0
* 2,2,3,2
* 2,2,3,4
* 2,2,5,0
* 2,2,5,2
* 2,2,5,4

***

> Consider the following binary search algorithm that searches for a value X in a sorted N-element array A
>
> and returns the index of the matched entry:
>
>      BinarySearch(A\[0..N-1\], X) {
>     
>                                   low = 0
>     
>                                   high = N-1
>     
>                                   while (low <=high) {
>     
>                                                       mid = (low+high)/2
>     
>                                                       If (A\[mid\]>X)
>     
>                                                                            high = mid-1
>     
>                                                       else if (A\[mid\]< X)
>     
>                                                                            low = mid+1
>     
>                                                       else
>     
>                                                                            return  mid //found
>     
>                                   }
>     
>                                   return -1 //not found
>     
>               }
>
> Assume that you have Y cores on a multi-core processor to run the Binary Search.
>
> What maximal speedup can be obtained as compared to one-core processor?

This depends on how the multiple cores are used together.

A binary search has a time complexity of log(n) 

If the algorithm is implemented strictly to the above code, then only the parameters A and N can be modified. Each core can run the algorithm over a reduced set of values (partition the values into Y groups). This provides a new time complexity of log(n/k) + C where C is the overhead for communicating between cores.

i.e. when Y is 2, one core can search between 0 and N/2, whilst the other searches between (N/2)+1 and N-1

***

> Matrix multiplication plays an important role in many applications. For a matrix multiplication
>
> C = A.B, where A is an mxn matrix and B an nxp matrix,
>
> what is the maximal speedup we would expect to obtain on a 4-core multiprocessor
>
> as compared to the single-core processor?
>
> Discuss the possible issues that affect the speedup.

In an `m x n` * `n x p` matrix multiplication scenario, there could be a maximum speedup of roughly 4x (likely a little under) by dividing the `m x n` matrix into four `m/4 x n` matrices - each core working on one of the four sub-matrices; or perhaps splitting the other matrix into four `n x p/4` groups

It is likely that the speedup won't reach 4x due to overhead in co-ordinating the four cores to execute their tasks, as well as to collect their results. If each core wrote its result directly into a shared memory, there may incur additional overhead from mutex activity. Regardless, there will still be an improvement of 4-C times (C represents the overhead)