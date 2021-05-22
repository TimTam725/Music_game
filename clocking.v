`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/28 15:53:38
// Design Name: 
// Module Name: clocking
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


module clocking(
    input   SYSCLK,
    output  CLK48
    );
    
    wire CLKFBOUT, iPCK, locked;
//    IBUFG IBUFG(.I(CLK100), .O(SYSCLK));
    BUFG iBUFG (.I(iPCK), .O(CLK48));

    MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),  // Jitter programming (OPTIMIZED, HIGH, LOW)       0k
      .CLKFBOUT_MULT_F(48.0),   // ??M(2.000-64.000) here                           49.500
      .CLKFBOUT_PHASE(0.0),     // ???(-360.000-360.000)                            ok
      .CLKIN1_PERIOD(8.0),      // CLKIN?????                                       10.0
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(1),
      .CLKOUT2_DIVIDE(1),
      .CLKOUT3_DIVIDE(1),
      .CLKOUT4_DIVIDE(1),
      .CLKOUT5_DIVIDE(1),
      .CLKOUT6_DIVIDE(1),
      .CLKOUT0_DIVIDE_F(20.0),  // ????Q(1.000-128.000) here                        20.625
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5), // ?f???[?e?B??                                     ok
      .CLKOUT1_DUTY_CYCLE(0.5),
      .CLKOUT2_DUTY_CYCLE(0.5),
      .CLKOUT3_DUTY_CYCLE(0.5),
      .CLKOUT4_DUTY_CYCLE(0.5),
      .CLKOUT5_DUTY_CYCLE(0.5),
      .CLKOUT6_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),                                                             //ok
      .CLKOUT1_PHASE(0.0),
      .CLKOUT2_PHASE(0.0),
      .CLKOUT3_PHASE(0.0),
      .CLKOUT4_PHASE(0.0),
      .CLKOUT5_PHASE(0.0),
      .CLKOUT6_PHASE(0.0),
      .CLKOUT4_CASCADE("FALSE"), // Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
      .DIVCLK_DIVIDE(5),         // ????D(1-106) here                                 ok
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).        0.01
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)   ok
    )
    MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(iPCK),     // 1-bit output: CLKOUT0
      .CLKOUT0B(),   // 1-bit output: Inverted CLKOUT0      ok «
      .CLKOUT1(),     // 1-bit output: CLKOUT1
      .CLKOUT1B(),   // 1-bit output: Inverted CLKOUT1
      .CLKOUT2(),     // 1-bit output: CLKOUT2
      .CLKOUT2B(),   // 1-bit output: Inverted CLKOUT2
      .CLKOUT3(),     // 1-bit output: CLKOUT3
      .CLKOUT3B(),   // 1-bit output: Inverted CLKOUT3
      .CLKOUT4(),     // 1-bit output: CLKOUT4
      .CLKOUT5(),     // 1-bit output: CLKOUT5
      .CLKOUT6(),     // 1-bit output: CLKOUT6
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(CLKFBOUT),   // 1-bit output: Feedback clock
      .CLKFBOUTB(), // 1-bit output: Inverted CLKFBOUT                      ok
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(locked),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(SYSCLK),       // 1-bit input: Clock                          ok?
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(1'b0),       // 1-bit input: Power-down
      .RST(1'b0),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(CLKFBOUT)      // 1-bit input: Feedback clock                ok
    );
    
//    BUFR bufr_clk(.O(clk_out),I(clk_in));
   
endmodule

// mmcm_adv_inst : MMCME2_ADV
//  generic map
//   (BANDWIDTH            => "OPTIMIZED",
//    CLKOUT4_CASCADE      => FALSE,
//    --COMPENSATION         => "ZHOLD",
//    --COMPENSATION         => "BUF_IN",
//    COMPENSATION         => "INTERNAL", nai
//    STARTUP_WAIT         => FALSE,
//    DIVCLK_DIVIDE        => 5,
//    CLKFBOUT_MULT_F      => 49.500,
//    CLKFBOUT_PHASE       => 0.000,
//    CLKFBOUT_USE_FINE_PS => FALSE,      nai
//    CLKOUT0_DIVIDE_F     => 20.625,
//    CLKOUT0_PHASE        => 0.000,
//    CLKOUT0_DUTY_CYCLE   => 0.500,
//    CLKOUT0_USE_FINE_PS  => FALSE,      nai
//    CLKIN1_PERIOD        => 10.000,
//    REF_JITTER1          => 0.010)
//  port map
//    -- Output clocks
//   (CLKFBOUT            => clk_feedback,
//    CLKFBOUTB           => open,
//    CLKOUT0             => zed_audio_clk_48M,
//    CLKOUT0B            => open,
//    CLKOUT1             => open,
//    CLKOUT1B            => open,
//    CLKOUT2             => open,
//    CLKOUT2B            => open,
//    CLKOUT3             => open,
//    CLKOUT3B            => open,
//    CLKOUT4             => open,
//    CLKOUT5             => open,
//    CLKOUT6             => open,
//    -- Input clock control
//    CLKFBIN             => clk_feedback,
//    CLKIN1              => clkin1,
//    CLKIN2              => '0',
//    -- Tied to always select the primary input clock
//    CLKINSEL            => '1',                   nai
//    -- Ports for dynamic reconfiguration
//    DADDR               => (others => '0'),
//    DCLK                => '0',
//    DEN                 => '0',
//    DI                  => (others => '0'),
//    DO                  => open,
//    DRDY                => open,
//    DWE                 => '0',
//    -- Ports for dynamic phase shift
//    PSCLK               => '0',
//    PSEN                => '0',
//    PSINCDEC            => '0',
//    PSDONE              => open,
//    -- Other control and status signals
//    LOCKED              => LOCKED,
//    CLKINSTOPPED        => open,
//    CLKFBSTOPPED        => open,
//    PWRDWN              => '0',
//    RST                 => RESET);

//  -- Output buffering
