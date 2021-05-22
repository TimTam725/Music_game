`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/28 16:22:31
// Design Name: 
// Module Name: audio_top
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


module audio_top(
    input         clk100,
    input         rst,
    output        AC_MCLK,
    inout         AC_SDA,
    output        AC_ADR0,
    output        AC_ADR1,
    output        AC_SCK,
//    input         AC_GPIO1,
    input         AC_GPIO2,
    input         AC_GPIO3,
    output        AC_GPIO0,
    input [23:0]  audio_l_in,
    input [23:0]  audio_r_in,
    input         hphone_valid,
    output reg    isnew_sample
    );
    
    wire    clk;//48MHz
//    BUFG iBGUF(.I(clk100), O(CLK10));
    
    clocking    clocking(clk100, clk);
    clk24       clk24(clk, AC_MCLK);
    reg [23:0]  hphone_l_freeze_100;
    reg [23:0]  hphone_r_freeze_100;
    
    wire    i2c_sda_i, i2c_scl, i2c_sda_o, i2c_sda_t;
    wire    i2s_bclk = AC_GPIO2;
    wire    i2s_lr   = AC_GPIO3;
    wire    i2s_d_out;
    assign  AC_GPIO0 = i2s_d_out;
    
    i3c2 i3c2(clk, rst, i2c_sda_i, i2c_scl, i2c_sda_o, i2c_sda_t);
    i2s_data_interface i2s_data_interface(clk, rst, hphone_l_freeze_100, hphone_r_freeze_100, new_sample, i2s_bclk, i2s_lr, i2s_d_out); //new_sample no use
    
    assign  AC_SCK      = i2c_scl;
    assign  AC_SDA      = (i2c_sda_t == 1'b0)? i2c_sda_o : 1'bz;
    assign  i2c_sda_i   = AC_SDA;
    assign  AC_ADR0     = 1'b1;
    assign  AC_ADR1     = 1'b1;
    
    reg     sample_clk_48k_d1_48, sample_clk_48k_d2_48, sample_clk_48k_d3_48;
    always @ (posedge clk) begin
        sample_clk_48k_d1_48 <= AC_GPIO3;
        sample_clk_48k_d2_48 <= sample_clk_48k_d1_48;
        sample_clk_48k_d3_48 <= sample_clk_48k_d2_48;
    end
    
    reg     sample_clk_48k_d4_100, sample_clk_48k_d5_100, sample_clk_48k_d6_100;
    reg     new_sample_100;
    always @ (posedge clk100) begin
        sample_clk_48k_d4_100 <= sample_clk_48k_d3_48;
        sample_clk_48k_d5_100 <= sample_clk_48k_d4_100;
        sample_clk_48k_d6_100 <= sample_clk_48k_d5_100;
        
        if ((sample_clk_48k_d5_100 == 1'b1) && (sample_clk_48k_d6_100 == 1'b0))
            new_sample_100 <= 1'b1;
        else
            new_sample_100 <= 1'b0;
        
        isnew_sample <= new_sample_100;
    end
    
    always @ (posedge clk100) begin
        if (hphone_valid) begin
            hphone_l_freeze_100 <= audio_l_in;
            hphone_r_freeze_100 <= audio_r_in;
        end
    end
    
    
    
//    (* mark_debug = "ture"*) wire    lrclk   = AC_GPIO3;
//    (* mark_debug = "ture"*) wire    bclk    = AC_GPIO2;
//    (* mark_debug = "ture"*) wire    misoin  = AC_GPIO1;
//    (* mark_debug = "ture"*) wire    misoout = AC_GPIO0;
    
//    reg    lrclk2, bclk2, misoin2, misoout2;
    
//    always @(posedge clk100) begin
//        if (rst == 1) begin
//            lrclk2 <= 0;
//            bclk2  <= 0;
//            misoin2<= 0;
//            misoout2<=0;
//        end else begin
//            lrclk2 <= lrclk;
//            bclk2  <= bclk;
//            misoin2<= misoin;
//            misoout2<=misoout;
//        end
//    end
    
endmodule
