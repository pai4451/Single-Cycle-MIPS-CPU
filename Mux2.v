// Module: Mux2
// Description: This module selects between two input values based on the ALUSrc signal.
//              It is used to determine the second operand for the ALU in the MIPS CPU.
// Inputs:
//    - ALUSrc: ALU source select signal
//    - ReadData2: Data read from the second register (32-bit)
//    - Extend32: Sign-extended immediate value (32-bit)
// Outputs:
//    - ALU_B: Selected second operand for the ALU (32-bit)

module Mux2 (
    input wire ALUSrc,           // ALU source select signal
    input wire [31:0] ReadData2, // Data read from the second register
    input wire [31:0] Extend32,  // Sign-extended immediate value
    output reg [31:0] ALU_B      // Selected second operand for the ALU
);

// Always block to select the second operand for the ALU based on ALUSrc
always @(*) 
begin
    case (ALUSrc)
        0: ALU_B <= ReadData2;    // Select ReadData2 if ALUSrc is 0
        1: ALU_B <= Extend32;     // Select Extend32 if ALUSrc is 1
    endcase
end

endmodule
