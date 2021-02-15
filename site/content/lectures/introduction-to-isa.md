+++
date = 2021-02-15T11:35:36Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Introduction to ISA"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Overview of a Computer System

A computer system is a combination of both hardware and software components

**Application software** (written for end users) are created in a high-level language (HLL). HLL allows the code to be portable between platforms, without tying the code to a specific working environment.

**System software** such as the **compiler** translate the HLL code into machine code, which is code specific to a certain platform (i.e. ARM, MIPS, amd64, x86). The **operating system** provides a universal framework for applications to use in a systematic and fair manner - handling I/O, memory, storage, and other resource scheduling tasks.

**Hardware** such as the processor, memory modules and I/O controllers interact with the software to carry out tasks

# What is "Computer Architecture"

> "Computer architecture, like other architecture, is the art of determining the needs of the user of a structure and then designing to meet those needs as effectively as possible within economic and technological constraints." - Frederick P. Brooks

## ISA (Instruction Set Architecture)

The ISA is the interface between the hardware and software of a computer system. It defines the attributes and functions implemented by hardware that will be used by the software programmer.

A family of machines can often share a basic ISA - i.e the Intel x86 family

Modern ISAs

* CISC (Complex Instruction Set Computer) - VAX, PDP-11, x86, 6800
* RISC (Reduced Instruction Set Computer) - SPARC, PowerPC, RISC-V, AVR, ARM, MIPS

## Machine Organisation

Machine organisation refers to how the ISA is actually implemented.

i.e. is there an actual multiplier unit for a multiply instruction; is it implemented with combinational or sequential method? (or other?)