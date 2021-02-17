+++
date = 2021-02-15T11:35:36Z
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
> **This course uses the MIPS ISA**

***

# Overview of a Computer System

A computer system is a combination of both hardware and software components

**Application software** (written for end users) are created in a high-level language (HLL). HLL allows the code to be portable between platforms, without tying the code to a specific working environment.

**System software** such as the **compiler** translate the HLL code into machine code, which is code specific to a certain platform (i.e. ARM, MIPS, amd64, x86). The **operating system** provides a universal framework for applications to use in a systematic and fair manner - handling I/O, memory, storage, and other resource scheduling tasks.

**Hardware** such as the processor, memory modules and I/O controllers interact with the software to carry out tasks

# Execution Cycle

![](/uploads/snipaste_2021-02-18_02-26-40.png)

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

# Instruction Set Architecture

![](/uploads/snipaste_2021-02-18_02-27-30.png)

Goal: The instruction set should be easy to implement, good for performance, and possibly more

Design Principles:

* Simplicity favours regularity
* Smaller is faster
* Good design demands a compromise
* Make the common case fast

## An Example - MIPS

![](/uploads/snipaste_2021-02-18_02-30-12.png)

## General Purposes Registers

Registers are data storage locations that have **faster performance** than memory, and **require less bits** to target its address (compared to a memory address)

## Addresses

Big Endian - Most significant byte stored at the end - most modern systems use this  
Little Endian - Least significant byte stored at the end

Alignment - Words fall on addresses that are multiples of their size

### Addressing Modes

![](/uploads/snipaste_2021-02-18_02-54-14.png)

### Which Mode Should I Implement

idk analyse and profile them (but actually)

![](/uploads/snipaste_2021-02-18_02-58-44.png)

## Instruction Format

* Varied - each instruction uses its own required width
* Fixed - all instructions have the same width
* Hybrid - instructions are divided into groups which each require a different fixed width

### Design Choices

* If code size is most important, use variable width instructions.
* If performance is most important, use fixed width instructions

***

**This course uses the MIPS ISA**

***

# MIPS

* RISC ISA
* All instructions are of 32 bits
* 3 instruction format types
* Arithmetic and logic operations are always performed on registers
* 32x 32-bit integer registers
* 32x 32-bit floating point registers
* Single address mode when accessing data in memory (base + displacement)
* Simple branch conditions (eq, ne)

## Registers

### R-Type (Register)

![](/uploads/snipaste_2021-02-18_03-40-55.png)  
e.g. `add $1, $2, $3`

### I-Type (Immediate)

![](/uploads/snipaste_2021-02-18_03-40-58.png)  
e.g. `addi $1, $2, 100`

### J-Type (Jump)

![](/uploads/snipaste_2021-02-18_03-41-01.png)  
e.g. `j 1000`

***

![](/uploads/snipaste_2021-02-18_03-43-49.png)