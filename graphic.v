`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 13:06:33
// Design Name: 
// Module Name: graphic
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


module graphic(
    input                PCK,
    input                RST,
    input                disp_enable,
    input       [9:0]    x,
    input       [9:0]    y,
    input       [1:0]    scrnum,
    input                changesrc,
    input       [18:0]   bramadd,
    input                push1,
    input                push2,
    input                push3,
    input                push4,
    input      [11:0]    adds1,
    input      [11:0]    adds2,
    input      [11:0]    adds3,
    input      [11:0]    addc1,
    input      [11:0]    addc2,
    input      [11:0]    addc3,
    input      [7:0]     hpboder,
    input      [9:0]     raddy,
    input      [9:0]     gaddy,
    input      [9:0]     baddx,
    input      [9:0]     yaddx,
    input                rgo,
    input                ggo,
    input                bgo,
    input                ygo,
    input      [9:0]     r2addy,
    input      [9:0]     g2addy,
    input      [9:0]     b2addx,
    input      [9:0]     y2addx,
    input                r2go,
    input                g2go,
    input                b2go,
    input                y2go,
    output reg  [3:0]    VGA_B,
    output reg  [3:0]    VGA_G,
    output reg  [3:0]    VGA_R
    );
   
   `include "rbg_param.vh"
   
   //screen 0
   wire [2:0]   bramout0;
   start ROM0 (.addra(bramadd), .douta(bramout0), .clka(PCK));
   wire iswhite0  = (bramout0 == WHITE);
   wire isblack0  = (bramout0 == BLACK);
   wire isred0    = (bramout0 == RED);
   wire isblue0   = (bramout0 == BLUE);
   wire isgreen0  = (bramout0 == GREEN);
   wire isyellow0 = (bramout0 == YELLOW);
   wire red0      = ((scrnum == 0) && (iswhite0 || isred0 || isyellow0));
   wire green0    = ((scrnum == 0) && (iswhite0 || isgreen0 || isyellow0));
   wire blue0     = ((scrnum == 0) && (iswhite0 || isblue0));
   
   
   //screen 1
    wire [2:0]   bramout;
    reg [8:0]   cnts1, cnts2, cnts3, cntc1, cntc2, cntc3;
//    wire [11:0] s1add, s2add, s3add, c1add, c2add, c3add;
    wire s1out, s2out, s3out, c1out, c2out, c3out;
    test15 ROM (.addra(bramadd), .douta(bramout), .clka(PCK));
    //s1disp
    wire s1disp         = ((350 <= x) && (y <= 64) && (bramout == RED));
    wire [11:0] s1add   = (adds1 + {3'b0, cnts1});      
    number score1(.addra(s1add), .douta(s1out), .clka(PCK));
    //s2disp
    wire s2disp          = ((350 <= x) && (y <= 64) && (bramout == BLUE));
    wire [11:0] s2add    = (adds2 + {3'b0, cnts2});      
    number1 score2(.addra(s2add), .douta(s2out), .clka(PCK));
    //s3disp
    wire s3disp          = ((350 <= x) && (y <= 64) && (bramout == GREEN));
    wire [11:0] s3add    = (adds3 + {3'b0, cnts3});      
    number2 score3(.addra(s3add), .douta(s3out), .clka(PCK));
    //c1disp
    wire c1disp          = ((350 <= x) && (64 < y) && (y <= 108) && (bramout == RED));
    wire [11:0] c1add    = (addc1 + {3'b0, cntc1});      
    number3 combo1(.addra(c1add), .douta(c1out), .clka(PCK));
    //c2disp
    wire c2disp          = ((350 <= x) && (64 < y) && (y <= 108) && (bramout == BLUE));
    wire [11:0] c2add    = (addc2 + {3'b0, cntc2});      
    number4 combo2(.addra(c2add), .douta(c2out), .clka(PCK));
    //c3disp
    wire c3disp         = ((350 <= x) && (64 < y) && (y <= 108) && (bramout == GREEN));
    wire [11:0] c3add    = (addc3 + {3'b0, cntc3});      
    number5 combo3(.addra(c3add), .douta(c3out), .clka(PCK));
    
    // noots red
    wire    nr2 = ((32 <= raddy) && ((raddy - 32) <= y) && (y <= raddy));
    wire    nr = ((rgo) && (301 <= x) && (x <= 340) && (((raddy <= 32) && (y <= raddy)) || nr2));
    // noots green
    wire    ng = ((ggo) && (301 <= x) && (x <= 340) && (gaddy <= y) && (y <= (gaddy + 32)));
    // noots blue
    wire    nb = ((bgo) && (221 <= y) && (y <= 260) && (baddx <= x) && (x <= (baddx + 32)));
    // noots yellow
    wire    ny2 = ((33 <= yaddx) && ((yaddx - 33) <= x) && (x <= yaddx));
    wire    ny = ((ygo) && (221 <= y) && (y <= 260) && (((yaddx <= 32) && (x <= yaddx)) || ny2));
    
    // noots red2
    wire    nr22 = ((32 <= r2addy) && ((r2addy - 32) <= y) && (y <= r2addy));
    wire    nrk = ((r2go) && (301 <= x) && (x <= 340) && (((r2addy <= 32) && (y <= r2addy)) || nr22));
    // noots green2
    wire    ng2 = ((g2go) && (301 <= x) && (x <= 340) && (g2addy <= y) && (y <= (g2addy + 32)));
    // noots blue2
    wire    nb2 = ((b2go) && (221 <= y) && (y <= 260) && (b2addx <= x) && (x <= (b2addx + 32)));
    // noots yellow2
    wire    ny22 = ((33 <= y2addx) && ((y2addx - 33) <= x) && (x <= y2addx));
    wire    nyk = ((y2go) && (221 <= y) && (y <= 260) && (((y2addx <= 32) && (x <= y2addx)) || ny22));
    
    // judge debug
//    wire judger = (y == 208);
//    wire judgeg = (y == 271);
//    wire judgeb = (x == 379);
//    wire judgey = (x == 260);
//    wire judger = (y == 190 || y == 214 || y == 198 || y == 206 || y == 194 || y == 210);
//    wire judgeg = (y == 274 || y == 282 || y == 266 || y == 290 || y == 270 || y == 286);
//    wire judgeb = (x == 360 || x == 384 || x == 368 || x == 376 || x == 364 || x == 380);
//    wire judgey = (x == 257 || x == 281 || x == 265 || x == 273 || x == 261 || x == 277);
    
    wire iswhite  = (((bramout == WHITE) && (~nr && ~ng && ~nb && ~ny && ~nrk && ~ng2 && ~nb2 && ~nyk)) || (s1disp && ~s1out) || (s2disp && ~s2out) || (s3disp && ~s3out) || (c1disp && ~c1out) || (c2disp && ~c2out) || (c3disp && ~c3out) || ((bramout == PINK) && (hpboder < x)));
//    wire iswhite  = ((~judger && ~judgeg && ~judgeb && ~judgey) && (((bramout == WHITE) && (~nr && ~ng && ~nb && ~ny && ~nrk && ~ng2 && ~nb2 && ~nyk)) || (s1disp && ~s1out) || (s2disp && ~s2out) || (s3disp && ~s3out) || (c1disp && ~c1out) || (c2disp && ~c2out) || (c3disp && ~c3out) || ((bramout == PINK) && (hpboder < x))));
//    wire isblack  = ((bramout == BLACK) || (s1disp && s1out) || (s2disp && s2out) || (s3disp && s3out) || (c1disp && c1out) || (c2disp && c2out) || (c3disp && c3out));
    wire isred    = (((bramout == RED) && (120 < y)) || nr || ny || nrk || nyk);
//    wire isred    = (((bramout == RED) && (120 < y)) || nr || ny || nrk || nyk || judger || judgey);
    wire isblue   = (((bramout == BLUE) && (120 < y)) || nb || nb2);
//    wire isblue   = (((bramout == BLUE) && (120 < y)) || nb || nb2 || judgeb);
    wire isgreen  = (((bramout == GREEN) && (120 < y)) || ng || ny || ng2 || nyk);
//    wire isgreen  = (((bramout == GREEN) && (120 < y)) || ng || ny || ng2 || nyk || judgeg || judgey);
    wire isyellow = (bramout == YELLOW);
    wire islightb = (bramout == LIGHTB);
    wire ispink   = ((bramout == PINK) && (x <= hpboder));
    wire top      = (islightb && (push1 && (y < 180)));
    wire right    = (islightb && (push2 && (x < 240)));
    wire left     = (islightb && (push3 && (400 < x)));
    wire down     = (islightb && (push4 && (300 < y)));
    wire red      = ((scrnum == 1) && (iswhite || isred || isyellow || ispink || top || right || left || down));
    wire green    = ((scrnum == 1) && (iswhite || isgreen || isyellow || top || right || left || down));
    wire blue     = ((scrnum == 1) && (iswhite || isblue || ispink || top || right || left || down));
    
    //screen2
   wire [2:0]   bramout2;
   game_over ROM2 (.addra(bramadd), .douta(bramout2), .clka(PCK));
   wire red2      = ((scrnum == 2) && (bramout2));
    
    
    
    // graphic
    wire R = (red0 || red || red2);
    wire G = (green0 || green);
    wire B = (blue0 || blue);
   
 
    always @ ( posedge PCK ) begin
        if ( RST )
            {VGA_R, VGA_G, VGA_B} <= 12'h000;
        else if(disp_enable) begin
//            VGA_R <= 4'b1111;
//            VGA_G <= 4'b1111;
//            VGA_B <= 4'b1111;
            VGA_R <= (R)   ? 4'b1111:0;
            VGA_G <= (G)   ? 4'b1111:0;
            VGA_B <= (B)   ? 4'b1111:0;
        end else
            {VGA_R, VGA_G, VGA_B} <= 12'h000;
    end
    
    always @ (posedge PCK) begin
        if(RST)
            cnts1 <= 0;
        else if(s1disp) begin
            if(cnts1 == 9'd339)
                cnts1 <= 0;
            else
                cnts1 <= cnts1 + 1;
        end
    end
    always @ (posedge PCK) begin
        if(RST)
            cnts2 <= 0;
        else if(s2disp) begin
            if(cnts2 == 9'd339)
                cnts2 <= 0;
            else
                cnts2 <= cnts2 + 1;
        end
    end
    always @ (posedge PCK) begin
        if(RST)
            cnts3 <= 0;
        else if(s3disp) begin
            if(cnts3 == 9'd339)
                cnts3 <= 0;
            else
                cnts3 <= cnts3 + 1;
        end
    end
    always @ (posedge PCK) begin
        if(RST)
            cntc1 <= 0;
        else if(c1disp) begin
            if(cntc1 == 9'd339)
                cntc1 <= 0;
            else
                cntc1 <= cntc1 + 1;
        end
    end
    always @ (posedge PCK) begin
        if(RST)
            cntc2 <= 0;
        else if(c2disp) begin
            if(cntc2 == 9'd339)
                cntc2 <= 0;
            else
                cntc2 <= cntc2 + 1;
        end
    end
    always @ (posedge PCK) begin
        if(RST)
            cntc3 <= 0;
        else if(c3disp) begin
            if(cntc3 == 9'd339)
                cntc3 <= 0;
            else
                cntc3 <= cntc3 + 1;
        end
    end
    
    
endmodule
