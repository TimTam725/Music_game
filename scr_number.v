`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/06 17:29:57
// Design Name: 
// Module Name: scr_number
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


module scr_number(
    input               clk,
    input               rst,
    input               bnt1,
    input               bnt2,
    input               bnt3,
    input               bnt4,
    input               fin,
    output reg [1:0]    scrnum
    );
    
    always @ (posedge clk) begin
        if (rst)
            scrnum <= 0;
        else begin
//            scrnum <= 1;
            if ((scrnum == 0) && (bnt1 || bnt2 || bnt3 || bnt4))
                scrnum <= 1;
            if (fin)
                scrnum <= 2;
        end
    end
    
endmodule
