`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 14:20:21
// Design Name: 
// Module Name: clkdomain
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


module clkdomain(
    input       clk,
    input       changescr,
    output reg  change
    );
    
    reg     pck_ff1, pck_ff2, pck_ff3, new_change;
//    wire    go = ((pck_ff2 == 1'b0) && (pck_ff3 == 1'b1)) ? 1'b1 : 1'b0;
    
    always @(posedge clk) begin
        pck_ff1 <= changescr;
        pck_ff2 <= pck_ff1;
        pck_ff3 <= pck_ff2;
        if ((pck_ff2 == 1'b1) && (pck_ff3 == 1'b0))
            new_change <= 1'b1;
        else
            new_change <= 1'b0;
        change <= new_change;
    end
    
endmodule
