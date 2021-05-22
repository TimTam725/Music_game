`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/18 16:05:56
// Design Name: 
// Module Name: debounce
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


module debounce (
    input       CLK,
    input       RST,
    input       BTNIN,
    output  reg BTNOUT
);

/* 100MHz?????40Hz???? */
reg [21:0] cnt22;

wire en40hz = (cnt22==22'd2500000-1);

always @( posedge CLK ) begin
    if ( RST )
        cnt22 <= 22'd0;
    else if ( en40hz )
        cnt22 <= 22'd0;
    else
        cnt22 <= cnt22 + 22'h1;
end

/* ?X?C?b?`?????FF2????? */
reg ff1, ff2;

always @( posedge CLK ) begin
    if ( RST ) begin
        ff1 <= 1'b0;
        ff2 <= 1'b0;
    end
    else if ( en40hz ) begin
        ff2 <= ff1;
        ff1 <= BTNIN;
    end
end

/* ?????ƒI???o???AFF???? */
wire temp = ff1 & ~ff2 & en40hz;

always @( posedge CLK ) begin
    if ( RST )
        BTNOUT <= 1'b0;
    else
        BTNOUT <= temp;
end

endmodule
