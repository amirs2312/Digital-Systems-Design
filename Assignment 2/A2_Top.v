`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2023 12:07:41
// Design Name: 
// Module Name: A2_Top
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


module A2_Top(
input reset,
input CCLK, // Basys boards clock
input sh_en,// Shift wnable, like a pause switch
input  wire[4:0] button_input, // Input from the basys board buttons
output wire[6:0] led_out, // The segments of the 7seg display
output wire[3:0] anode_sel, // The different digits
output wire[11:0] sr, // State/Shift register. What we showcase on the board LEDs
output wire max_tick_reg // Indicate we've completed a full cycle


    );
    
    wire clk; // This clock is fed into the LSFR and pattern detector. It is controlled by frequency.
    reg[31:0] frequency; // The clockscale that we divide into the inbuilt 100MHz clock on the basys-3 board
    wire[21:0] q; // The output of the LSFR
    wire[4:0] buttons;// The buttons on the board, used for controlling the clock speed of the lsfr and detector
    wire pattern;// A bit that indicates whether or not the pattern was found 
    wire[11:0] seq_count; // Indicates the current count of how many times we've seen the code appear

    // Initially setting up the clock to have a period of 1s
    initial begin
    frequency <=  50000000;
    end
    
    
    
    
    
    
    debouncer bounce(.clk(CCLK),.reset(reset),.button_in(button_input),.button_out(buttons)); // Stop button bouncing
    
    clock c1(.CCLK(CCLK),.clkscale(frequency),.clk(clk)); // clkscale chosen to have a 1Hz cycle time by  
    
    lsfr myLSFR(.clk(clk),.sh_en(sh_en),.rst_n(reset),.Q_out(q),.max_tick_reg(max_tick_reg));
    
    Pattern_Detector FSM_Based_Detector(.in_bit(q[21]),.clk(clk),.reset(reset),.sh_en(sh_en),.seq_counter(seq_count),.detect(pattern),.shift_reg(sr));
    
    seven_segment_controller  seglights(.clk(CCLK),.reset(reset),.p_count(seq_count),.anode_select(anode_sel),.LED_out(led_out));
    
    
    always @(posedge CCLK) begin
    if (reset) begin
        frequency <= 50000000;
    end else if (buttons[2] || buttons[1]) begin
        frequency <= frequency << 1;
    end else if (buttons[3] || buttons[0]) begin
        frequency <= frequency >> 1;
    end else if (buttons[4]) begin 
        frequency <= 50000000;
    end  
        

end
    
    
    
endmodule
