`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 19:48:21
// Design Name: 
// Module Name: pckgen
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

module pckgen (
    input   SYSCLK,
    output  reg PCK
);

    reg     cnt;
    initial begin
        PCK <= 0;
        cnt <= 1'b1;
    end
    
    always @(posedge SYSCLK) begin
        if(cnt == 1'b1) begin
            cnt <= 0;
            PCK <= ~PCK;
        end else
            cnt <= cnt + 1;
    end

endmodule
