`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2023 00:33:50
// Design Name: 
// Module Name: lsfr
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

// Edited lsfr from labF intended for width of size 22
module lsfr

#(parameter seed = 22'b1101100100011100111101)
//#(parameter seed = 22') // Forbidden Seed
 ( input clk, sh_en, rst_n,
 output [21:0] Q_out,
 output reg max_tick_reg);
 

 
 
 // State of LSFR
 reg [21:0] Q_state;
 
 // Keeps count of how many cycles have passed, ie when we'll start repeating values
 reg [21:0] counter;
 
 // Next State of LSFR
 wire [21:0] Q_ns;
 
 // Stores the XORed bits result for putting back into the first bit after shifting
 wire Q_fb;
 
 
 
 
 always @ (posedge clk) begin // synchronous
 if (rst_n) // Reset signal resets paramters shockingly enough
 begin
 Q_state <= seed;
 max_tick_reg <= 0;
 counter <= 0;
 end 
 else if (sh_en) // Making sure that shifitng is enabled ie we're not paused.
 begin
 Q_state <= Q_ns;
 counter <= counter + 1;
 if(counter == 4194303) // After this we start repeating, ie max ticks has been reached.
 begin
 max_tick_reg <= 1;
 end
 else
 begin
 max_tick_reg <= 0;
 end
 end
 end

 //next state logic
 assign Q_fb = ~(Q_state[21] ^ Q_state[20]); // These are the optimal taps to XOR for the new first bit
 assign Q_ns = {Q_state[20:0],Q_fb}; // Moving over the LSFR by one shifitng out the msb
 //output logic
 assign Q_out = Q_state;
 
 
endmodule

