`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:34:41
// Design Name: 
// Module Name: music_game
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


module music_game( CLK, RST, VGA_B, VGA_G, VGA_R, VGA_HS, VGA_VS );
    input           CLK, RST;
    output  [3:0]   VGA_B, VGA_G, VGA_R;
    output          VGA_HS, VGA_VS;
    
    wire        PCK, disp_enable, changesrc;
    wire [9:0]  x, y; 
    wire [18:0] bramadd;
    
    pckgen pck( CLK, PCK );
    make_add make_add( PCK, RST, x, y, VGA_HS, VGA_VS, disp_enable, changesrc, bramadd );
    graphic graphic( PCK, RST, disp_enable, x, y, changesrc, bramadd, VGA_B, VGA_G, VGA_R );
     
endmodule
