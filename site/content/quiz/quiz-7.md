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
c. Multiple cores in a UMA multiprocessor can send data to each other simultaneously.  
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

.

***

> Consider the following binary search algorithm that searches for a value X in a sorted N-element array A
>
> and returns the index of the matched entry:
>
> BinarySearch(A\[0..N-1\], X) {
>
>                              low = 0
>
>                              high = N-1
>
>                              while (low <=high) {
>
>                                                  mid = (low+high)/2
>
>                                                  If (A\[mid\]>X)
>
>                                                                       high = mid-1
>
>                                                  else if (A\[mid\]< X)
>
>                                                                       low = mid+1
>
>                                                  else
>
>                                                                       return  mid //found
>
>                              }
>
>                              return -1 //not found
>
>          }
>
> Assume that you have Y cores on a multi-core processor to run the Binary Search. 
>
> What maximal speedup can be obtained as compared to one-core processor?

.

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

.