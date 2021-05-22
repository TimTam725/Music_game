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
                second <= 25'd9999999;//99:���_��16������0.1s�@����0.101�Ƃ��H
                if (tim == 4'd0) begin
                    tim  <= data[3:0];    //data
                    if (pc < 459)
                        pc  <= pc + 1; //���̃f�[�^
                    case(data[8:4])
                     5'd0  :   scale <= 7'd0;//����
                     5'd1  :   scale <= 7'd92;//�h
                     5'd2  :   scale <= 7'd87;//#�h
                     5'd3  :   scale <= 7'd82;//��
                     5'd4  :   scale <= 7'd77;//#��
                     5'd5  :   scale <= 7'd73;//�~
                     5'd6  :   scale <= 7'd69;//�t�@
                     5'd7  :   scale <= 7'd65;//#�t�@
                     5'd8  :   scale <= 7'd61;//�\
                     5'd9  :   scale <= 7'd58;//#�\
                     5'd10 :   scale <= 7'd55;//��
                     5'd11 :   scale <= 7'd51;//#��
                     5'd12 :   scale <= 7'd49;//�V
                     5'd13 :   scale <= 7'd46;//�h �����
                     5'd14 :   scale <= 7'd43;//#�h
                     5'd15 :   scale <= 7'd41;//��
                     5'd16 :   scale <= 7'd39;//#��
                     5'd17 :   scale <= 7'd36;//�~
                     5'd18 :   scale <= 7'd34;//�t�@
                     5'd19 :   scale <= 7'd32;//#�t�@
                     5'd20 :   scale <= 7'd31;//�\
                     5'd21 :   scale <= 7'd29;//#�\
                     5'd23 :   scale <= 7'd27;//��
                     5'd24 :   scale <= 7'd26;//#��
                     5'd25 :   scale <= 7'd24;//�V
                     5'd26 :   scale <= 7'd23;//�h
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

    
//    assign scale = (add == 5'd0)  ? 7'd0 ://����
//                    (add == 5'd1)  ? 7'd92 ://�h
//                    (add == 5'd2)  ? 7'd87 ://#�h
//                    (add == 5'd3)  ? 7'd82 ://��
//                    (add == 5'd4)  ? 7'd77 ://#��
//                    (add == 5'd5)  ? 7'd73 ://�~
//                    (add == 5'd6)  ? 7'd69 ://�t�@
//                    (add == 5'd7)  ? 7'd65 ://#�t�@
//                    (add == 5'd8)  ? 7'd61 ://�\
//                    (add == 5'd9)  ? 7'd58 ://#�\
//                    (add == 5'd10) ? 7'd55 ://��
//                    (add == 5'd11) ? 7'd51 ://#��
//                    (add == 5'd12) ? 7'd49 ://�V
//                    (add == 5'd13) ? 7'd46 ://�h �����
//                    (add == 5'd14) ? 7'd43 ://#�h
//                    (add == 5'd15) ? 7'd41 ://��
//                    (add == 5'd16) ? 7'd39 ://#��
//                    (add == 5'd17) ? 7'd36 ://�~
//                    (add == 5'd18) ? 7'd34 ://�t�@
//                    (add == 5'd19) ? 7'd32 ://#�t�@
//                    (add == 5'd20) ? 7'd31 ://�\
//                    (add == 5'd21) ? 7'd29 ://#�\
//                    (add == 5'd23) ? 7'd27 ://��
//                    (add == 5'd24) ? 7'd26 ://#��
//                    (add == 5'd25) ? 7'd24 ://�V
//                    0;
