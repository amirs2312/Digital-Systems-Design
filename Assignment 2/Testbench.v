`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2023 01:04:58
// Design Name: 
// Module Name: Testbench
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


module Testbench(

    );
    
    reg clk, reset;
    wire[21:0] q;
    reg sh_en;
    wire max_tick_reg;
    wire pattern;
    wire[21:0] pattern_count;
    wire[11:0] shift_reg;
    wire[3:0] anode_sel;
    wire[6:0] led_out;
    
    wire patternHC;
    wire[21:0] pattern_countHC;
    wire[11:0] shift_regHC;
    
 
    
    
    // LSFR instantiations
    lsfr shifty(.clk(clk),.sh_en(sh_en),.rst_n(reset),.Q_out(q),.max_tick_reg(max_tick_reg));

    // FSM detector instantiation instantiation
    Pattern_Detector FSM(.in_bit(q[21]),.clk(clk),.reset(reset),.sh_en(sh_en),.seq_counter(pattern_count),.detect(pattern),.shift_reg(shift_reg));

    // Seglights instantiation
    seven_segment_controller  seglights(.clk(clk),.reset(reset),.p_count(pattern_count),.anode_select(anode_sel),.LED_out(led_out));
    
    HardCoded_Detector coolerfunction(.in_bit(q[21]),.clk(clk),.reset(reset),.sh_en(sh_en),.seq_counter(pattern_countHC),.detect(patternHC),.shift_reg(shift_regHC));
    
    
   
    // Sets Clock signal
    initial begin
    clk = 1; 
    forever 
    #10 clk = ~clk; // Every 10ns, invert clk to give it a 20ns period.
    end
    
   
    // Different reset and shift enable times for testing
    
    
    initial begin
    reset = 1;
    sh_en = 1;
    //#10  reset = ~reset;
    #200 reset = ~reset;
    #400 sh_en = ~sh_en;
    #600 sh_en = ~sh_en;
    //#600 reset = ~reset;
    //#700 reset = ~reset;
    //#81920 reset = ~reset;
    //#81940 reset = ~reset;    
    end
    
    
    
    
    // Finish after this time, this is a few hundred nanoseconds after 2 to power 22 cycles
    initial begin
        #83886480;
        $finish;
    end
endmodule

