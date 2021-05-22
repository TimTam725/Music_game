`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/02 19:01:29
// Design Name: 
// Module Name: noots
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


module noots(
    input               clk,
    input               rst,
    input      [1:0]    scrnum,
    input               changescr,
    input               rmr,
    input               rmg,
    input               rmb,
    input               rmy,
    input               rmr2,
    input               rmg2,
    input               rmb2,
    input               rmy2,
    output reg [9:0]    raddy,
    output reg [9:0]    gaddy,
    output reg [9:0]    baddx,
    output reg [9:0]    yaddx,
    output reg [9:0]    r2addy,
    output reg [9:0]    g2addy,
    output reg [9:0]    b2addx,
    output reg [9:0]    y2addx,
    output reg          rgo,
    output reg          ggo,
    output reg          bgo,
    output reg          ygo,
    output reg          r2go,
    output reg          g2go,
    output reg          b2go,
    output reg          y2go
    );
    
    reg [7:0]   pc;
//    reg [2:0]  second;
    reg [9:0]   cnt;
    wire [13:0]   data;
    
    block_mem block_mem(pc, data);
    
    always @(posedge clk) begin
        if (rst || scrnum == 0) begin
            pc  <= 0;
            cnt <= 0;
            rgo <= 0;
            ggo <= 0;
            bgo <= 0;
            ygo <= 0;
            r2go <= 0;
            g2go <= 0;
            b2go <= 0;
            y2go <= 0;
        end else begin
            if (rmr || rmg || rmb || rmy || rmr2 || rmg2 || rmb2 || rmy2) begin
                if (rmr)
                    rgo <= 0;
                if (rmg)
                    ggo <= 0;
                if (rmb)
                    bgo <= 0;
                if (rmy)
                    ygo <= 0;
                if (rmr2)
                    r2go <= 0;
                if (rmg2)
                    g2go <= 0;
                if (rmb2)
                    b2go <= 0;
                if (rmy2)
                    y2go <= 0;
            end
            if (changescr) begin
                if (rgo) //アドレス変化
                    raddy   <= raddy + 2;
                if (ggo)
                    gaddy   <= gaddy - 2;
                if (bgo)
                    baddx   <= baddx - 2;
                if (ygo)
                    yaddx   <= yaddx + 2;
                if (r2go) //アドレス変化
                    r2addy   <= r2addy + 2;
                if (g2go)
                    g2addy   <= g2addy - 2;
                if (b2go)
                    b2addx   <= b2addx - 2;
                if (y2go)
                    y2addx   <= y2addx + 2;
                if (cnt == 10'd0) begin //次のブロックの読み出し
                    cnt <= data[9:0];
                    if (pc <= 143)
                        pc  <= pc + 1;
                    case (data[13:10])
                    4'd1 : 
                    begin
                        rgo     <= 1;
                        raddy   <= 0;
                    end
                    4'd2 :
                    begin
                        ggo     <= 1;
                        gaddy   <= 479;
                    end
                    4'd3 :
                    begin
                        bgo     <= 1;
                        baddx   <= 639;
                    end
                    4'd4 :
                    begin
                        ygo     <= 1;
                        yaddx   <= 0;
                    end
                    4'd5 : //red & green
                    begin
                        rgo     <= 1;
                        raddy   <= 0;
                        ggo     <= 1;
                        gaddy   <= 479;
                    end
                    4'd6 : //yellow & blue
                    begin
                        ygo     <= 1;
                        yaddx   <= 0;
                        bgo     <= 1;
                        baddx   <= 639;
                    end
                    4'd7 : //red2 & green2
                    begin
                        r2go     <= 1;
                        r2addy   <= 0;
                        g2go     <= 1;
                        g2addy   <= 479;
                    end
                    4'd8 : //yellow2 & blue2
                    begin
                        y2go     <= 1;
                        y2addx   <= 0;
                        b2go     <= 1;
                        b2addx   <= 639;
                    end
                    4'd9 : //yellow & green nonw
                    begin
                        ygo     <= 1;
                        yaddx   <= 0;
                        ggo     <= 1;
                        gaddy   <= 479;
                    end
                    4'd10 : //blue & green nonw
                    begin
                        ggo     <= 1;
                        gaddy   <= 479;
                        bgo     <= 1;
                        baddx   <= 639;
                    end
                    4'd11 : 
                    begin
                        r2go     <= 1;
                        r2addy   <= 0;
                    end
                    4'd12 :
                    begin
                        g2go     <= 1;
                        g2addy   <= 479;
                    end
                    4'd13 :
                    begin
                        b2go     <= 1;
                        b2addx   <= 639;
                    end
                    4'd14 :
                    begin
                        y2go     <= 1;
                        y2addx   <= 0;
                    end
                    endcase
                end else
                    cnt     <= cnt - 1;
            end
        end
    end

    
endmodule
