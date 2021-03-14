+++
categories = ["Quiz"]
date = 2021-03-14T18:12:43Z
hiddenFromHomePage = false
postMetaInFooter = false
title = "Quiz 4"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
> For the pipelined processor design, which of the following statements is/are not true?

**a. Hazards in the pipelined processor can always be handled by compiler.**  
b. Pipelining can only improve throughput but cannot reduce latency.  
**c. For the memory components in the pipelined datapath, DRAMs are often used.**  
**d. All of the above statements are true.**

- a. Processor doesn't know of instruction order, just runs whatever it is given
- a. There is a hazard detection unit to help mitigate hazards during runtime
- c. SRAM probably used, don't need as much memory, and is faster
- d. ...

> Assume the static prediction, Not Taken, is applied to the design shown below.  
In order to achieve a speedup of 2 for the BEQ instruction (as compared to the design without prediction), what should the prediction accuracy be?  
  
![](/uploads/pipe3.png)

a. 1/3  
**b. 2/3**  
c. 4/5  
d. None of the above

`4/(4-3x) = 2`, so `x = 2/3`

> The figure below shows an improved design for the control hazard handling.  
What is the logic expression for the control signal IF.flush?  
  
![](/uploads/pipe4.png)

Assuming prediction is always branch:  
`IF.flush <= (opcode eq branch_like_instruction) and (regA xor regB)`

> Figure below shows a design for three-input addition (i.e. r=a+b+c) based on the 2-input adder.  
All values in the design are n bits long.  
How would you modify the design to speed up the array addition R=A+B+C? where R, A, B and C are arrays.  
  
![](/uploads/add3.png)

Change the 2-input adder into a single 3-input adder idk (some variant of a ripple-carry adder?)??? Or assign the output of each bit of the first adder stage to the inputB and control signal of a 1-bit 2-mux, such that if the bit is 0, the mux will select the bit from the third value.

> Discuss the reason that DRAM is slow and SRAM is fast.  

Due to the capacitor design of DRAM-based memory, the electrical charge in the capacitor leaks and loses its strength. To mitigate this issue, a refresh control unit/component/function must be used to maintain the charge of the capacitor - however this causes extra utilisation of the circuit, preventing the system from meaningfully access the memory to read/write data. DRAM-based memory must also wait for their capacitors to physically charge (t=RC).

On the other hand, SRAM-based memory units use a flip-flip circuit to maintain the bit value; which does not suffer from current leakage, and hence more user-time is allocated for meaningful operations

> Given the DRAM cell shown below, what are the possible solutions to increase the refresh interval without loss of the stored data?  
![](/uploads/DRAM_cell.png)

* (RAAR) Retention-Aware Auto-Refresh - uhh yeah
* Figure out the interval limit to which the data can be retained, and refresh only at the last minute.
* Stagger the refresh time between rows of cells - Overall perceived refresh interval will be longer
* Increase the capacitance / get a larger capacitor (however would also increase required charge time)
* Better transistors that don't leak as much
* Keep the circuit cool - leakage from heat loss increases as the resistance of the circuit increases
