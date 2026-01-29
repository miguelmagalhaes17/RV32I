This is the description of the 5-stage architecture, RV32I instruction set.


The work is divided across 5 stages, separated by pipeline registers that hold the data between cycles.

|Stage | Name | Key Components | Purpose |
|------|------|-----------------|---------|
|IF |Instruction Fetch|Program Counter (PC), Instruction Memory|Get the 32-bit instruction from memory.|
|ID|Instruction Decode|Register File, Control Unit, Imm Gen|Figure out what the instruction is and read the registers.|
|EX|Execute|ALU, Branch Comparator|Perform math (+ , − , etc.) or calculate a memory address."|
|MEM|Memory Access|Data Memory|Load from or store data to RAM (if needed).|
|WB|Write Back|Mux (Result Select)|Write the final result back into the Register File.|


# Design Components (Verilog Modules)

ALU: handles arithmetic and logic.
Register file: 32x32 bit array.
Control unit: \|"TODO"\|
Immediate generator: extracts constants from the instruction.
Forwarding unit: sends data from the EX or MEM stages back to the ID stage so the CPU doesn't have to wait.
Hazard detection unit: stalls the pipeline if the data isn't ready.


## Iteration 1. Integer Register-Immediate Instructions (ADDI)

![alt text](image.png)

ADDI adds the sign-extended 12-bit immediate to register rs1. Arithmetic overflow is ignored and the result is simply the low XLEN bits of the result. ADDI rd, rs1, 0 is used to implement the MV rd, rs1 assembler pseudoinstruction.

## ALU

Performs the common operations:

Add, Subtract, Bitwise AND, Bitwise OR, Bitwise XOR, Set Less Than (unsigned), Set Less Than (signed), Shift Left Logical, Shift Right Logical, Shift Right Arithmetic