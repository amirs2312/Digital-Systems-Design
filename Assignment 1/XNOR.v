`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 15:18:32
// Design Name: 
// Module Name: XNOR
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


module XNOR(
input wire[5:0] A,B, // Our two main inputs
output wire[5:0] z,  // Main output
output wire overflow,// Overflow flag
output wire c_out // Carry flag

    );
    
    // Bitwise XNOR of A and B
    assign z[0] = ~(A[0]^B[0]);
    assign z[1] = ~(A[1]^B[1]);
    assign z[2] = ~(A[2]^B[2]);
    assign z[3] = ~(A[3]^B[3]);
    assign z[4] = ~(A[4]^B[4]);
    assign z[5] = ~(A[5]^B[5]);
    
    // These parameters are irrelevant to this module, ie there is no need to raise these flags
    assign overflow = 0;
    assign c_out = 0;
    
 
    
   
endmodule
