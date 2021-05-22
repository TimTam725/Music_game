`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/20 17:12:58
// Design Name: 
// Module Name: game
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


module game(
    input               CLK,
    input               RST,
    input               BNTOUT1,
    input               BNTOUT2,
    input               BNTOUT3,
    input               BNTOUT4,
    input       [9:0]   raddy,
    input       [9:0]   gaddy,
    input       [9:0]   baddx,
    input       [9:0]   yaddx,
    input               rgo,
    input               ggo,
    input               bgo,
    input               ygo,
    output  reg         rmr,
    output  reg         rmg,
    output  reg         rmb,
    output  reg         rmy,
    input       [9:0]   r2addy,
    input       [9:0]   g2addy,
    input       [9:0]   b2addx,
    input       [9:0]   y2addx,
    input               r2go,
    input               g2go,
    input               b2go,
    input               y2go,
    output  reg         rmr2,
    output  reg         rmg2,
    output  reg         rmb2,
    output  reg         rmy2,
    output  reg [11:0]  adds1,
    output  reg [11:0]  adds2,
    output  reg [11:0]  adds3,
    output  reg [11:0]  addc1,
    output  reg [11:0]  addc2,
    output  reg [11:0]  addc3,
    output  reg [7:0]   hpboder,
    output  reg         fin
    );
    
    reg [9:0]   score, combo;
    
    //r g b y 
    reg     scorer1, scorer2, hpr;
    reg     scoreg1, scoreg2, hpg;
    reg     scoreb1, scoreb2, hpb;
    reg     scorey1, scorey2, hpy;
    reg     ishpr, ishpg, ishpb, ishpy;
    reg     ishprff, ishpgff, ishpbff, ishpyff;
    
    //r g b y2
    reg     scorer21, scorer22, hpr2;
    reg     scoreg21, scoreg22, hpg2;
    reg     scoreb21, scoreb22, hpb2;
    reg     scorey21, scorey22, hpy2;
    reg     ishpr2, ishpg2, ishpb2, ishpy2;
    reg     ishprff2, ishpgff2, ishpbff2, ishpyff2;
    
    wire [9:0]  pres1, pres2, pres3, prec1, prec2, prec3;
    wire [3:0]  s1, s2, s3, c1, c2, c3;

    assign      pres1 = score / 100;
    assign      pres2 = (score % 100) / 10;
    assign      pres3 = (score % 100) % 10;
    assign      prec1 = combo / 100;
    assign      prec2 = (combo % 100) / 10;
    assign      prec3 = (combo % 100) % 10;
    assign      s1    = pres1[3:0];
    assign      s2    = pres2[3:0];
    assign      s3    = pres3[3:0];
    assign      c1    = prec1[3:0];
    assign      c2    = prec2[3:0];
    assign      c3    = prec3[3:0];
    
    //red judge 判定12フレーム
    always @(posedge CLK) begin
        if(RST) begin
            scorer1 <= 0;
            scorer2 <= 0;
            hpr <= 0;
            rmr <= 0;
            ishpr <= 0;
            ishprff <= 0;
        end else begin
            if (BNTOUT1 && rgo && ((176 <= raddy) && (raddy <= 240))) begin
                if ((200 <= raddy) && (raddy <= 216)) begin
                    scorer1 <= 1;
                end else if ((190 <= raddy) && (raddy <= 226)) begin
                    scorer2 <= 1;
                end else begin
                    hpr <= 1;
                end
                rmr <= 1;
                ishpr <= 0;
            end else if (~ishprff && rgo && raddy >= 258) begin
                ishpr <= 1;
                rmr   <= 1;
                ishprff <= 1;
            end else begin
                rmr <= 0;
                scorer1 <= 0;
                scorer2 <= 0;
                hpr     <= 0;
                ishpr   <= 0;
                ishprff <= 0;
            end
        end
    end
    
     //green judge wire judgeg = (y == 274 || y == 282 || y == 266 || y == 290 || y == 270 || y == 286);
    always @(posedge CLK) begin
        if(RST) begin
            rmg <= 0;
            scoreg1 <= 0;
            scoreg2 <= 0;
            hpg     <= 0;
            ishpg   <= 0;
            ishpgff <= 0;
        end else begin
            if (BNTOUT4 && ggo && ((239 <= gaddy) && (gaddy <= 303))) begin
                if ((263 <= gaddy) && (gaddy <= 279)) begin
                    scoreg1 <= 1;
                end else if ((253 <= gaddy) && (gaddy <= 289)) begin
                    scoreg2 <= 1;
                end else begin
                    hpg <= 1;
                end
                rmg <= 1;
                ishpg <= 0;
            end else if (~ishpgff && ggo && gaddy <= 223) begin
                ishpg <= 1;
                rmg   <= 1;
                ishpgff <= 1;
            end else begin
                rmg <= 0;
                scoreg1 <= 0;
                scoreg2 <= 0;
                hpg     <= 0;
                ishpg   <= 0;
                ishpgff <= 0;
            end
        end
    end
    
     //blue judge wire judgeb = (x == 360 || x == 384 || x == 368 || x == 376 || x == 364 || x == 380);
    always @(posedge CLK) begin
        if(RST) begin
            rmb <= 0;
            scoreb1 <= 0;
            scoreb2 <= 0;
            hpb     <= 0;
            ishpb   <= 0;
            ishpbff <= 0;
        end else begin
            if (BNTOUT3 && bgo && ((347 <= baddx) && (baddx <= 401))) begin
                if ((371 <= baddx) && (baddx <= 387)) begin
                    scoreb1 <= 1;
                end else if ((361 <= baddx) && (baddx <= 397)) begin
                    scoreb2 <= 1;
                end else begin
                    hpb   <= 1;
                end
                rmb <= 1;
                ishpb <= 0;
            end else if (~ishpbff && bgo && baddx <= 317) begin
                ishpb <= 1;
                rmb   <= 1;
                ishpbff <= 1;
            end else begin
                rmb <= 0;
                scoreb1 <= 0;
                scoreb2 <= 0;
                hpb     <= 0;
                ishpb   <= 0;
                ishpbff <= 0;
            end
        end
    end
    
     //yellow judge wire judgey = (x == 257 || x == 281 || x == 265 || x == 273 || x == 261 || x == 277);
    always @(posedge CLK) begin
        if(RST) begin
            rmy <= 0;
            scorey1 <= 0;
            scorey2 <= 0;
            hpy     <= 0;
            ishpy   <= 0;
            ishpyff <= 0;
        end else begin
            if (BNTOUT2 && ygo && ((228 <= yaddx) && (yaddx <= 292))) begin
                if ((252 <= yaddx) && (yaddx <= 268)) begin
                    scorey1 <= 1;
                end else if ((242 <= yaddx) && (yaddx <= 278)) begin
                    scorey2 <= 1;
                end else begin
                    hpy <= 1;
                end
                rmy <= 1;
                ishpy <= 0;
            end else if (~ishpyff && ygo && yaddx >= 324) begin
                ishpy <= 1;
                rmy   <= 1;
                ishpyff <= 1;
            end else begin
                rmy <= 0;
                scorey1 <= 0;
                scorey2 <= 0;
                hpy     <= 0;
                ishpy   <= 0;
                ishpyff <= 0;
            end
        end
    end
    
    //red2 judge 判定12フレーム
    always @(posedge CLK) begin
        if(RST) begin
            scorer21 <= 0;
            scorer22 <= 0;
            hpr2 <= 0;
            rmr2 <= 0;
            ishpr2 <= 0;
            ishprff2 <= 0;
        end else begin
            if (BNTOUT1 && r2go && ((176 <= r2addy) && (r2addy <= 240))) begin
                if ((200 <= r2addy) && (r2addy <= 216)) begin
                    scorer21 <= 1;
                end else if ((190 <= r2addy) && (r2addy <= 226)) begin
                    scorer22 <= 1;
                end else begin
                    hpr2 <= 1;
                end
                rmr2 <= 1;
                ishpr2 <= 0;
            end else if (~ishprff2 && r2go && r2addy >= 258) begin
                ishpr2 <= 1;
                rmr2   <= 1;
                ishprff2 <= 1;
            end else begin
                rmr2 <= 0;
                scorer21 <= 0;
                scorer22 <= 0;
                hpr2     <= 0;
                ishpr2   <= 0;
                ishprff2 <= 0;
            end
        end
    end
    
     //green2 judge wire judgeg = (y == 274 || y == 282 || y == 266 || y == 290 || y == 270 || y == 286);
    always @(posedge CLK) begin
        if(RST) begin
            rmg2 <= 0;
            scoreg21 <= 0;
            scoreg22 <= 0;
            hpg2     <= 0;
            ishpg2   <= 0;
            ishpgff2 <= 0;
        end else begin
            if (BNTOUT4 && g2go && ((239 <= g2addy) && (g2addy <= 303))) begin
                if ((263 <= g2addy) && (g2addy <= 279)) begin
                    scoreg21 <= 1;
                end else if ((253 <= g2addy) && (g2addy <= 289)) begin
                    scoreg22 <= 1;
                end else begin
                    hpg2 <= 1;
                end
                rmg2 <= 1;
                ishpg2 <= 0;
            end else if (~ishpgff2 && g2go && g2addy <= 223) begin
                ishpg2 <= 1;
                rmg2   <= 1;
                ishpgff2 <= 1;
            end else begin
                rmg2 <= 0;
                scoreg21 <= 0;
                scoreg22 <= 0;
                hpg2     <= 0;
                ishpg2   <= 0;
                ishpgff2 <= 0;
            end
        end
    end
    
     //blue2 judge wire judgeb = (x == 360 || x == 384 || x == 368 || x == 376 || x == 364 || x == 380);
    always @(posedge CLK) begin
        if(RST) begin
            rmb2 <= 0;
            scoreb21 <= 0;
            scoreb22 <= 0;
            hpb2     <= 0;
            ishpb2   <= 0;
            ishpbff2 <= 0;
        end else begin
            if (BNTOUT3 && b2go && ((347 <= b2addx) && (b2addx <= 401))) begin
                if ((371 <= b2addx) && (b2addx <= 387)) begin
                    scoreb21 <= 1;
                end else if ((361 <= b2addx) && (b2addx <= 397)) begin
                    scoreb22 <= 1;
                end else begin
                    hpb2   <= 1;
                end
                rmb2 <= 1;
                ishpb2 <= 0;
            end else if (~ishpbff2 && b2go && b2addx <= 317) begin
                ishpb2 <= 1;
                rmb2   <= 1;
                ishpbff2 <= 1;
            end else begin
                rmb2 <= 0;
                scoreb21 <= 0;
                scoreb22 <= 0;
                hpb2     <= 0;
                ishpb2   <= 0;
                ishpbff2 <= 0;
            end
        end
    end
    
     //yellow2 judge wire judgey = (x == 257 || x == 281 || x == 265 || x == 273 || x == 261 || x == 277);
    always @(posedge CLK) begin
        if(RST) begin
            rmy2 <= 0;
            scorey21 <= 0;
            scorey22 <= 0;
            hpy2     <= 0;
            ishpy2   <= 0;
            ishpyff2 <= 0;
        end else begin
            if (BNTOUT2 && y2go && ((228 <= y2addx) && (y2addx <= 292))) begin
                if ((252 <= y2addx) && (y2addx <= 268)) begin
                    scorey21 <= 1;
                end else if ((242 <= y2addx) && (y2addx <= 278)) begin
                    scorey22 <= 1;
                end else begin
                    hpy2 <= 1;
                end
                rmy2 <= 1;
                ishpy2 <= 0;
            end else if (~ishpyff2 && y2go && y2addx >= 324) begin
                ishpy2 <= 1;
                rmy2   <= 1;
                ishpyff2 <= 1;
            end else begin
                rmy2 <= 0;
                scorey21 <= 0;
                scorey22 <= 0;
                hpy2     <= 0;
                ishpy2   <= 0;
                ishpyff2 <= 0;
            end
        end
    end
    
    // score combo hp
//   wire get2 = (scorer1 || scoreg1 || scoreb1 || scorey1 || scorer21 || scoreg21 || scoreb21 || scorey21);
//   wire get1 = (scorer2 || scoreg2 || scoreb2 || scorey2 || scorer22 || scoreg22 || scoreb22 || scorey22);
//   wire get0 = (hpr || hpg || hpb || hpy || hpr2 || hpg2 || hpb2 || hpy2);
//   wire get  = (ishpr || ishpg || ishpb || ishpy || ishpr2 || ishpg2 || ishpb2 || ishpy2);
    always @(posedge CLK) begin
        if (RST) begin
            score <= 10'd0;
            combo <= 10'd0;
            hpboder <= 8'd238;
            fin     <= 0;
        end else begin
            if (scorer1) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scoreg1) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scoreb1) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scorey1) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scorer21) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scoreg21) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scoreb21) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scorey21) begin
                score <= score + 2;
                combo <= combo + 1;
            end
            if (scorer2) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scoreg2) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scoreb2) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scorey2) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scorer22) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scoreg22) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scoreb22) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (scorey22) begin
                score <= score + 1;
                combo <= combo + 1;
            end
            if (hpr) begin
                combo <= 0;
            end
            if (hpg) begin
                combo <= 0;
            end
            if (hpb) begin
                combo <= 0;
            end
            if (hpy) begin
                combo <= 0;
            end
            if (hpr2) begin
                combo <= 0;
            end
            if (hpg2) begin
                combo <= 0;
            end
            if (hpb2) begin
                combo <= 0;
            end
            if (hpy2) begin
                combo <= 0;
            end
            if (ishpr) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpg) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpb) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpy) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpr2) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpg2) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpb2) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
            if (ishpy2) begin
                combo <= 0;
                hpboder <= hpboder - 19;
                if (hpboder <= 67)
                    fin <= 1;
            end
        end
    end
    
    always @(posedge CLK) begin
        if(RST)
            adds1 <= 12'd0;
        else begin
            case(s1)
            4'd0 : adds1 <= 12'd0;
            4'd1 : adds1 <= 12'd340;
            4'd2 : adds1 <= 12'd680;
            4'd3 : adds1 <= 12'd1020;
            4'd4 : adds1 <= 12'd1360;
            4'd5 : adds1 <= 12'd1700;
            4'd6 : adds1 <= 12'd2040;
            4'd7 : adds1 <= 12'd2380;
            4'd8 : adds1 <= 12'd2720;
            4'd9 : adds1 <= 12'd3060;
            default: adds1 <= 12'd0;
            endcase
        end
    end
    always @(posedge CLK) begin
        if(RST)
            adds2 <= 12'd0;
        else begin
            case(s2)
            4'd0 : adds2 <= 12'd0;
            4'd1 : adds2 <= 12'd340;
            4'd2 : adds2 <= 12'd680;
            4'd3 : adds2 <= 12'd1020;
            4'd4 : adds2 <= 12'd1360;
            4'd5 : adds2 <= 12'd1700;
            4'd6 : adds2 <= 12'd2040;
            4'd7 : adds2 <= 12'd2380;
            4'd8 : adds2 <= 12'd2720;
            4'd9 : adds2 <= 12'd3060;
            default: adds2 <= 12'd0;
            endcase
        end
    end
    always @(posedge CLK) begin
        if(RST)
            adds3 <= 12'd0;
        else begin
            case(s3)
            4'd0 : adds3 <= 12'd0;
            4'd1 : adds3 <= 12'd340;
            4'd2 : adds3 <= 12'd680;
            4'd3 : adds3 <= 12'd1020;
            4'd4 : adds3 <= 12'd1360;
            4'd5 : adds3 <= 12'd1700;
            4'd6 : adds3 <= 12'd2040;
            4'd7 : adds3 <= 12'd2380;
            4'd8 : adds3 <= 12'd2720;
            4'd9 : adds3 <= 12'd3060;
            default: adds3 <= 12'd0;
            endcase
        end
    end
    always @(posedge CLK) begin
        if(RST)
            addc1 <= 12'd0;
        else begin
            case(c1)
            4'd0 : addc1 <= 12'd0;
            4'd1 : addc1 <= 12'd340;
            4'd2 : addc1 <= 12'd680;
            4'd3 : addc1 <= 12'd1020;
            4'd4 : addc1 <= 12'd1360;
            4'd5 : addc1 <= 12'd1700;
            4'd6 : addc1 <= 12'd2040;
            4'd7 : addc1 <= 12'd2380;
            4'd8 : addc1 <= 12'd2720;
            4'd9 : addc1 <= 12'd3060;
            default: addc1 <= 12'd0;
            endcase
        end
    end
    always @(posedge CLK) begin
        if(RST)
            addc2 <= 12'd0;
        else begin
            case(c2)
            4'd0 : addc2 <= 12'd0;
            4'd1 : addc2 <= 12'd340;
            4'd2 : addc2 <= 12'd680;
            4'd3 : addc2 <= 12'd1020;
            4'd4 : addc2 <= 12'd1360;
            4'd5 : addc2 <= 12'd1700;
            4'd6 : addc2 <= 12'd2040;
            4'd7 : addc2 <= 12'd2380;
            4'd8 : addc2 <= 12'd2720;
            4'd9 : addc2 <= 12'd3060;
            default: addc2 <= 12'd0;
            endcase
        end
    end
    always @(posedge CLK) begin
        if(RST)
            addc3 <= 12'd0;
        else begin
            case(c3)
            4'd0 : addc3 <= 12'd0;
            4'd1 : addc3 <= 12'd340;
            4'd2 : addc3 <= 12'd680;
            4'd3 : addc3 <= 12'd1020;
            4'd4 : addc3 <= 12'd1360;
            4'd5 : addc3 <= 12'd1700;
            4'd6 : addc3 <= 12'd2040;
            4'd7 : addc3 <= 12'd2380;
            4'd8 : addc3 <= 12'd2720;
            4'd9 : addc3 <= 12'd3060;
            default: addc3 <= 12'd0;
            endcase
        end
    end
    
endmodule
