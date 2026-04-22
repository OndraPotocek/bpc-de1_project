# Waveform Generator
Waveform Generator is project for BPC_DE1 subject at Brno University of Technology - faculty of electrical engeneering and comunication.

## Features
- PWM generatrion - setting period and duty cycle with buttnost and switches on FPGA board NEXYS A7 50T.
- view output signal on an LED (oscilloscope) and/or headphone jack
- view period/immediate change of amplitude on a 7 segment diplay (soon to be added into the schematic)


## Schematic
<img width="1660" height="929" alt="schema_21_4 drawio" src="https://github.com/user-attachments/assets/0fd88a71-e16e-4063-82ca-ccfcba33844e" />


## I/O
| Signal | Direction | Description |
|---|---|---|
| `clk` | input | System clock (100 MHz) |
| `rst_btnc` | input | System-wide reset - center button |
| `sw(3:0)` | input | Switches for period / frequency selection |
| `sw(6:5)` | input | Switches for square wave duty cycle selection |
| `btnu` | input | Button to select |
| `btnl` | input | Button to select |
| `btnr` | input | Button to select |
| `AUD_PWM` | output | Audio PWM output signal for the headphone jack |
| `oscilloscope` | output | Test PWM signal for oscilloscope connection |
| `AUD_SD` | output | Audio amplifier enable (hardwired to '1') |
| `an(7:0)` | output | 7-segment display anodes (digit selection) |
| `seg(6:0)` | output | 7-segment display segments (number rendering) |
| `dp` | output | Decimal point (off - '1') |

## Internal Modules

| Module Name | Purpose | Description |
|---|---|---|
| `clk_en` (Wave) | Timing Control | Generates a variable clock enable pulse (based on `sw(3:0)`) to set the audio frequency/period. |
| `debounce` | Signal Conditioning | Mechanical button bounce eliminated, single pulse needed. |
| `flip_flop` | State Memory | Synchronous register, stores the currently selected wave shape (Sine, Saw, Square) based on pressed button. |
| `counter` (8 bit) | Phase Accumulator | Counts from 0 to 255. Acts directly as the Sawtooth wave. |
| `sq_gen` | Wave Generator | 8-bit counter value is compared against the `sw(6:5)` threshold to generate a variable duty cycle for Square wave. |
| `sine_gen` | Wave Generator | ROM (Read-Only Memory) lookup table that converts the 8-bit counter phase into Sine wave amplitude values. |
| `pwm_mux` | Signal Routing | Multiplexer that selects which 8-bit waveform to route to the output based on the `flip_flop` state. |
| `pwm` | Audio Modulator | Converts the 8-bit digital wave amplitude into a high-frequency 1-bit PWM signal for the physical audio jack. |
| `clk_en_disp` | Timing Control | Generates a fixed clock to control the 7-segment display refresh rate. |
| `counter_1bit` | Display Toggle | Flips between 0 and 1 to continuously alternate the active digit on the 7-segment display. |
| `disp_mux` | Data Routing | Multiplexer that selects between Period data `sw(3:0)` and Duty Cycle data `sw(6:5)` to send to the display. |
| `bin2seg` | Display Decoder | 4-bit binary/hexadecimal data is converted into the correct segment patterns for the 7-segment display. |
| `an_sel` | Anode Decoder | Synchronizes with `disp_mux` to turn on the correct physical digit (anode) on the board at the right time. |

## Simulations


## sources:
[PWM modulation nexys manual](https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf)

[PWM controller](https://vhdlwhiz.com/pwm-controller/)

[High Freqency pwm waveform](https://media.neliti.com/media/publications/263541-fpga-based-high-frequency-pwm-waveform-g-1be58e06.pdf)
