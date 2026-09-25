# Project Status

## Current stage

The project is currently in the FPGA encoder-processing and hardware-verification stage.

## Completed

- Basys3 board setup
- Vivado project setup
- VHDL module development
- Encoder A/B signal synchronization
- Quadrature decoding
- Direction detection
- Position counting
- Complete-revolution detection
- LED indication
- Initial hardware verification

## Current hardware

- Basys3 FPGA
- Autonics E50S8-3600 incremental encoder
- A/B quadrature signals

## Next development stages

1. Verify encoder angle calculation.
2. Add encoder Z/index processing.
3. Complete the electrical interface between FPGA and servo drive.
4. Interface with the Delta servo drive.
5. Control the Delta servo motor.
6. Implement closed-loop position control.
7. Extend the controller toward telescope axis control.
8. Add PC/telescope control interface.
9. Implement tracking functions.

## Important note

The motor/servo-drive portion should only be connected after the electrical interface, voltage levels, isolation/protection, and drive configuration have been verified.
