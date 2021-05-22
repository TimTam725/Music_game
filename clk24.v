`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/28 16:10:19
// Design Name: 
// Module Name: clk24
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


module clk24(
    input       clk,
    output reg  clk24
    );
    
    initial begin
        clk24 <= 1'b0;
    end
    
    always @(posedge clk) begin
        clk24 <= ~clk24;
    end
    
endmodule
