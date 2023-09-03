`timescale 1ns / 1ps

module Pattern_Detector(
input  in_bit,
input  clk,
input  reset,
input sh_en,
output reg[11:0] seq_counter, // keeps count of the specific sequence occurrences
output reg detect, // Outputs high when we've detected our pattern
output reg [11:0] shift_reg // Purely for showing on the LEDS where we are in the state machine
    );

 // Define states
   reg [3:0] current_state, next_state;
   reg[21:0] cycle_count;
   
   
   // We don't use this anywhere, it's just for reference
   localparam code = 12'b111111111010;

// State encoding
   localparam IDLE = 4'b0000;
   localparam S1 = 4'b0001;
   localparam S2 = 4'b0010;
   localparam S3 = 4'b0011;
   localparam S4 = 4'b0100;
   localparam S5 = 4'b0101;
   localparam S6 = 4'b0110;
   localparam S7 = 4'b0111;
   localparam S8 = 4'b1000;
   localparam S9 = 4'b1001;
   localparam S10 = 4'b1010;
   localparam S11 = 4'b1011;
   
   localparam DETECTED = 4'b1100;


    // Initialize
    initial begin
        shift_reg <= 0;
        seq_counter <= 0;
        detect <= 0;
        cycle_count <= 0;
    end

    // State transition logic
    // Synchronous reset
    always @(posedge clk) begin
    
    if(reset || cycle_count == 4194303) begin // Re initialise upon looping in the LSFR or the reset signal going HIGH
            current_state <= IDLE;
           
            seq_counter  <= 0;
            shift_reg <= 0;
        end else begin
            current_state <= next_state;
        end
    if(~reset && sh_en) // Otherwise check if shifting is enabled. Enter the FSM.
    begin
        case (current_state)
            IDLE: begin
                next_state = in_bit ? S1 : IDLE;
                shift_reg <= 12'b000000000000;
                detect <= 0;
            end
            S1: begin
                next_state = in_bit ? S2 : IDLE;
                shift_reg <= 12'b100000000000;
                detect <= 0;
            end
            S2: begin
                next_state = in_bit ? S3 : IDLE;
                 shift_reg <= 12'b110000000000;
            end
            S3: begin
                next_state = in_bit ? S4 : IDLE;
                 shift_reg <= 12'b111000000000;
            end
            S4: begin
                next_state = in_bit ? S5 : IDLE;
                 shift_reg <= 12'b111100000000;
            end
            S5: begin
                next_state = in_bit ? S6 : IDLE;
                shift_reg <= 12'b111110000000;
            end
            S6: begin
                next_state = in_bit ? S7 : IDLE;
                 shift_reg <= 12'b111111000000;
            end
            S7: begin
                next_state = in_bit ? S8 : IDLE;
                 shift_reg <= 12'b111111100000;
            end
            S8: begin
                next_state = in_bit ? S9 : IDLE;
                 shift_reg <= 12'b111111110000;
            end
            S9: begin 
                // Very important, the one of three states that transitions to something other than IDLE
                // Detect, or S1. The pattern can still be found as we will still have a string of only ones.
                next_state = in_bit ? S9 : S10; 
                 shift_reg <= 12'b111111111000;
            end
            S10: begin
                next_state = in_bit ? S11 : IDLE;
                 shift_reg <= 12'b111111111000;
            end
            S11: begin
                next_state = in_bit ? S2 : DETECTED; // Sneaky, I forgot this transition to S2 and I missed 1 out of 1024 patterns
                 shift_reg <= 12'b111111111010;
            end
            DETECTED: begin // The state which sets our output high and increments our counter
                next_state = in_bit ? S1 : IDLE;
                 shift_reg <= 12'b111111111010;
                 detect <= 1;
                 seq_counter = seq_counter + 1;
            end
        endcase
        cycle_count = cycle_count + 1; // To keep count when to reset
    end
   end

    // Shift register and sequence counter updates
    // Output determined by state alone (Moore)
 
    

    
   

endmodule