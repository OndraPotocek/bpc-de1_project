# Waveform Generator
Waveform Generator is project for BPC_DE1 subject at Brno University of Technology - faculty of electrical engeneering and comunication.

## Features
- PWM generatrion - setting period and duty cycle with buttnost and switches on FPGA board NEXYS A7 50T.
- view output signal on an LED (oscilloscope) and/or headphone jack
- view period/immediate change of amplitude on a 7 segment diplay (soon to be added into the schematic)


## sources:
    - PWM modulation nexys manual: https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf

    - https://media.neliti.com/media/publications/263541-fpga-based-high-frequency-pwm-waveform-g-1be58e06.pdf

    - https://vhdlwhiz.com/pwm-controller/


    - 7 segment display 2x
        - one to display frequency - 0-f
        - second one to display duty cycle



### buttons
- BTNC = reset
- BTNL = sine wave
- BTNR = square wave
- BTNU = sawtooth

- switches = to change period, 0-15, SW0-SW4
    - SW5 nad SW6 to change duty cycle


s_max = clock frequency / (256 * wanted frequency)
      = 100_000_000 / (256 * 200) ... 400 ...


<img width="1660" height="929" alt="schematic" src="https://github.com/user-attachments/assets/99e19a2c-a943-4e44-9e6e-fc4e84e40d58" />

