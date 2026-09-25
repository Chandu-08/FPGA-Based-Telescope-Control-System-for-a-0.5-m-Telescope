# FPGA-Based Telescope Control System

## Overview

This project focuses on developing an FPGA-based control system
for a 0.5-meter telescope. The system is designed to provide
accurate encoder-based position measurement and deterministic
real-time control of telescope axes.

The current implementation focuses on interfacing an incremental
quadrature encoder with a Basys3 FPGA and processing the encoder
signals using VHDL.

## Current Implementation

- Basys3 FPGA development board
- VHDL-based digital logic
- Incremental quadrature rotary encoder
- A/B phase signal processing
- Encoder direction detection
- Position counting
- Encoder revolution detection
- LED indication for one complete encoder revolution
- Vivado simulation and synthesis

## Encoder

Encoder:
Autonics E50S8-3600

Specifications used in the project:

- 3600 PPR
- Incremental quadrature encoder
- A, B and Z signals
- 4× quadrature decoding
- 14400 counts/revolution

## FPGA

Development board:

- Digilent Basys3
- Xilinx Artix-7 FPGA
- Vivado Design Suite
- VHDL

## System Flow

Encoder A/B
      ↓
Input Synchronization
      ↓
Quadrature Decoder
      ↓
Position Counter
      ↓
Angle / Position Processing
      ↓
Output / Control Logic

## Project Status

Currently under development.

Completed:
- FPGA setup
- Encoder interfacing
- VHDL encoder processing
- Quadrature signal detection
- Position counting
- Rotation detection
- LED-based hardware verification

Future work:
- Servo drive interfacing
- Motor control
- Telescope axis control
- Closed-loop position control
- PC-based telescope control interface
- Celestial tracking
