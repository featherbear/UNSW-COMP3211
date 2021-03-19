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

## Cache Concerns

### Where to put a memory block in cache?

Block Placement Strategy

### How to find a memory block in cache?

Block Identification

### If there are no free spaces, which block will be replaced?

Block Replacement

### When memory data is updated, how is the cache involved?

Write Strategy