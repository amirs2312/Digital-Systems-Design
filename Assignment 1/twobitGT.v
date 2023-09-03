module twobitGT(

input wire A1, A0, B1, B0,
output wire gt// High if A > B

    );
    
    // Derived from a truth table
    wire w1;
    assign w1 = A1 & ~B1;
    
    wire w2;
    assign w2 = A0 & ~B0;
    
    wire w3;
    assign w3 = A1 + ~B1;
    
    wire w4;
    assign w4 = w3 & w2;
    
    assign gt = w1 + w4;
    
   endmodule
    