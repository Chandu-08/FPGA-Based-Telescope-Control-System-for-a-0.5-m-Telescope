## Basys3 master XDC
## Replace the encoder pin assignments with the physical pins you
## actually use on your Basys3 board.

## 100 MHz clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

## Reset button
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## LED LD0
set_property PACKAGE_PIN U16 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]

## IMPORTANT:
## These are placeholders for encoder inputs.
## Verify the selected Pmod/header pins and voltage levels before use.
#
# set_property PACKAGE_PIN <PIN_FOR_ENCODER_A> [get_ports encoder_a]
# set_property IOSTANDARD LVCMOS33 [get_ports encoder_a]
#
# set_property PACKAGE_PIN <PIN_FOR_ENCODER_B> [get_ports encoder_b]
# set_property IOSTANDARD LVCMOS33 [get_ports encoder_b]

## Position and direction outputs are intentionally not constrained
## in the basic LED hardware test.
