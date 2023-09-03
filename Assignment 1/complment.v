`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 14:31:07
// Design Name: 
// Module Name: complment
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


module complement(
input wire[5:0] in, // Our main input
output wire[5:0] z, // Our main output
output wire Overflow, // Overflow Flag
output wire carry_out // Carry flag

    );
   
    // Create a 6-bit 0 vector
   
    wire[5:0] zero = 6'b0;
   
    
    // Take our input away from the zero vector, giving us 2s complement
    sixbit_rippleadder takeaway(.x(zero),.y(in),.sel(1),.overflow(Overflow),.c_out(carry_out),.sum(z));
    
    
endmodule
