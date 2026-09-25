# Simulation

The testbench in `../testbench/telescope_encoder_tb.vhd` is intended to verify:

- Encoder A/B state transitions
- Quadrature decoding
- Direction detection
- Position counting
- Revolution detection
- LED activation

For simulation, the top-level generic values are reduced so that the test completes quickly.

For hardware, the real encoder value is:

- PPR = 3600
- 4x quadrature
- Counts/revolution = 14400

Open the waveform in Vivado and observe:

- `encoder_a`
- `encoder_b`
- `direction`
- `position`
- `led`
