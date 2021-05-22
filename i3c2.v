`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 19:16:45
// Design Name: 
// Module Name: i3c2
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


module i3c2(
    input                   clk,
    input                   rst,
    input                   i2c_sda_i,
    output reg              i2c_scl,
    output reg              i2c_sda_o,
    output reg              i2c_sda_t
    );
    
    localparam STATE_RUN        = 4'b0000;
    localparam STATE_DELAY      = 4'b0001;
    localparam STATE_I2C_START  = 4'b0010;
    localparam STATE_I2C_BITS   = 4'b0011;
    localparam STATE_I2C_STOP   = 4'b0100;
    reg [3:0]   state;

    localparam OPCODE_JUMP      = 4'b0000;
    localparam OPCODE_SKIPCLEAR = 4'b0010;
    localparam OPCODE_DELAY     = 4'b0110;
    localparam OPCODE_I2C_STOP  = 4'b1010;
    localparam OPCODE_I2C_WRITE = 4'b1011;
    wire [3:0]   opcode;
//    opcode <= ()
    
    reg         ack_flag, skip;
    
    //I2C status
    reg         i2c_started;
    reg [3:0]   i2c_bits_left;
    
    //counters
    reg [9:0]   pcnext;
    reg [15:0]  delay;
    reg [7:0]   bitcount;
    
    //Input/Output data
    reg [8:0]   i2c_data;
    wire [8:0]  inst_data;
    
    adau1761_configuraiton_data adau1761_configuraiton_data(clk, pcnext, inst_data);
    
    assign opcode = (inst_data[8:7] == 2'b00)           ? OPCODE_JUMP:
                     (inst_data[8:4] == 5'b01000)       ? OPCODE_SKIPCLEAR:
                     (inst_data[8:4] == 5'b01110)       ? OPCODE_DELAY:
                     (inst_data[8:0] == 9'b011111111)   ? OPCODE_I2C_STOP:
                     (inst_data[8:8] == 1'b1)            ? OPCODE_I2C_WRITE : 4'b1111;
    
    always @(posedge clk) begin
        if(rst) begin
            ack_flag        <= 1'b0;
            skip            <= 1'b1;
            i2c_started     <= 1'b0;
            i2c_bits_left   <= 4'd0;
            pcnext          <= 10'd1;
            delay           <= 16'd0;
            bitcount        <= 8'd0;
            i2c_data        <= 9'd0;
            state           <= STATE_RUN;
            i2c_scl         <= 1;
            i2c_sda_o       <= 0;
            i2c_sda_t       <= 1;
        end else begin
            case(state)
            STATE_I2C_START:
            begin
                i2c_started     <= 1'b1;
                i2c_scl         <= 1'b1;
                if (bitcount == 8'd60)
                    i2c_sda_t   <= 1'b0; //トリガー
                if (bitcount == 8'd0) begin
                    state       <= STATE_I2C_BITS;
                    i2c_scl     <= 1'b0; //次立ち上がった時からslave側はbyteを取り込める
                    bitcount    <= 8'd120;
                end else
                    bitcount <= bitcount - 1;
            end
            STATE_I2C_BITS:
            begin
                if (bitcount == 8'd90) begin //次の立ち上がりに合わせてデータを送っとく
                    if (i2c_data[8:8] == 1'b0)
                        i2c_sda_t <= 1'b0;
                    else
                        i2c_sda_t <= 1'b1;
                end
                
                if (bitcount == 8'd60) begin //slaveがデータを読み取り，dataをシフト
                    i2c_scl     <= 1'b1;
                    i2c_data    <= {i2c_data[7:0], i2c_sda_i};
                end
                
                if (bitcount == 8'd0) begin
                    i2c_scl <= 1'b0;
                    if (i2c_bits_left == 4'd0) begin
//                        i2c_scl <= 1'b0;
                        ack_flag    <= ~i2c_data[0:0];
                        state       <= STATE_RUN;
                        pcnext      <= pcnext + 1;
                    end else
                        i2c_bits_left <= i2c_bits_left - 1;
                    bitcount <= 8'd120;
                end else
                    bitcount <= bitcount - 1;
            end
            STATE_I2C_STOP:
            begin
                i2c_started <= 1'b0;
                if (bitcount == 8'd90)
                    i2c_sda_t <= 1'b0;
                
                if (bitcount == 8'd60)
                    i2c_scl <= 1'b1;
                
                if (bitcount == 8'd30) //sclがhigh中にsdaをhighにする
                    i2c_sda_t <= 1'b1;
                
                if (bitcount == 8'd0) begin
                    state   <= STATE_RUN;
                    pcnext  <= pcnext + 1;
                end else
                    bitcount <= bitcount - 1;
            end
            STATE_DELAY:
            begin
                if (bitcount == 8'd0) begin
                    if (delay == 16'd0) begin
                        pcnext <= pcnext + 1;
                        state  <= STATE_RUN;
                    end else begin
                        delay <= delay - 1;
                        bitcount <= 8'd119;
                    end
                end else
                    bitcount <= bitcount - 1;
            end
            STATE_RUN:
            begin
                if(skip == 1'b1) begin
                    skip    <= 1'b0;
                    pcnext  <= pcnext + 1;
                end else begin
                    case(opcode)
                    OPCODE_JUMP:
                    begin
                        skip    <= 1'b0;
                        pcnext  <= {inst_data[7:0], 3'b000};
                    end
                    OPCODE_I2C_WRITE:
                    begin
                        i2c_data        <= {inst_data[7:0], 1'b1};
                        bitcount        <= 8'd120;
                        i2c_bits_left   <= 4'b1000;
                        if (i2c_started == 1'b0)
                            state <= STATE_I2C_START;
                        else
                            state <= STATE_I2C_BITS;
                    end
                    OPCODE_SKIPCLEAR:
                    begin
                        skip    <= 1'b0;
//                        pcnext  <= pcnext + 1;
                    end
                    OPCODE_DELAY:
                    begin
                        state       <= STATE_DELAY;
                        bitcount    <= 8'd120;
                        case (inst_data[3:0])
                        4'b0000: delay <= 16'h0001;
                        4'b0001: delay <= 16'h0002;
                        4'b0010: delay <= 16'h0004;
                        4'b0011: delay <= 16'h0008;
                        4'b0100: delay <= 16'h0010;
                        4'b0101: delay <= 16'h0020;
                        4'b0110: delay <= 16'h0040;
                        4'b0111: delay <= 16'h0080;
                        4'b1000: delay <= 16'h0100;
                        4'b1001: delay <= 16'h0200;
                        4'b1010: delay <= 16'h0400;
                        4'b1011: delay <= 16'h0800;
                        4'b1100: delay <= 16'h1000;
                        4'b1101: delay <= 16'h2000;
                        4'b1110: delay <= 16'h4000;
//                        default: delay <= 16'h0001;
                        default: delay <= 16'h8000;
                        endcase
                    end
                    OPCODE_I2C_STOP:
                    begin
                        bitcount    <= 8'd120;
                        state       <= STATE_I2C_STOP;
                    end
                    default:
                    begin
                        state   <= STATE_RUN;
                        pcnext  <= 10'd0;
                        skip    <= 1'b1;
                    end
                    endcase
                end
            end
            default:
            begin
                state   <= STATE_RUN;
                pcnext  <= 10'd0;
                skip    <= 1'b1;
            end
            endcase
        end
    end
    
    
endmodule
