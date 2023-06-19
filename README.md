# kurklu_lab3

## Introduction
As part of our joint design course in GE5A at Polytech Clermont, we have been applying the theoretical knowledge gained during practical sessions. In this project, conducted on a Terasic DE10-Lite board with an Altera MAX 10 FPGA, our objective is to interface an ADXL345 accelerometer via I2C, configure it correctly, and display the different axes on 7-segment displays using a timer and interrupts.

## Architecture
The architecture I designed using Paint includes the following components:

![image](https://user-images.githubusercontent.com/24780090/213120076-4c1e3f18-3208-48f5-9a04-559f55001bc2.png)

- Clock
- RAM
- NIOS-2
- JTAG

Additionally, I added PIOs for managing the I/O:
- 7-bit PIO for segment 0
- 7-bit PIO for segment 1
- 7-bit PIO for segment 2
- 7-bit PIO for segment 3
- 7-bit PIO for segment 4
- 7-bit PIO for segment 5
- Timer
- 1-bit PIO for the button

## Progress

### I2C Initialization
To initialize communication with the I2C, I used the provided files from the opencores_i2c IP. I first called the `I2C_init()` function and then used `I2C_start()` on register 0x1D to verify its functionality. Subsequently, I implemented the `ecriture_i2c()` and `lecture_i2c()` functions, leveraging the provided IP files for reading and writing operations. I performed readings on the ACT_INACT_CTL(0X27), POWER_CTL(0x2D), and DATA_FORMAT(0x31) registers to ensure proper initialization. Finally, I wrote 0x8 to POWER_CTL to enable measurements and 0x7 to DATA_FORMAT to set the full resolution to ±16g.

### UART Display
For displaying data on the UART, I read the X0(0x32), X1(0x33), Y0(0x34), Y1(0x35), Z0(0x36), and Z1(0x37) registers. Then, I performed a shift and bitwise OR operation between the least significant bit (LSB) and most significant bit (MSB) to obtain the final measurements. Finally, I displayed the obtained values on the UART.

[UART Display](https://user-images.githubusercontent.com/24780090/213125986-3d57668c-5c14-4567-ad5c-54ee17405554.mov)

### Calibration
To calibrate the accelerometer, I initially set the OFSX(0x1E), OFSY(0x1F), and OFSZ(0x20) registers to 0, effectively removing any offset values. Next, I read the measurements on the UART. For example, for Z, I obtained the value 7c0 (in base 10: 1984, multiplied by 3.9: 7737 m/s²). The desired value for Z, when the board is flat, is 9800 m/s². Therefore, I gradually added offset to the OFSZ register to achieve the desired result. I followed the same process for X and Y to obtain 0 m/s² for both registers.

[Calibration](https://user-images.githubusercontent.com/24780090/213129209-90b0661f-3827-411d-8fb3-0ec773c4ee1a.mov)

### 7-Segment Display
#### Only Z
For the 7-segment display, I utilized the "bin_to_7seg" VHDL code and functions from lab2. However, I modified the software code to handle the display on all six 7-segment displays and to account for negative values. Initially, I focused on displaying only the Z axis.

[7-Segment Display](https://user-images.githubusercontent.com/24780090/213132988-1f8f82fc-3f36-4ac7-ba70-589a0c73d820.jpg)

#### XYZ with Button and Interrupt
To enable switching between X, Y, and Z values, I implemented an interrupt using a button, similar to lab1.

[XYZ with Button and Interrupt](https://user-images.githubusercontent.com/24780090/213138352-a556ad66-c6c8-473f-b8b9-29fded84c194.mov)

### Timer Usage
To update the display on the 7-segment displays every second, I applied the same configuration as in lab2.

[Timer Usage](https://user-images.githubusercontent.com/24780090/213139162-befcd064-8bdd-466c-8ed8-8d63e38a25b6.mov)

Here is the final application :

[Final Application](https://user-images.githubusercontent.com/24780090/213139660-b6834aa1-978d-40aa-8112-e57b28ad1e7c.mov)

## Conclusion
I successfully implemented the required functionalities for lab3. Although this assignment appeared more challenging in terms of complexity, once I understood the communication with the ADXL accelerometer, the remaining tasks were similar to previous labs. The only aspect where I encountered difficulty was the calibration process. While I believe I followed the correct method, I did not obtain the expected values on the different axes. For instance, when the device was placed flat on the table, I expected x=0, y=0, and z=-9700 m/s². However, while x and y were 0, the Z value was -7300 m/s². I am unsure whether this discrepancy is due to my calibration or the accelerometer itself.
