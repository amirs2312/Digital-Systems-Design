`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2023 15:30:56
// Design Name: 
// Module Name: ALU
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





module ALU(
input wire[5:0] IA, IB, // Our Inputs from the switches
input wire[2:0] func, // Dtermines what function to enact on the 
output reg[5:0] Output,
output reg OF, // Indicates Overflow for relevant 
output reg carry_out // Indicates a carry needed
    );
    
    wire[5:0] A_Out; // Output A
    wire[5:0] B_Out; // Output B
    wire[5:0] ComplementA_Out; // Output -A
    wire[5:0] ComplementB_Out; // Output -B
    wire[5:0] eightbitGT_Out; // Output HIGH if A !>= B
    wire[5:0] APLUSB_Out; // Output A + B
    wire[5:0] AMINUSB_Out; // Output A - B
    wire[5:0] AXNORB_Out; // Output A XNOR B

    
    wire[7:0] Overflows; // Contains the overflow value from each module above
    wire[7:0] carries; // Contains the carry value from each module above
    wire[7:0] tempcompareA; // A copy of A is placed here with two extra 0s so that it can be passed into the 8-bit comparator
    wire[7:0] tempcompareB; // A copy of B is placed here with two extra 0s so that it can be passed into the 8-bit comparator
    
    
    // Call every module to get the values of the above wires
    Copy F0(.x(IA),.z(A_Out),.overflow(Overflows[0]),.c_out(carries[0]));
    
    Copy F1(.x(IB),.z(B_Out),.overflow(Overflows[1]),.c_out(carries[1]));
    
    complement F2(.in(IA),.z(ComplementA_Out),.Overflow(Overflows[2]),.carry_out(carries[2]));
    
    complement F3(.in(IB),.z(ComplementB_Out),.Overflow(Overflows[3]),.carry_out(carries[3]));
    
    Pad P1(.x(IA),.z(tempcompareA));
    
    Pad P2(.x(IB),.z(tempcompareB));
    
    eightbitGTE F4(.A(tempcompareA),.B(tempcompareB),.GTE(eightbitGT_Out),.overflow(Overflows[4]),.c_out(carries[4]));
    
    XNOR F5(.A(IA),.B(IB),.z(AXNORB_Out),.overflow(Overflows[5]),.c_out(carries[5]));
    
    sixbit_rippleadder F6(.x(IA), .y(IB),.sel(0),.overflow(Overflows[6]),.c_out(carries[6]),.sum(APLUSB_Out));
    
    sixbit_rippleadder F7(.x(IA), .y(IB),.sel(1),.overflow(Overflows[7]),.c_out(carries[7]),.sum(AMINUSB_Out));
    
    
   
    // Depending on the value of func the corresponding module output will be copied to the ALU output
    always @(*) begin
    case(func)
    3'b000: begin
             Output = A_Out;
             carry_out = carries[0];
             OF = Overflows[0];
            end
    3'b001:begin
             Output = B_Out;
             carry_out = carries[1];
             OF = Overflows[1];
            end
    3'b010: begin
             Output = ComplementA_Out;
             carry_out = carries[2];
             OF = Overflows[2];
            end
    3'b011: begin
             Output = ComplementB_Out;
             carry_out = carries[3];
             OF = Overflows[3];
            end
    3'b100:begin
             Output = eightbitGT_Out;
             carry_out = carries[4];
             OF = Overflows[4];
            end
    3'b101: begin
             Output = AXNORB_Out;
             carry_out = carries[5];
             OF = Overflows[5];
            end
    3'b110: begin
             Output = APLUSB_Out;
             carry_out = carries[6];
             OF = Overflows[6];
            end
    3'b111: begin
             Output = AMINUSB_Out;
             carry_out = carries[7];
             OF = Overflows[7];
            end
     
    endcase
  end
    
    
    
endmodule
