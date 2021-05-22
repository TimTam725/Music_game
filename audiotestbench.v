`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/28 18:27:32
// Design Name: 
// Module Name: audiotestbench
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


module audiotestbench(
    input         clk100,
    input         rst,
    output        AC_MCLK,
    inout         AC_SDA,
    output        AC_ADR0,
    output        AC_ADR1,
    output        AC_SCK,
    input         AC_GPIO2,
    input         AC_GPIO3,
    input [1:0]   scrnum,
    output        AC_GPIO0
    );
    //input AC_GPIO2, AC_GPIO3
    //output    AC_MCLK, AC_ADR0, AC_ADR1, AC_SCK, AC_GPIO0
    //inout     AC_SDA
    
    reg [23:0] audio_l_in, audio_r_in;
    reg        hphone_valid;
    wire       new_sample, CLK100Mhz, clk25;
    wire [6:0]  scale;
    BUFG BGUF_inst(.I(clk100), .O(CLK100Mhz));
    audio_top audio_top(CLK100Mhz, rst, AC_MCLK, AC_SDA, AC_ADR0, AC_ADR1, AC_SCK, AC_GPIO2, AC_GPIO3, AC_GPIO0, audio_l_in, audio_r_in, hphone_valid, new_sample);
    mario_bgm2 mario_bgm(CLK100Mhz, rst, scrnum, scale);
    
    reg [6:0]   counter;

    wire    true = (scale == counter)? 1'b1 : 1'b0;
    

    
    
    always @(posedge CLK100Mhz) begin
        if (rst || (scrnum == 0) || (scrnum == 2)) begin
            counter       <= 7'd0;
            hphone_valid  <= 1'b0;
            audio_l_in    <= 24'd0;
            audio_r_in    <= 24'd0;
        end else begin
            hphone_valid  <= 1'b0;
            audio_l_in    <= 24'd0;
            audio_r_in    <= 24'd0;
            
            if (new_sample) begin
                counter <= counter + 1;
                if (true)
                    counter <= 7'd0;
                hphone_valid <= 1'b1;
                audio_l_in   <= {counter[6:0], 17'b00000000000000000};
                audio_r_in   <= {counter[6:0], 17'b00000000000000000};
            end 
        end
    end
    
endmodule
