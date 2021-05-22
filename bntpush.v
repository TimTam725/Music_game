`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/18 16:22:32
// Design Name: 
// Module Name: bntpush
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


module bntpush(
    input CLK,
    input RST,
    input BNTOUT,
    output push
    );
    
    reg [23:0] cnt;
    assign push = (BNTOUT || cnt > 0);
    always @(posedge CLK) begin
        if(RST)
            cnt <= 0;
        else if(push) begin
            if(cnt == 24'd10000000 - 1)
                cnt <= 0;
            else
                cnt <= cnt + 1;
        end else
            cnt <= 0;
    end
    
endmodule
