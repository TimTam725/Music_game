`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 19:16:33
// Design Name: 
// Module Name: mario_bgm
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


module mario_bgm2(
    input                   clk,//100Mhz
    input                   rst,
    input      [1:0]        scrnum,
    output reg [6:0]        scale
    );
    
    wire [4:0]   add;
    reg [3:0]   tim;
    
    
    reg [8:0]  pc;
    reg [24:0]  second;
    wire [8:0] data;
    audio_mem audio_mem(pc, data);
    assign  add = data[8:4];
//    assign  sc = (scale == 3'b000)? 7'd92 
    
    always @(posedge clk) begin
        if (rst || (scrnum == 0) || (scrnum == 2)) begin
            pc      <= 9'd0;
            tim     <= data[3:0];
            second  <= 25'd0;
        end else begin
            if (second == 25'd0) begin
                second <= 25'd9999999;//99:理論上16分音符0.1s　実際0.101とか？
                if (tim == 4'd0) begin
                    tim  <= data[3:0];    //data
                    if (pc < 459)
                        pc  <= pc + 1; //次のデータ
                    case(data[8:4])
                     5'd0  :   scale <= 7'd0;//無音
                     5'd1  :   scale <= 7'd92;//ド
                     5'd2  :   scale <= 7'd87;//#ド
                     5'd3  :   scale <= 7'd82;//レ
                     5'd4  :   scale <= 7'd77;//#レ
                     5'd5  :   scale <= 7'd73;//ミ
                     5'd6  :   scale <= 7'd69;//ファ
                     5'd7  :   scale <= 7'd65;//#ファ
                     5'd8  :   scale <= 7'd61;//ソ
                     5'd9  :   scale <= 7'd58;//#ソ
                     5'd10 :   scale <= 7'd55;//ラ
                     5'd11 :   scale <= 7'd51;//#ラ
                     5'd12 :   scale <= 7'd49;//シ
                     5'd13 :   scale <= 7'd46;//ド 主旋律
                     5'd14 :   scale <= 7'd43;//#ド
                     5'd15 :   scale <= 7'd41;//レ
                     5'd16 :   scale <= 7'd39;//#レ
                     5'd17 :   scale <= 7'd36;//ミ
                     5'd18 :   scale <= 7'd34;//ファ
                     5'd19 :   scale <= 7'd32;//#ファ
                     5'd20 :   scale <= 7'd31;//ソ
                     5'd21 :   scale <= 7'd29;//#ソ
                     5'd23 :   scale <= 7'd27;//ラ
                     5'd24 :   scale <= 7'd26;//#ラ
                     5'd25 :   scale <= 7'd24;//シ
                     5'd26 :   scale <= 7'd23;//ド
                     default : scale <= 7'd0;
                    endcase
                end else
                    tim  <= tim - 1;
            end else begin
                second <= second - 1;
            end
        end
    end
    
endmodule

    
//    assign scale = (add == 5'd0)  ? 7'd0 ://無音
//                    (add == 5'd1)  ? 7'd92 ://ド
//                    (add == 5'd2)  ? 7'd87 ://#ド
//                    (add == 5'd3)  ? 7'd82 ://レ
//                    (add == 5'd4)  ? 7'd77 ://#レ
//                    (add == 5'd5)  ? 7'd73 ://ミ
//                    (add == 5'd6)  ? 7'd69 ://ファ
//                    (add == 5'd7)  ? 7'd65 ://#ファ
//                    (add == 5'd8)  ? 7'd61 ://ソ
//                    (add == 5'd9)  ? 7'd58 ://#ソ
//                    (add == 5'd10) ? 7'd55 ://ラ
//                    (add == 5'd11) ? 7'd51 ://#ラ
//                    (add == 5'd12) ? 7'd49 ://シ
//                    (add == 5'd13) ? 7'd46 ://ド 主旋律
//                    (add == 5'd14) ? 7'd43 ://#ド
//                    (add == 5'd15) ? 7'd41 ://レ
//                    (add == 5'd16) ? 7'd39 ://#レ
//                    (add == 5'd17) ? 7'd36 ://ミ
//                    (add == 5'd18) ? 7'd34 ://ファ
//                    (add == 5'd19) ? 7'd32 ://#ファ
//                    (add == 5'd20) ? 7'd31 ://ソ
//                    (add == 5'd21) ? 7'd29 ://#ソ
//                    (add == 5'd23) ? 7'd27 ://ラ
//                    (add == 5'd24) ? 7'd26 ://#ラ
//                    (add == 5'd25) ? 7'd24 ://シ
//                    0;
