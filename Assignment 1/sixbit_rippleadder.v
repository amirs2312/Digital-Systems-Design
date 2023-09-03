`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2023 05:33:34
// Design Name: 
// Module Name: sixbit_rippleadder
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


module sixbit_rippleadder(

// Wire names given in Lab shheet
input wire[5:0] x,y,
input wire sel,
output wire overflow,
output wire c_out,
output wire[5:0] sum

    );
    // Array storing the cin values
    wire[5:0] c;
    assign c[0] = sel;
    
    FullAdder bit0 (.a(x[0]),.b(y[0]^sel),.cin(c[0]),.s(sum[0]),.cout(c[1]));
    
    FullAdder bit1 (.a(x[1]),.b(y[1]^sel),.cin(c[1]),.s(sum[1]),.cout(c[2]));
    
    FullAdder bit2 (.a(x[2]),.b(y[2]^sel),.cin(c[2]),.s(sum[2]),.cout(c[3]));
    
    FullAdder bit3 (.a(x[3]),.b(y[3]^sel),.cin(c[3]),.s(sum[3]),.cout(c[4]));
    
    FullAdder bit4 (.a(x[4]),.b(y[4]^sel),.cin(c[4]),.s(sum[4]),.cout(c[5]));
    
    FullAdder bit5 (.a(x[5]),.b(y[5]^sel),.cin(c[5]),.s(sum[5]),.cout(c_out));
    
    // Detects if the sign bit has changed
    assign overflow = c[5] ^ c_out;
    
    
endmodule
