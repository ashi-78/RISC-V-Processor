# RISC-V Processor (RV32I)

A Verilog-based 32-bit, 5-stage pipelined RISC-V processor with simulation and waveform analysis.

## Overview

This project implements a 32-bit RISC-V processor using Verilog HDL. The design follows a 5-stage pipeline architecture consisting of Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB).

The processor includes pipeline-stage modules, a register file, an ALU, control logic, and a hazard unit with forwarding and flush control. The design is simulated using Icarus Verilog, with internal signals inspected in GTKWave. Intel Quartus Prime is used for RTL inspection and synthesis.

## Features

- 32-bit RV32I-based processor design
- 5-stage pipelined datapath
- ALU and register file
- Instruction and data memory modules
- Forwarding logic and pipeline flush control
- Testbench-based RTL simulation
- Waveform inspection using GTKWave
- RTL inspection and synthesis using Intel Quartus Prime

## Design Modules

- Fetch Cycle
- Decode Cycle
- Execute Cycle
- Memory Cycle
- Write Back Cycle
- Control Unit
- ALU and Register File
- Hazard Unit / Forwarding Logic

## Tools Used

- Verilog HDL
- Icarus Verilog (`iverilog`)
- GTKWave
- Intel Quartus Prime

## Instruction Memory and Simulation

The processor simulation uses machine-code instructions supplied through the instruction-memory file (`memfile.hex`). Instructions are manually entered into the file before running the simulation.

A testbench (`tb.v`) is used to simulate the design, and GTKWave is used to inspect pipeline signals and execution behavior.

**Note:** A complete C-to-machine-code compilation flow and execution of arbitrary C programs have not been established for this project.

## Synthesis

The RTL design was inspected and synthesized using Intel Quartus Prime. The Quartus RTL Viewer provides a view of the synthesized design structure.
