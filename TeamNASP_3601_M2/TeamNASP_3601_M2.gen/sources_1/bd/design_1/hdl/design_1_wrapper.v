//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
//Date        : Wed Oct  4 11:14:23 2023
//Host        : AronLaptop running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (pmod_i2s_bclk,
    pmod_i2s_dout,
    pmod_i2s_lrclk);
  output pmod_i2s_bclk;
  input pmod_i2s_dout;
  output pmod_i2s_lrclk;

  wire pmod_i2s_bclk;
  wire pmod_i2s_dout;
  wire pmod_i2s_lrclk;

  design_1 design_1_i
       (.pmod_i2s_bclk(pmod_i2s_bclk),
        .pmod_i2s_dout(pmod_i2s_dout),
        .pmod_i2s_lrclk(pmod_i2s_lrclk));
endmodule
