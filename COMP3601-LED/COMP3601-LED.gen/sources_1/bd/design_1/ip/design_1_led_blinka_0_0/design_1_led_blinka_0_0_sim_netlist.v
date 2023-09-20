// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Wed Sep 20 13:13:54 2023
// Host        : AronLaptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top design_1_led_blinka_0_0 -prefix
//               design_1_led_blinka_0_0_ design_1_led_blinka_0_0_sim_netlist.v
// Design      : design_1_led_blinka_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_led_blinka_0_0,led_blinka,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "led_blinka,Vivado 2021.1" *) 
(* NotValidForBitStream *)
module design_1_led_blinka_0_0
   (clk_10MHZ,
    led_out);
  input clk_10MHZ;
  output led_out;

  wire clk_10MHZ;
  wire led_out;

  design_1_led_blinka_0_0_led_blinka inst
       (.clk_10MHZ(clk_10MHZ),
        .led_out(led_out));
endmodule

module design_1_led_blinka_0_0_led_blinka
   (led_out,
    clk_10MHZ);
  output led_out;
  input clk_10MHZ;

  wire clear;
  wire clk_10MHZ;
  wire \clk_counter[0]_i_3_n_0 ;
  wire \clk_counter[0]_i_4_n_0 ;
  wire \clk_counter[0]_i_5_n_0 ;
  wire \clk_counter[0]_i_6_n_0 ;
  wire [23:7]clk_counter_reg;
  wire \clk_counter_reg[0]_i_2_n_0 ;
  wire \clk_counter_reg[0]_i_2_n_1 ;
  wire \clk_counter_reg[0]_i_2_n_10 ;
  wire \clk_counter_reg[0]_i_2_n_11 ;
  wire \clk_counter_reg[0]_i_2_n_12 ;
  wire \clk_counter_reg[0]_i_2_n_13 ;
  wire \clk_counter_reg[0]_i_2_n_14 ;
  wire \clk_counter_reg[0]_i_2_n_15 ;
  wire \clk_counter_reg[0]_i_2_n_2 ;
  wire \clk_counter_reg[0]_i_2_n_3 ;
  wire \clk_counter_reg[0]_i_2_n_4 ;
  wire \clk_counter_reg[0]_i_2_n_5 ;
  wire \clk_counter_reg[0]_i_2_n_6 ;
  wire \clk_counter_reg[0]_i_2_n_7 ;
  wire \clk_counter_reg[0]_i_2_n_8 ;
  wire \clk_counter_reg[0]_i_2_n_9 ;
  wire \clk_counter_reg[16]_i_1_n_1 ;
  wire \clk_counter_reg[16]_i_1_n_10 ;
  wire \clk_counter_reg[16]_i_1_n_11 ;
  wire \clk_counter_reg[16]_i_1_n_12 ;
  wire \clk_counter_reg[16]_i_1_n_13 ;
  wire \clk_counter_reg[16]_i_1_n_14 ;
  wire \clk_counter_reg[16]_i_1_n_15 ;
  wire \clk_counter_reg[16]_i_1_n_2 ;
  wire \clk_counter_reg[16]_i_1_n_3 ;
  wire \clk_counter_reg[16]_i_1_n_4 ;
  wire \clk_counter_reg[16]_i_1_n_5 ;
  wire \clk_counter_reg[16]_i_1_n_6 ;
  wire \clk_counter_reg[16]_i_1_n_7 ;
  wire \clk_counter_reg[16]_i_1_n_8 ;
  wire \clk_counter_reg[16]_i_1_n_9 ;
  wire \clk_counter_reg[8]_i_1_n_0 ;
  wire \clk_counter_reg[8]_i_1_n_1 ;
  wire \clk_counter_reg[8]_i_1_n_10 ;
  wire \clk_counter_reg[8]_i_1_n_11 ;
  wire \clk_counter_reg[8]_i_1_n_12 ;
  wire \clk_counter_reg[8]_i_1_n_13 ;
  wire \clk_counter_reg[8]_i_1_n_14 ;
  wire \clk_counter_reg[8]_i_1_n_15 ;
  wire \clk_counter_reg[8]_i_1_n_2 ;
  wire \clk_counter_reg[8]_i_1_n_3 ;
  wire \clk_counter_reg[8]_i_1_n_4 ;
  wire \clk_counter_reg[8]_i_1_n_5 ;
  wire \clk_counter_reg[8]_i_1_n_6 ;
  wire \clk_counter_reg[8]_i_1_n_7 ;
  wire \clk_counter_reg[8]_i_1_n_8 ;
  wire \clk_counter_reg[8]_i_1_n_9 ;
  wire \clk_counter_reg_n_0_[0] ;
  wire \clk_counter_reg_n_0_[1] ;
  wire \clk_counter_reg_n_0_[2] ;
  wire \clk_counter_reg_n_0_[3] ;
  wire \clk_counter_reg_n_0_[4] ;
  wire \clk_counter_reg_n_0_[5] ;
  wire \clk_counter_reg_n_0_[6] ;
  wire led_on_i_1_n_0;
  wire led_out;
  wire [7:7]\NLW_clk_counter_reg[16]_i_1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hAAAAAAAAA8888888)) 
    \clk_counter[0]_i_1 
       (.I0(clk_counter_reg[23]),
        .I1(clk_counter_reg[22]),
        .I2(clk_counter_reg[20]),
        .I3(\clk_counter[0]_i_3_n_0 ),
        .I4(clk_counter_reg[19]),
        .I5(clk_counter_reg[21]),
        .O(clear));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEEEEEEA)) 
    \clk_counter[0]_i_3 
       (.I0(\clk_counter[0]_i_5_n_0 ),
        .I1(clk_counter_reg[15]),
        .I2(clk_counter_reg[14]),
        .I3(\clk_counter[0]_i_6_n_0 ),
        .I4(clk_counter_reg[13]),
        .I5(clk_counter_reg[18]),
        .O(\clk_counter[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_counter[0]_i_4 
       (.I0(\clk_counter_reg_n_0_[0] ),
        .O(\clk_counter[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \clk_counter[0]_i_5 
       (.I0(clk_counter_reg[16]),
        .I1(clk_counter_reg[17]),
        .O(\clk_counter[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA88800000)) 
    \clk_counter[0]_i_6 
       (.I0(clk_counter_reg[12]),
        .I1(clk_counter_reg[9]),
        .I2(clk_counter_reg[8]),
        .I3(clk_counter_reg[7]),
        .I4(clk_counter_reg[10]),
        .I5(clk_counter_reg[11]),
        .O(\clk_counter[0]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[0] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_15 ),
        .Q(\clk_counter_reg_n_0_[0] ),
        .R(clear));
  (* ADDER_THRESHOLD = "16" *) 
  CARRY8 \clk_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CI_TOP(1'b0),
        .CO({\clk_counter_reg[0]_i_2_n_0 ,\clk_counter_reg[0]_i_2_n_1 ,\clk_counter_reg[0]_i_2_n_2 ,\clk_counter_reg[0]_i_2_n_3 ,\clk_counter_reg[0]_i_2_n_4 ,\clk_counter_reg[0]_i_2_n_5 ,\clk_counter_reg[0]_i_2_n_6 ,\clk_counter_reg[0]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}),
        .O({\clk_counter_reg[0]_i_2_n_8 ,\clk_counter_reg[0]_i_2_n_9 ,\clk_counter_reg[0]_i_2_n_10 ,\clk_counter_reg[0]_i_2_n_11 ,\clk_counter_reg[0]_i_2_n_12 ,\clk_counter_reg[0]_i_2_n_13 ,\clk_counter_reg[0]_i_2_n_14 ,\clk_counter_reg[0]_i_2_n_15 }),
        .S({clk_counter_reg[7],\clk_counter_reg_n_0_[6] ,\clk_counter_reg_n_0_[5] ,\clk_counter_reg_n_0_[4] ,\clk_counter_reg_n_0_[3] ,\clk_counter_reg_n_0_[2] ,\clk_counter_reg_n_0_[1] ,\clk_counter[0]_i_4_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[10] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_13 ),
        .Q(clk_counter_reg[10]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[11] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_12 ),
        .Q(clk_counter_reg[11]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[12] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_11 ),
        .Q(clk_counter_reg[12]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[13] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_10 ),
        .Q(clk_counter_reg[13]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[14] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_9 ),
        .Q(clk_counter_reg[14]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[15] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_8 ),
        .Q(clk_counter_reg[15]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[16] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_15 ),
        .Q(clk_counter_reg[16]),
        .R(clear));
  (* ADDER_THRESHOLD = "16" *) 
  CARRY8 \clk_counter_reg[16]_i_1 
       (.CI(\clk_counter_reg[8]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_clk_counter_reg[16]_i_1_CO_UNCONNECTED [7],\clk_counter_reg[16]_i_1_n_1 ,\clk_counter_reg[16]_i_1_n_2 ,\clk_counter_reg[16]_i_1_n_3 ,\clk_counter_reg[16]_i_1_n_4 ,\clk_counter_reg[16]_i_1_n_5 ,\clk_counter_reg[16]_i_1_n_6 ,\clk_counter_reg[16]_i_1_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[16]_i_1_n_8 ,\clk_counter_reg[16]_i_1_n_9 ,\clk_counter_reg[16]_i_1_n_10 ,\clk_counter_reg[16]_i_1_n_11 ,\clk_counter_reg[16]_i_1_n_12 ,\clk_counter_reg[16]_i_1_n_13 ,\clk_counter_reg[16]_i_1_n_14 ,\clk_counter_reg[16]_i_1_n_15 }),
        .S(clk_counter_reg[23:16]));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[17] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_14 ),
        .Q(clk_counter_reg[17]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[18] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_13 ),
        .Q(clk_counter_reg[18]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[19] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_12 ),
        .Q(clk_counter_reg[19]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[1] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_14 ),
        .Q(\clk_counter_reg_n_0_[1] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[20] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_11 ),
        .Q(clk_counter_reg[20]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[21] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_10 ),
        .Q(clk_counter_reg[21]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[22] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_9 ),
        .Q(clk_counter_reg[22]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[23] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[16]_i_1_n_8 ),
        .Q(clk_counter_reg[23]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[2] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_13 ),
        .Q(\clk_counter_reg_n_0_[2] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[3] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_12 ),
        .Q(\clk_counter_reg_n_0_[3] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[4] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_11 ),
        .Q(\clk_counter_reg_n_0_[4] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[5] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_10 ),
        .Q(\clk_counter_reg_n_0_[5] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[6] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_9 ),
        .Q(\clk_counter_reg_n_0_[6] ),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[7] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[0]_i_2_n_8 ),
        .Q(clk_counter_reg[7]),
        .R(clear));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[8] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_15 ),
        .Q(clk_counter_reg[8]),
        .R(clear));
  (* ADDER_THRESHOLD = "16" *) 
  CARRY8 \clk_counter_reg[8]_i_1 
       (.CI(\clk_counter_reg[0]_i_2_n_0 ),
        .CI_TOP(1'b0),
        .CO({\clk_counter_reg[8]_i_1_n_0 ,\clk_counter_reg[8]_i_1_n_1 ,\clk_counter_reg[8]_i_1_n_2 ,\clk_counter_reg[8]_i_1_n_3 ,\clk_counter_reg[8]_i_1_n_4 ,\clk_counter_reg[8]_i_1_n_5 ,\clk_counter_reg[8]_i_1_n_6 ,\clk_counter_reg[8]_i_1_n_7 }),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({\clk_counter_reg[8]_i_1_n_8 ,\clk_counter_reg[8]_i_1_n_9 ,\clk_counter_reg[8]_i_1_n_10 ,\clk_counter_reg[8]_i_1_n_11 ,\clk_counter_reg[8]_i_1_n_12 ,\clk_counter_reg[8]_i_1_n_13 ,\clk_counter_reg[8]_i_1_n_14 ,\clk_counter_reg[8]_i_1_n_15 }),
        .S(clk_counter_reg[15:8]));
  FDRE #(
    .INIT(1'b0)) 
    \clk_counter_reg[9] 
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(\clk_counter_reg[8]_i_1_n_14 ),
        .Q(clk_counter_reg[9]),
        .R(clear));
  LUT2 #(
    .INIT(4'h6)) 
    led_on_i_1
       (.I0(clear),
        .I1(led_out),
        .O(led_on_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    led_on_reg
       (.C(clk_10MHZ),
        .CE(1'b1),
        .D(led_on_i_1_n_0),
        .Q(led_out),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
