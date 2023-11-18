# COMP3601-Project  
COMP3601 FPGA Project

**Members**
- Priyansh Mittal (z5501423)
- Aron Keness (z5371654)
- Sagar Bhatnagar (z5364817)
- Nishant Patil (z5270429)

**Project Overview**

The following project intended to use a Discrete Fast Fourier Transform (FFT) along with a few bank filters (MFCC, Notch filter) to reduce noise in order to isolate necessary frequency magnitudes and allow for Soft authentication of different user profiles, allowing us to determine who a speaker is. 

The project intends to be extended towards including an onboard multilayer perceptron in order to implement a wake word - recognising distinct and potentially minute differences frequency responses to recognise a specific word spoken, essentially soft speech to text.

An ASM can be seen in the drawio diagram. We allow users to create new profiles, add audio recordings to enhance accuracy, and then test via comparing matched samples with their own/other user profiles. The profile with the highest volume of matches frequencies is the users profile.

Testing shows that only a difference of a few hundred matched are necessary to authenticate. Testing was primarily done with other male voices, and varying pitches to mimic higher frequency voices. We had consistent results, however noise played a large factor in the majority of matched cases. 

**How to get the project running**

Apart from the standard Kira kv260 board and the VHDL avaliable in the director TeamNASP_COMP3601_M2, no other specifications are required. A quiet room with minimal noise is ideal for training

**Xilinx Version**: Vitis Vivado 2021.1
