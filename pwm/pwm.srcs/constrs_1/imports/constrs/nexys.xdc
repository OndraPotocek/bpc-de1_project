# =================================================
# Nexys A7-50T - General Constraints File
# Based on https://github.com/Digilent/digilent-xdc
# =================================================

# -----------------------------------------------
# Clock
# -----------------------------------------------
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

# -----------------------------------------------
# Push buttons
# -----------------------------------------------
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {rst_btnc}];
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports {btnu}]; # sawtooth
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports {btnl}]; # sine
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports {btnr}]; # swuare

# -----------------------------------------------
# Switches
# -----------------------------------------------
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {sw[0]}];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {sw[1]}];
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {sw[2]}];
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports {sw[3]}];
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports {sw[4]}];
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports {sw[5]}];
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports {sw[6]}];

# -----------------------------------------------
# LEDs --> waveform type ? 
# -----------------------------------------------
#set_property PACKAGE_PIN H17 [get_ports {led[0]}]; 
#set_property PACKAGE_PIN K15 [get_ports {led[1]}];
#set_property PACKAGE_PIN J13 [get_ports {led[2]}];
#set_property PACKAGE_PIN N14 [get_ports {led[3]}];
#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

# -----------------------------------------------
# Seven-segment cathodes CA..CG + DP (active-low)
# seg[6]=A ... seg[0]=G
# -----------------------------------------------
set_property PACKAGE_PIN T10 [get_ports {seg[6]}]; # CA
set_property PACKAGE_PIN R10 [get_ports {seg[5]}]; # CB
set_property PACKAGE_PIN K16 [get_ports {seg[4]}]; # CC
set_property PACKAGE_PIN K13 [get_ports {seg[3]}]; # CD
set_property PACKAGE_PIN P15 [get_ports {seg[2]}]; # CE
set_property PACKAGE_PIN T11 [get_ports {seg[1]}]; # CF
set_property PACKAGE_PIN L18 [get_ports {seg[0]}]; # CG
set_property PACKAGE_PIN H15 [get_ports {dp}];
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*] dp}]

# -----------------------------------------------
# Seven-segment anodes AN7..AN0 (active-low)
# -----------------------------------------------
set_property PACKAGE_PIN J17 [get_ports {an[0]}];
set_property PACKAGE_PIN J18 [get_ports {an[1]}];
set_property PACKAGE_PIN T9  [get_ports {an[2]}];
set_property PACKAGE_PIN J14 [get_ports {an[3]}];
set_property PACKAGE_PIN P14 [get_ports {an[4]}];
set_property PACKAGE_PIN T14 [get_ports {an[5]}];
set_property PACKAGE_PIN K2  [get_ports {an[6]}];
set_property PACKAGE_PIN U13 [get_ports {an[7]}];
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]

# -----------------------------------------------
# RGB LEDs
# -----------------------------------------------
#set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports {led16_r}];
#set_property -dict { PACKAGE_PIN M16 IOSTANDARD LVCMOS33 } [get_ports {led16_g}];
#set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports {led16_b}];

#set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports {led17_r}];
#set_property -dict { PACKAGE_PIN R11 IOSTANDARD LVCMOS33 } [get_ports {led17_g}];
#set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports {led17_b}];

# -----------------------------------------------
# Pmod Header JA ==> for connecting oscilloscope
# -----------------------------------------------
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports {oscilloscope}];

# -----------------------------------------------
# (Remaining peripherals preserved but omitted here for brevity)
# JB, JC, JD, XADC, VGA, SD, Ethernet, Audio, etc.
# Same conversion style applies:
#
# # set_property PACKAGE_PIN <PIN> [get_ports {<signal>}]
# # set_property IOSTANDARD LVCMOS33 [get_ports {...}]
#
# -----------------------------------------------

##PWM Audio Amplifier
set_property -dict { PACKAGE_PIN A11 IOSTANDARD LVCMOS33 } [get_ports { AUD_pwm }]; 
set_property -dict { PACKAGE_PIN D12 IOSTANDARD LVCMOS33 } [get_ports { AUD_sd }];
# help from https://github.com/Digilent/Nexys-A7-50T-XADC/blob/master/src/constraints/Nexys-A7-50T-Master.xdc

