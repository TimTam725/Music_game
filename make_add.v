`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 13:08:32
// Design Name: 
// Module Name: make_address
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


module make_add(
    input               PCK,
    input               RST,
    output      [9:0]   x,
    output      [9:0]   y,
    output      reg     VGA_HS,
    output      reg     VGA_VS,
    output              disp_enable,
    output      reg     changescr,
    output reg  [18:0]  bramadd
    );
    
    `include "vga_param.vh"
    
    reg [9:0]   HCNT, VCNT;
    reg [18:0]  cnt40;
    wire [9:0] hsstart = HFRONT - 10'h001;
    wire [9:0] hsend   = HFRONT + HWIDTH - 10'h001;
    wire [9:0] vsstart = VFRONT;
    wire [9:0] vsend   = VFRONT + VWIDTH;
    wire [9:0] HBLANK = HFRONT + HWIDTH + HBACK;
    wire [9:0] VBLANK = VFRONT + VWIDTH + VBACK;

    wire hcntend = (HCNT == HPERIOD - 10'h001);

    //800進カウンタ
    always @( posedge PCK ) begin
        if ( RST )
            HCNT <= 10'd000;
         else if ( hcntend )
            HCNT <= 10'h000;
        else
            HCNT <= HCNT + 10'h001;
    end
    //525進カウンタ
    always @( posedge PCK ) begin
        if ( RST ) begin
            VCNT <= 10'd0;
            changescr <= 0;
        end else if ( hcntend ) begin
            if ( VCNT == VPERIOD - 10'h001 ) begin
                VCNT <= 10'd0;
                changescr <= 1;
            end else begin
                VCNT <= VCNT + 10'h001;
                changescr <= 0;
            end
        end
    end
    //307200進カウンタ
    always @ (posedge PCK) begin
        if ( RST )
            bramadd <= 19'd0;
        else if((VBLANK <= VCNT) && (HBLANK-10'd2 <= HCNT) && (HCNT < HPERIOD-10'd2)) begin //158 ~ 797
            if (bramadd == 19'd307199)
                bramadd <= 19'd0;
            else
                bramadd <= bramadd + 1;
        end
    end
    //40万進カウンタ
//    always @ (posedge PCK) begin
//        if ( RST ) begin
//            cnt40 <= 19'd0;
//            changesrc <= 0;
//        end else begin
//            if (cnt40 == 19'd399999) begin
//                cnt40 <= 0;
//                changesrc <= 1;
//            end else begin
//                cnt40 <= cnt40 + 1;
//                changesrc <= 0;
//            end
//        end
//    end


    always @( posedge PCK ) begin
        if ( RST )
            VGA_HS <= 1'b1;
        else if ( HCNT == hsstart )
            VGA_HS <= 1'b0;
        else if ( HCNT == hsend )
            VGA_HS <= 1'b1;
    end

    always @( posedge PCK ) begin
        if ( RST ) begin
            VGA_VS <= 1'b1;
        end else if ( HCNT == hsstart ) begin
            if ( VCNT == vsstart )
                VGA_VS <= 1'b0;
            else if ( VCNT == vsend )
                VGA_VS <= 1'b1;
        end
    end
    

    assign disp_enable = (VBLANK <= VCNT) && (HBLANK-10'd1 <= HCNT) && (HCNT < HPERIOD-10'd1);
    assign x = (disp_enable)? HCNT - HBLANK + 10'd1 : 10'd0; //HCNT : 159 ~ 798 hadd : 0 ~ 639 
    assign y = (disp_enable)? VCNT - VBLANK : 10'd0; // VCNT : 45 ~ 524 vadd : 0 ~ 479
    
    
endmodule
