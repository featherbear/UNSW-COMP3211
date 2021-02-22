+++
date = 2021-02-22T08:06:06Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 1"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
# Which of the following statements is/are NOT True?

**a. MISP is a CISC machine.**  
b. In MIPS, assume an integer is stored in memory at a location labeled as A, you can use the label to access the data.  
**c. Instruction ADD r0, r1, r2 can be used to add any two integer values.**  
d. In MIPS, all arithmetic and logic operations are performed on registers.

(c) - Can only add up to 32-bit??

# What are the possible reasons that the MIPS design does not have instructions BLT (branch if less than) and BGE (branch if greater or equal)?

The implementation of BLT / BGE would have to first perform some sort of subtraction instruction, followed by a comparison instruction - which would take at least two cycles for such an instruction. In a single cycle processor design (MIPS) - such an instruction can not be (simply) designed.

MIPS also has other instructions that are more efficient, such as BLTZ (branch if less than zero) - which only need to check the status register (or at most, the sign bit of the result register)

# Find a shortest sequence of MIPS instructions that extracts bits 16 down to 11 from register $t0 and uses the value of this field to replace bits 31 down to 26 in register $t1 without changing the other 26 bits of register $t1.

``` 
# ori $v0, $t0, 0b1111100000000000 # 0x01F800
# ori $t1, $t1, 0b11111100000000000000000000000000000 # 0xFC000000
# xor $t1, $v0, $t0

srl $v0, $t0, 11 # v0 = 00000000000.....XXXXXX
sll $v0, $v0, 26 # v0 = XXXXXX00000000000000...
sll $t1, $t1, 6 # t1 = ......000000
srl $t1, $t1, 6 # t1 = 000000......
or $t1, $t1, $v0
```

# The following instruction is not included in the MIPS instruction set

> `rpt rs, loop # if (R[rs]>0) R[rs]=R[rs]-1, PC=PC+4+BranchAddr`

## If this instruction were to be implemented in the MIPS instruction set, what is the most appropriate instruction format?

* `rs` would likely be a register value - so either R or I type
* No register is being affected, so it is therefore an I-type instruction

## What is the shortest sequence of MIPS instructions that performs the same operation?

(Are we meant to answer with instructions not taught from the course?)

* What is _loop_???
* Is PC=PC+4+BranchAddr part of the conditional block?

Badly worded question. Responding assuming that this question is asking to translate

    if (R\[rs\] > 0) {  
      R\[rs\] = R\[rs\] - 1  
      goto loop  
    }
    
    bltz rs, done  
    addi rs, rs, -1  
    j loop  
    done:

# Assume stack is used in a processor design, where all ALU operations are performed on stack.

(For example, instruction ADD takes (pops) two data items from the stack top and saves (pushes) the result to the stack.)

With this design, what operation order should follow for the following calculation?

> `A*B - C*D + E*F`

```
* Multiply A*B to have stack order (A*B, C, D, E, F)
* Move A*B off the stack to have order (C, D, E, F)
* Multiply C*D to have stack order (C*D, E, F)
* Move C*D off the stack to have order (E, F)
* Multiply E*F to have stack order (E*F)
* Push C*D onto the stack to have order (C*D, E*F)
* Subtract C*D - E*F to have stack order (C*D-E*F)
* Push A*B onto the stack to have order (A*B, C*D-E*F)
* Subtract A*B - (C*D-E*F) to have result (A*B - C*D + E*F)
```