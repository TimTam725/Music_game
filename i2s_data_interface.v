`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/28 17:53:49
// Design Name: 
// Module Name: i2s_data_interface
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


module i2s_data_interface(
    input          clk,
    input          rst,
    input [23:0]   audio_l_in,
    input [23:0]   audio_r_in,
    output reg     new_sample, // no use
    input          i2s_bclk,
    input          i2s_lr,
    output reg     i2s_d_out
    );
    
    reg [5:0]   bit_counter;
    reg [9:0]   bclk_delay;
    reg [63:0]  sr_out;
    reg         i2s_lr_last;
    
    always @(posedge clk) begin
//        if (rst) begin
//            new_sample      <= 1'b0;
//            i2s_d_out       <= 1'b0;
//            bit_counter     <= 6'd0;
//            bclk_delay      <= 10'd0;
//            i2s_lr_last     <= 1'b0;
//            sr_out          <= 64'd0;
//        end else begin
            new_sample  <= 1'b0;
            
            if (bclk_delay[1:0] == 2'b10) begin
                i2s_d_out   <= sr_out[63:63];
                
                if ((i2s_lr == 1'b1) && (i2s_lr_last == 1'b0)) begin
                    sr_out      <= {audio_l_in[23:0], 8'd0, audio_r_in[23:0], 8'd0};
                    new_sample  <= 1'b1;
                end else
                    sr_out  <= {sr_out[62:0], 1'b0};
                
                i2s_lr_last <= i2s_lr;
            end
            
            bclk_delay      <= {i2s_bclk, bclk_delay[9:1]};
//            i2s_d_in_lasy   <= i2s_d_in;
//        end
    end
    
endmodule
