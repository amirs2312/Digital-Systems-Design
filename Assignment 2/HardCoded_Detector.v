`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2023 00:30:10
// Design Name: 
// Module Name: HardCoded_Detector
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


module HardCoded_Detector(
input  in_bit, // The lastest bit shifted off of the LSFR
input  clk,
input  reset,
input sh_en,
output reg[21:0] seq_counter, // keeps count of the specific sequence occurrences
output reg detect,// Goes High when we see the pattern.
output reg [11:0] shift_reg // A vector that holds the last 12 bits shifted off of the LSFR

    );
    
     reg[21:0] cycle_count; // Keeps track of how many cycles have passed, ie how many times we've shifted.
     
        initial begin
        shift_reg <= 0;
        seq_counter <= 0;
        detect <= 0;
        cycle_count <= 0;
    end
   
   
   // We don't use this anywhere, it's just for reference
   localparam code = 12'b111111111010;
   
   always @ (posedge clk) begin // Synchronous Reset
   if (reset || cycle_count == 4194303) begin // Upon reset or looping in the LSFR sequence, re intialise
        shift_reg <= 0;
        seq_counter <= 0;
        detect <= 0;
        cycle_count <= 0;
   end
   else begin
   if(sh_en) begin
      shift_reg <= {shift_reg[10:0],in_bit}; // Make room for the new in_bit 
      if(shift_reg == code) begin // Check if the shift_reg is our code
      seq_counter <= seq_counter + 1;
      detect <= 1;
      end
      else begin
      detect <= 0;
      end
      cycle_count <= cycle_count + 1;
   end
   
   end
   end
endmodule
