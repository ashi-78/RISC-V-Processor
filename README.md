# RISC-V-Processor
Verilog-based RISC-V processor with simulation and waveform analysis
# RISC-V Processor (Verilog)

## Overview
This project implements a pipelined 32-bit RISC-V processor using Verilog HDL.  
The processor executes real machine-level programs generated from C code and validates correct instruction execution across a 5-stage pipeline architecture: Fetch, Decode, Execute, Memory, and Write-back.

---

## Features
- 32-bit RISC-V instruction set
- 5-stage pipelined architecture
- Hazard detection and forwarding unit
- Register file and ALU design
- Instruction and data memory integration
- Execution of real programs converted from C

---

## Design Modules
- Fetch Cycle
- Decode Cycle
- Execute Cycle
- Memory Cycle
- Write Back Cycle
- Control Unit
- ALU & Register File
- Hazard Unit (Forwarding Logic)

---

## Tools Used
- Verilog HDL
- Icarus Verilog (iverilog)
- GTKWave (Waveform Analysis)
- Quartus Prime (Simulation & Validation)

---

## Program Execution

A real C program was converted into machine instructions and executed on the designed RISC-V processor.

### Flow:
- C program written externally
- Converted into hexadecimal machine instructions
- Loaded into instruction memory using `memfile.hex`
- Executed through simulation

This validates correct datapath operation, control logic, and pipeline execution.

---

## Simulation

Simulation was performed using a testbench (`tb.v`).

