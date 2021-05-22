`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/02 19:50:47
// Design Name: 
// Module Name: block_mem
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


module block_mem(
//    input               clk,
    input      [7:0]    pc,
    output     [13:0]   data
    );
    
    reg [13:0]  data_mem[156:0];
    
    integer i;
    initial begin
        for (i = 143; i <= 156; i = i + 1) begin
            data_mem[i] <= {4'd0, 10'd1000};
        end //1:r 2:g 3:b 4:y 5:rg 6:by 7:ry 8:rb 9:gy 10:gb
        
        //リズム正解
//        data_mem[0] <= {4'd0, 10'd76};//1F 0.016s 60>>94
//        data_mem[1] <= {4'd1, 10'd94}; //95>x>93>89 94で決定
//        data_mem[2] <= {4'd11, 10'd94};
//        data_mem[3] <= {4'd1, 10'd94};
//        data_mem[4] <= {4'd11, 10'd94};
//        data_mem[5] <= {4'd1, 10'd95};
//        data_mem[6] <= {4'd11, 10'd94};
//        data_mem[7] <= {4'd1, 10'd94};
//        data_mem[8] <= {4'd11, 10'd94};
//        data_mem[9] <= {4'd1, 10'd94};
//        data_mem[10] <= {4'd11, 10'd95};
//        data_mem[11] <= {4'd1, 10'd94};
//        data_mem[12] <= {4'd11, 10'd94};
//        data_mem[13] <= {4'd1, 10'd94};
//        data_mem[14] <= {4'd11, 10'd94};
//        data_mem[15] <= {4'd1, 10'd95};
//        data_mem[16] <= {4'd11, 10'd94};
//        data_mem[17] <= {4'd1, 10'd94};
//        data_mem[18] <= {4'd11, 10'd94};
//        data_mem[19] <= {4'd1, 10'd94};//20
//        data_mem[20] <= {4'd11, 10'd95};
//        data_mem[21] <= {4'd1, 10'd94};
//        data_mem[22] <= {4'd11, 10'd94};
//        data_mem[23] <= {4'd1, 10'd94};
//        data_mem[24] <= {4'd11, 10'd94};//25
//        data_mem[25] <= {4'd1, 10'd95};
//        data_mem[26] <= {4'd11, 10'd94};
//        data_mem[27] <= {4'd1, 10'd94};
//        data_mem[28] <= {4'd11, 10'd94};
//        data_mem[29] <= {4'd1, 10'd94};
//        data_mem[30] <= {4'd11, 10'd95};
//        data_mem[31] <= {4'd1, 10'd94};
//        data_mem[32] <= {4'd11, 10'd94};
//        data_mem[33] <= {4'd1, 10'd94};
//        data_mem[34] <= {4'd11, 10'd94};//10 //1F 0.016s 60>>94
//        data_mem[35] <= {4'd1, 10'd95};
//        data_mem[36] <= {4'd11, 10'd94};
//        data_mem[37] <= {4'd1, 10'd94};
//        data_mem[38] <= {4'd11, 10'd94};
//        data_mem[39] <= {4'd1, 10'd94};
//        data_mem[40] <= {4'd11, 10'd95};
//        data_mem[41] <= {4'd1, 10'd94};
//        data_mem[42] <= {4'd11, 10'd94};
//        data_mem[43] <= {4'd1, 10'd94};
//        data_mem[44] <= {4'd11, 10'd94};//20
//        data_mem[45] <= {4'd1, 10'd95};
//        data_mem[46] <= {4'd11, 10'd94};
//        data_mem[47] <= {4'd1, 10'd94};
//        data_mem[48] <= {4'd11, 10'd94};//24
//        data_mem[49] <= {4'd1, 10'd94};
//        data_mem[50] <= {4'd11, 10'd95};
//        data_mem[51] <= {4'd1, 10'd94};
//        data_mem[52] <= {4'd11, 10'd94};
//        data_mem[53] <= {4'd1, 10'd94};
//        data_mem[54] <= {4'd11, 10'd94};
//        data_mem[55] <= {4'd1, 10'd95};
//        data_mem[56] <= {4'd11, 10'd94};
//        data_mem[57] <= {4'd1, 10'd94};
//        data_mem[58] <= {4'd11, 10'd94};//10
//        data_mem[59] <= {4'd1, 10'd94};
//        data_mem[60] <= {4'd11, 10'd95};
//        data_mem[61] <= {4'd1, 10'd94};
//        data_mem[62] <= {4'd11, 10'd94};
//        data_mem[63] <= {4'd1, 10'd94};
//        data_mem[64] <= {4'd11, 10'd94};
//        data_mem[65] <= {4'd1, 10'd95};
//        data_mem[66] <= {4'd11, 10'd94};
//        data_mem[67] <= {4'd1, 10'd94};
//        data_mem[68] <= {4'd11, 10'd94};//20
//        data_mem[69] <= {4'd1, 10'd94};
//        data_mem[70] <= {4'd11, 10'd95};
//        data_mem[71] <= {4'd1, 10'd94};
//        data_mem[72] <= {4'd11, 10'd94};//24
//        data_mem[73] <= {4'd1, 10'd94};
//        data_mem[74] <= {4'd11, 10'd1000};//終わり
//        data_mem[75] <= {4'd1, 10'd95};
//        data_mem[76] <= {4'd11, 10'd94};
//        data_mem[77] <= {4'd1, 10'd94};
//        data_mem[78] <= {4'd11, 10'd94};
//        data_mem[79] <= {4'd1, 10'd94};
//        data_mem[80] <= {4'd11, 10'd95};
//        data_mem[81] <= {4'd1, 10'd94};
//        data_mem[82] <= {4'd11, 10'd94};//10
//        data_mem[83] <= {4'd1, 10'd94};
//        data_mem[84] <= {4'd11, 10'd94};
//        data_mem[85] <= {4'd1, 10'd95};
//        data_mem[86] <= {4'd11, 10'd94};
        
//        data_mem[87] <= {4'd1, 10'd94};
//        data_mem[88] <= {4'd11, 10'd94};
//        data_mem[89] <= {4'd1, 10'd95};
//        data_mem[90] <= {4'd1, 10'd94};
//        data_mem[91] <= {4'd11, 10'd94};//10
//        data_mem[92] <= {4'd1, 10'd94};
//        data_mem[93] <= {4'd11, 10'd94};
//        data_mem[94] <= {4'd1, 10'd95};
//        data_mem[95] <= {4'd1, 10'd94};
//        data_mem[96] <= {4'd11, 10'd94};//10
//        data_mem[97] <= {4'd1, 10'd94};
//        data_mem[98] <= {4'd11, 10'd94};
//        data_mem[99] <= {4'd1, 10'd95};
//        data_mem[100] <= {4'd1, 10'd94};
//        data_mem[101] <= {4'd11, 10'd94};//10
//        data_mem[102] <= {4'd1, 10'd94};
//        data_mem[103] <= {4'd11, 10'd94};
//        data_mem[104] <= {4'd1, 10'd95};
//        data_mem[105] <= {4'd1, 10'd94};
//        data_mem[106] <= {4'd11, 10'd94};//10
//        data_mem[107] <= {4'd1, 10'd94};
//        data_mem[108] <= {4'd11, 10'd94};
//        data_mem[109] <= {4'd1, 10'd95};
//        data_mem[110] <= {4'd1, 10'd94};
//        data_mem[111] <= {4'd11, 10'd94};//10
//        data_mem[112] <= {4'd1, 10'd94};
//        data_mem[113] <= {4'd11, 10'd94};
//        data_mem[114] <= {4'd1, 10'd95};
//        data_mem[115] <= {4'd1, 10'd94};
//        data_mem[116] <= {4'd11, 10'd94};//10
//        data_mem[117] <= {4'd1, 10'd94};
//        data_mem[118] <= {4'd11, 10'd94};
//        data_mem[119] <= {4'd1, 10'd95};
//        data_mem[120] <= {4'd1, 10'd94};
//        data_mem[121] <= {4'd11, 10'd94};//10
//        data_mem[122] <= {4'd1, 10'd94};
//        data_mem[123] <= {4'd11, 10'd94};
//        data_mem[124] <= {4'd1, 10'd95};
//        data_mem[125] <= {4'd1, 10'd94};
//        data_mem[126] <= {4'd11, 10'd94};//10
//        data_mem[127] <= {4'd1, 10'd94};
//        data_mem[128] <= {4'd11, 10'd94};
//        data_mem[129] <= {4'd1, 10'd95};
//        data_mem[130] <= {4'd1, 10'd94};
//        data_mem[131] <= {4'd11, 10'd94};//10
//        data_mem[132] <= {4'd1, 10'd94};
//        data_mem[133] <= {4'd11, 10'd94};
//        data_mem[134] <= {4'd1, 10'd95};
//        data_mem[135] <= {4'd1, 10'd94};
//        data_mem[136] <= {4'd11, 10'd94};//10
//        data_mem[137] <= {4'd1, 10'd94};
//        data_mem[138] <= {4'd11, 10'd94};
//        data_mem[139] <= {4'd1, 10'd95};
//        data_mem[140] <= {4'd1, 10'd94};
//        data_mem[141] <= {4'd11, 10'd94};//10
//        data_mem[142] <= {4'd1, 10'd94};
        
      


        data_mem[0] <= {4'd0, 10'd76};//1F 0.016s 60>>94
        data_mem[1] <= {4'd1, 10'd94};  //ミ95>x>93>89 94で決定
        data_mem[2] <= {4'd11, 10'd47}; //ソ
        data_mem[3] <= {4'd1, 10'd47};  //ソ
        data_mem[4] <= {4'd2, 10'd9};   //ド
        data_mem[5] <= {4'd4, 10'd35};  //ソ
        data_mem[6] <= {4'd13, 10'd120};//ミ
        data_mem[7] <= {4'd11, 10'd71}; //ラ
        data_mem[8] <= {4'd12, 10'd95}; //ファ
        data_mem[9] <= {4'd5, 10'd47};  //レシ
        data_mem[10] <= {4'd11, 10'd9}; //ド
        data_mem[11] <= {4'd13, 10'd35};//ソ
        data_mem[12] <= {4'd14, 10'd120};//ミ
        data_mem[13] <= {4'd1, 10'd70}; //ラ
        data_mem[14] <= {4'd11, 10'd69};//ファ
        data_mem[15] <= {4'd6, 10'd73}; //レシ
        data_mem[16] <= {4'd1, 10'd68}; //・
        data_mem[17] <= {4'd14, 10'd120};//・
        data_mem[18] <= {4'd13, 10'd80};    //・
        data_mem[19] <= {4'd6, 10'd61}; //ド //20
        data_mem[20] <= {4'd5, 10'd47}; //ドド
        data_mem[21] <= {4'd11, 10'd69};//・
        data_mem[22] <= {4'd14, 10'd144};//・
        data_mem[23] <= {4'd12, 10'd9};//ミ
        data_mem[24] <= {4'd6, 10'd61};//レ25 //1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[25] <= {4'd5, 10'd94};//ド
        data_mem[26] <= {4'd12, 10'd68};//・
        data_mem[27] <= {4'd13, 10'd121};//・
        data_mem[28] <= {4'd11, 10'd106};//・
        data_mem[29] <= {4'd5, 10'd9};  //ド
        data_mem[30] <= {4'd6, 10'd73}; //ドド
        data_mem[31] <= {4'd12, 10'd68};//・
        data_mem[32] <= {4'd14, 10'd144};//・
        data_mem[33] <= {4'd7, 10'd9};
        data_mem[34] <= {4'd6, 10'd61};//レ10 //1F 0.016s 60>>94
        data_mem[35] <= {4'd5, 10'd92};//ド
        data_mem[36] <= {4'd14, 10'd1};//
        data_mem[37] <= {4'd11, 10'd45};
        data_mem[38] <= {4'd13, 10'd2};
        data_mem[39] <= {4'd2, 10'd44};
        data_mem[40] <= {4'd3, 10'd1};//1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[41] <= {4'd1, 10'd44};
        data_mem[42] <= {4'd4, 10'd2};
        data_mem[43] <= {4'd12, 10'd46};
        data_mem[44] <= {4'd11, 10'd21};//20
        data_mem[45] <= {4'd14, 10'd73};
        data_mem[46] <= {4'd2, 10'd21};
        data_mem[47] <= {4'd13, 10'd73};
        data_mem[48] <= {4'd1, 10'd23};//24
        data_mem[49] <= {4'd11, 10'd23};
        data_mem[50] <= {4'd12, 10'd21};
        data_mem[51] <= {4'd4, 10'd1};
        data_mem[52] <= {4'd2, 10'd21};
        data_mem[53] <= {4'd14, 10'd23};
        data_mem[54] <= {4'd3, 10'd23};
        data_mem[55] <= {4'd13, 10'd49};
        data_mem[56] <= {4'd1, 10'd94};
        data_mem[57] <= {4'd7, 10'd21};
        data_mem[58] <= {4'd6, 10'd73};//10
        data_mem[59] <= {4'd2, 10'd9};
        data_mem[60] <= {4'd14, 10'd35};//1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[61] <= {4'd13, 10'd120};//ここ！！！
        data_mem[62] <= {4'd1, 10'd70};
        data_mem[63] <= {4'd2, 10'd94};
        data_mem[64] <= {4'd7, 10'd47};
        data_mem[65] <= {4'd1, 10'd9};
        data_mem[66] <= {4'd13, 10'd35};
        data_mem[67] <= {4'd4, 10'd121};//ok
        data_mem[68] <= {4'd12, 10'd71};//20
//        data_mem[69] <= {4'd11, 10'd68};//間違ってる修正必要
//        data_mem[70] <= {4'd5, 10'd47};
        data_mem[69] <= {4'd11, 10'd94};//間違ってる修正必要
        data_mem[70] <= {4'd5, 10'd21};
        data_mem[71] <= {4'd14, 10'd37};
        data_mem[72] <= {4'd11, 10'd56};//24
        data_mem[73] <= {4'd13, 10'd35};
        data_mem[74] <= {4'd4, 10'd1};
        data_mem[75] <= {4'd2, 10'd35};
        data_mem[76] <= {4'd1, 10'd33};
        data_mem[77] <= {4'd14, 10'd73};
        data_mem[78] <= {4'd11, 10'd9};
        data_mem[79] <= {4'd3, 10'd73};
        data_mem[80] <= {4'd12, 10'd21};//変えた
        data_mem[81] <= {4'd13, 10'd37};
        data_mem[82] <= {4'd2, 10'd56};//10
        data_mem[83] <= {4'd4, 10'd35};
        data_mem[84] <= {4'd3, 10'd1};//1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[85] <= {4'd1, 10'd35};
        data_mem[86] <= {4'd12, 10'd47};
        data_mem[87] <= {4'd11, 10'd35};
        data_mem[88] <= {4'd2, 10'd32};
        data_mem[89] <= {4'd8, 10'd95};
        data_mem[90] <= {4'd4, 10'd37};
        data_mem[91] <= {4'd1, 10'd56};
        data_mem[92] <= {4'd3, 10'd35};
        data_mem[93] <= {4'd14, 10'd1};
        data_mem[94] <= {4'd2, 10'd35};
        data_mem[95] <= {4'd11, 10'd32};
        data_mem[96] <= {4'd4, 10'd73};//10
        data_mem[97] <= {4'd1, 10'd9};
        data_mem[98] <= {4'd3, 10'd73};
        data_mem[99] <= {4'd12, 10'd21};
        data_mem[100] <= {4'd13, 10'd37};
        data_mem[101] <= {4'd2, 10'd57};
        data_mem[102] <= {4'd4, 10'd35};
        data_mem[103] <= {4'd3, 10'd1};//10
        data_mem[104] <= {4'd1, 10'd35};
        data_mem[105] <= {4'd12, 10'd47};
        data_mem[106] <= {4'd11, 10'd35};
        
//        data_mem[107] <= {4'd2, 10'd22};//修正？33戻してもいいかも
//        data_mem[107] <= {4'd2, 10'd32};//3f修正なし
        data_mem[107] <= {4'd2, 10'd29};//3f修正あり
        data_mem[108] <= {4'd8, 10'd110};
        data_mem[109] <= {4'd5, 10'd47};
        data_mem[110] <= {4'd7, 10'd21};//10
        data_mem[111] <= {4'd6, 10'd47};//1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[112] <= {4'd8, 10'd73};//itta  
        
        data_mem[113] <= {4'd1, 10'd47};//以下よさそう
        data_mem[114] <= {4'd2, 10'd21};
        data_mem[115] <= {4'd3, 10'd47};
        data_mem[116] <= {4'd4, 10'd47}; 
        data_mem[117] <= {4'd8, 10'd73};
        data_mem[118] <= {4'd7, 10'd47};
        data_mem[119] <= {4'd5, 10'd68};
//        data_mem[120] <= {4'd6, 10'd47};
        data_mem[120] <= {4'd14, 10'd25};
        data_mem[121] <= {4'd11, 10'd21};
        data_mem[122] <= {4'd13, 10'd25};
        data_mem[123] <= {4'd12, 10'd21};
        data_mem[124] <= {4'd6, 10'd73};
        data_mem[125] <= {4'd5, 10'd21};
        data_mem[126] <= {4'd14, 10'd25};
        data_mem[127] <= {4'd11, 10'd68};
        data_mem[128] <= {4'd13, 10'd25};
        data_mem[129] <= {4'd12, 10'd68};
        data_mem[130] <= {4'd4, 10'd25};
        data_mem[131] <= {4'd2, 10'd68};//1:r 2:g 3:b 4:y 5:rg 6:by 7:rg2 8:yb2 9:gy 10:gb
        data_mem[132] <= {4'd3, 10'd25};
        data_mem[133] <= {4'd1, 10'd69};
        data_mem[134] <= {4'd13, 10'd25};
        data_mem[135] <= {4'd11, 10'd68};
        data_mem[136] <= {4'd14, 10'd25};
        data_mem[137] <= {4'd12, 10'd68};
        data_mem[138] <= {4'd3, 10'd25};
        data_mem[139] <= {4'd2, 10'd68};
        data_mem[140] <= {4'd8, 10'd25};
        data_mem[141] <= {4'd7, 10'd1000};
        
    end
    
    assign  data = data_mem[pc];
    
endmodule
