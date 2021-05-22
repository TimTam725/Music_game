`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/17 13:22:24
// Design Name: 
// Module Name: romtest
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


module romtest( CLK, RST, bramout, R, B, G );
    input CLK;
    input RST;
    output [2:0] bramout;
    output reg [3:0] R;
    output reg [3:0] B;
    output reg [3:0] G;
    
    localparam WHITE   = 3'b000;
    localparam BLACK   = 3'b001;
    localparam RED     = 3'b010;
    localparam BLUE    = 3'b011;
    localparam GREEN   = 3'b100;
    localparam YELLOW  = 3'b101;
    
    reg [18:0] cnt;
    wire iswhite  = (bramout == WHITE);
    wire isblack  = (bramout == BLACK);
    wire isred    = (bramout == RED);
    wire isblue   = (bramout == BLUE);
    wire isgreen  = (bramout == GREEN);
    wire isyellow = (bramout == YELLOW);
    wire red      = (iswhite || isred || isyellow);
    wire green    = (iswhite || isgreen || isyellow);
    wire blue     = (iswhite || isblue);
    
    test4 test(.addra(cnt), .douta(bramout), .clka(CLK));
    
    always @(posedge CLK) begin
        if(RST)
            cnt <= 19'd145000;
        else begin
            if(cnt == 19'd307199)
                cnt <= 19'b0;
            else
                cnt <= cnt + 1;
        end
    end
    always @(posedge CLK) begin
        if(RST) begin
            R <= 4'b0;
            B <= 4'b0;
            G <= 4'b0;
        end else begin
            R <= (red)   ? 4'b1111:0;
            G <= (green) ? 4'b1111:0;
            B <= (blue)  ? 4'b1111:0;
        end
    end
    
    
endmodule
