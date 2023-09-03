`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2023 15:21:04
// Design Name: 
// Module Name: BIGTestBench
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


module BIGTestBench();
reg  [5:0] test_in0, test_in1;
reg  [2:0] test_func;
wire [5:0] test_out;
wire test_c_out;
wire test_overflow;



 ALU uut
      (.IA(test_in0), .IB(test_in1),.func(test_func),.Output(test_out),.carry_out(test_c_out),.OF(test_overflow));
      
       

   //  test vector generator
   initial
   begin
      // We'll change this on every run
      test_func = 3'b100;
      
      
      // Board test vector 
      test_in0 = 6'b011001;
      test_in1 = 6'b000000;
      # 200;
      // test vector 2 A>B
      test_in0 = 6'b011101;
      test_in1 = 6'b000011;
      # 200;
       // test vector 3 B>A
      test_in0 = 6'b000011;
      test_in1 = 6'b001001;
      # 200;
       // test vector 4 A = B
      test_in0 = 6'b011001;
      test_in1 = 6'b011001;
      # 200;
        // test vector 5 A = 0 B > 0
      test_in0 = 6'b000000;
      test_in1 = 6'b010000;
      # 200;
        // test vector 6 A < 0 B > 0
      test_in0 = 6'b111111;
      test_in1 = 6'b001000;
      # 200;
        // test vector 7 A > 0, B = 0
      test_in0 = 6'b000100;
      test_in1 = 6'b000000;
      # 200;
        // test vector 8 B>A
      test_in0 = 6'b011000;
      test_in1 = 6'b111110;
      # 200;
        // test vector 9 A = B = 0
      test_in0 = 6'b000000;
      test_in1 = 6'b000000;
      # 200;
        // test vector 10 A = B < 0
      test_in0 = 6'b100001;
      test_in1 = 6'b100001;
      # 200;
        // test vector 11 A = 0  B < 0
      test_in0 = 6'b000000;
      test_in1 = 6'b111100;
      # 200;
        // test vector 12 A < 0  B = 0
      test_in0 = 6'b111000;
      test_in1 = 6'b000000;
      # 200;
        // test vector 13 A < 0 B < 0, A < B
      test_in0 = 6'b100110;
      test_in1 = 6'b111111;
      # 200;
       // test vector 14 A < 0 B < 0, A > B
      test_in0 = 6'b111111;
      test_in1 = 6'b111100;
      # 200;
      // test vector 15 Underflow
      test_in0 = 6'b100000;
      test_in1 = 6'b111111;
      # 200;
      // test vector 16 Overflow
      test_in0 = 6'b011111;
      test_in1 = 6'b011100;
      # 200;
      // test vector 17 Carry
      test_in0 = 6'b111111;
      test_in1 = 6'b111111;
      # 200;
     
      
      // stop simulation
      $stop;
   end

    
    
    
endmodule
