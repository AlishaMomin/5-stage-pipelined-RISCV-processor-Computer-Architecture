# 5-stage-pipelined-RISCV-processor-Computer-Architecture
This project requires you to build a 5-stage pipelined processor capable of executing a bubble sort program. Basically, you will be converting your single cycle processor to a pipelined one.

Normally the instructions you have already implemented should enable you to execute a bubble sort program with small additions i.e. you might need to implement the bgt instruction, or something similar, so that you know when you’d need to swap two values. This would require small modifications to the circuit.

Here’s the recommended course of action:

1.	You modify the single-cycle processor to be able to run the bubble sort code on it. Test and verify that it is doing the sorting correctly. Check which instructions are supported by RISC V single cycle processor implemented in lab 11. You can modify bubble sort instructions so that least changes are needed in architecture.
2.	You then proceed to modify the said processor to make it a pipelined one (5 stages). You test and run each instruction separately to verify that the pipelined version can at least execute one instruction correctly in isolation. Test each of them instructions.
3.	You introduce circuitry to detect hazards (data, control, and structural if needed) and try to handle them in hardware i.e. by forwarding, stalling, and flushing the pipeline. If this has been done correctly, then your bubble sort code should be able to function in its entirety.

# Project Task 1 (Implementation Help for Pipelined Processor and Forwarding Unit)
We have studied pipeline implementation of a RISC-V processor with data forwarding techniques
to overcome data hazards. 
Implement the pipeline version of RISC-V processor shown in Figure 1. Initialize all the pipeline registers to an appropriate size. The control values for the forwarding multiplexers are shown in Table 1. For each pipelined register, you can create a separate module. 
Table 1. The control values for forwarding multiplexers.
![CA](https://user-images.githubusercontent.com/60126292/150654080-2c5705d7-8d7d-4e46-b429-ed047555ab9b.PNG)

Refer to lecture slides in order to understand the behavior of forwarding unit,

Verify the functionality of forwarding by introducing data dependencies in R-format instructions. Do not check the dependency of a load instruction result on the next instruction, as the architecture shown in Figure 1 does not support stalling to overcome certain type of data hazard.

# For Task 2:
You will be modifying this to include stalling and pipeline flushing. After these modifications, you will be able to test bubble sort algorithm on pipelined processor.
![CA1](https://user-images.githubusercontent.com/60126292/150654133-0c84de78-628f-459f-9c34-5bcb13ea415b.PNG)

## Group Members:
1. Alisha Momin – am05757
2. Anmol Jumani – aj06198
3. Sana Fatima – sf06199
4. Syeda Areesha Najam – sn05985
