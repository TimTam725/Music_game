`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/05/15 18:23:15
// Design Name:
// Module Name: vga_param
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

/* VGA(640�~480)�p�����[�^ */
localparam HPERIOD = 10'd800; //800
localparam HFRONT  = 10'd16;
localparam HWIDTH  = 10'd96;
localparam HBACK   = 10'd48;


localparam VPERIOD = 10'd525; //525
localparam VFRONT  = 10'd10;
localparam VWIDTH  = 10'd2;
localparam VBACK   = 10'd33;
