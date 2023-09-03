`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 16:09:10
// Design Name: 
// Module Name: Pad
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


module Pad(
input wire[5:0] x,// Input to be padded
output wire[7:0] z// Paddded input sent out

    );
    
    // Copy the input over and add 2 0s to the front (or back depending on how you look at it) of the number
     assign z[0] = x[0];
     assign z[1] = x[1];
      assign z[2] = x[2];
       assign z[3] = x[3];
        assign z[4] = x[4];
         assign z[5] = x[5];
          assign z[6] = 0;
           assign z[7] = 0;
endmodule
