+++
categories = ["Lectures"]
date = 2021-03-01T14:26:44Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Performance"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Performance Metrics

## Latency

> response time, execution time, elapsed time

Latency metrics help to describe how long it takes to execute a task.

This metric is good for a fixed amount of work

## Throughput

> work unit per time

Throughput metrics help to describe how much work can be done in a given period of time

This metric is good for a fixed amount of time.

***

Ideally we want low latency and high throughput, however in reality this can be hard to achieve

***

# Performance Comparison

When comparing the performance of two designs for a given task, we often compare their **execution time**.

> Given two designs X and Y, if X is `n` times faster than Y, then `exec(Y)/exec(X) = n`  
> Where `n > 1` 

## Processor Performance

> Based on CPU time

![](/uploads/snipaste_2021-03-02_01-44-03.png)

The CPI varies from instruction to instruction - hence we calculate the average!  
_(To do so, we group instructions by the number of cycles needed, etc)_

![](/uploads/snipaste_2021-03-02_01-45-34.png)

***

![](/uploads/snipaste_2021-03-02_01-50-02.png)  
Answer: **D**

![](/uploads/snipaste_2021-03-02_01-50-52.png)  
Answer: A, by 1.2x  
  
Execution time = instruction count * CPI * cycle time  
Given the same instruction count, machine A is faster than machine B by 1.2x

***

### Impact on Processor Performance