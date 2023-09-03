
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 15:02:27
// Design Name: 
// Module Name: eightbitGTE
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


module eightbitGTE(

// Slightly edited from Lab B, we will check if A is greater than or equal to B. If it is output LOW.
input wire[7:0] A,
input wire[7:0] B,
output wire[5:0] GTE, // This doesn't need to be a 6 bit vector, but I just wanted to light more than 1 LED
output wire overflow,// Overflow flag
output wire c_out // Carry flag

    );

  
  
  // wire gn reprents bits 2n and 2n + 1 being greater in A than in B  
  wire g0, g1, g2, g3;
  
  twobitGT bit1 (.A1(A[1]),.A0(A[0]),.B1(B[1]),.B0(B[0]),.gt(g0));
  twobitGT bit3 (.A1(A[3]),.A0(A[2]),.B1(B[3]),.B0(B[3]),.gt(g1));
  twobitGT bit5 (.A1(A[5]),.A0(A[4]),.B1(B[5]),.B0(B[4]),.gt(g2));
  twobitGT bit7 (.A1(A[7]),.A0(A[6]),.B1(B[7]),.B0(B[6]),.gt(g3));
  
  // wire en represents bits 2n and 2n + 1 being equal to A in B
  wire e0, e1, e2, e3;  
  
  eq2 ebit1 (.a(A[1:0]),.b(B[1:0]),.aeqb(e0));
  eq2 ebit3 (.a(A[3:2]),.b(B[3:2]),.aeqb(e1));
  eq2 ebit5 (.a(A[5:4]),.b(B[5:4]),.aeqb(e2));
  eq2 ebit7 (.a(A[7:6]),.b(B[7:6]),.aeqb(e3));
  
  // Wires labelled w will be added t
  wire q2, w1, w2, w0, q0, q1;
  
  
  // What this mess of wires is essentially doing is saying that only let the next two bits effect the output if all the pairs of bits
  // before it are equal, ie bits 0 and 1 are only checked if and only if bits 2,3,4 .... n-1, and n  are equal. 
  //This ripples through the entire circuit.
  assign w2 = g2 & e3; // w2 will be added to the output IF the previous bits were equal
  assign q0 = e2 & e3; // q0 will be passed down to determine whether or not w1 gets added to the final output
  assign w1 = g1 & q0; // w1 will be added to final output only if q0 is true
  assign q1 = e1 & q0; // q1 will be passed down to determine whether or not w0 gets added to the final output
  assign q2 = q1 & e0; // This gets passed down to the output that A and B are equal
  assign w0 = g0 & q1; // w1 will be added to final output only if q1 is true
  
  wire temp;
  assign temp = g3 | w2 | w1 | q2 | w0; // Then penultimate output determined by addition
  

  
  wire check;
  assign check = ~(A[5]^B[5]);  // Determines whether we should consider the comparators output
  
  wire signdiff;
  assign signdiff = (A[5]) & (~B[5]); // Determines whether theres a sign difference and how that effects the output
  
  wire[5:0] compout;
  assign compout = (~temp) & check;
  
  wire finalout;
  assign finalout = compout | signdiff;
  
  assign GTE[0] = finalout;
  assign GTE[1] = finalout;
  assign GTE[2] = finalout;
  assign GTE[3] = finalout;
  assign GTE[4] = finalout;
  assign GTE[5] = finalout;
  
  
  
  // Flags irrelavent to this module
  assign overflow = 0;
  assign c_out = 0;
  
          
  
  
  
  
  // This logic is in place since my initial 8 bit comparator didn't accoutn for negative numbers
  
  
  
  /*always @(*) begin
  
  
 
  // A => 0   B <= 0
   if(A[5] == 0 && B[5] == 1)
  begin
   GTE[0] <= 0;
   GTE[1] <= 0;
   GTE[2] <= 0;
   GTE[3] <= 0;
   GTE[4] <= 0;
   GTE[5] <= 0;
  end
  // A <= 0  B >= 0
  else if (A[5] == 1 && B[5] == 0)
   begin
   GTE[0] <= 1;
   GTE[1] <= 1;
   GTE[2] <= 1;
   GTE[3] <= 1;
   GTE[4] <= 1;
   GTE[5] <= 0;
   end
   // Both two positive and two negative numbers use the same logic for output
  else 
  begin
   GTE[0] <= ~temp;
   GTE[1] <= ~temp;
   GTE[2] <= ~temp;
   GTE[3] <= ~temp;
   GTE[4] <= ~temp;
   GTE[5] <= 0;
   end
  end*/
  
  

  
  
  
endmodule
