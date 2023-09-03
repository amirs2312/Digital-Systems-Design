`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 15:40:18
// Design Name: 
// Module Name: Copy
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


module Copy(
// This module is quite redundant, but it makes the schematic look better I guess

input wire[5:0] x, // Our main input
output wire[5:0] z, // Our main output
output wire overflow,// Overflow flag
output wire c_out // Carry flag

    );
    
    // Quite literally just copy x to z
    assign z[0] = x[0];
     assign z[1] = x[1];
      assign z[2] = x[2];
       assign z[3] = x[3];
        assign z[4] = x[4];
         assign z[5] = x[5];
         // I like the diagnoal pattern
         
         // These flags aren't relevant
         assign c_out = 0;
         assign overflow = 0;
endmodule
