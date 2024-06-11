// Module: ALU (Arithmetic Logic Unit)
// Description: This module performs arithmetic and logical operations based on the
//              control signal provided. It supports operations like AND, OR, addition,
//              subtraction, and comparison for less than.
// Inputs:
//    - ALUCtl: ALU control signal (4-bit) determining the operation
//    - A: First operand (32-bit)
//    - B: Second operand (32-bit)
// Outputs:
//    - ALUOut: Result of the ALU operation (32-bit)
//    - Zero: Zero flag, set to 1 if ALUOut is 0

module ALU (
    input wire [3:0] ALUCtl,      // ALU control signal
    input wire [31:0] A,          // First operand
    input wire [31:0] B,          // Second operand
    output reg [31:0] ALUOut,     // Result of the ALU operation
    output wire Zero              // Zero flag
);

// Assign Zero to 1 if ALUOut is 0, otherwise 0
assign Zero = (ALUOut == 0);

// Always block to compute ALU operation based on ALUCtl
always @(*)
begin
    case (ALUCtl)
        0: ALUOut = A & B;        // AND operation
        1: ALUOut = A | B;        // OR operation
        2: ALUOut = A + B;        // Addition
        6: ALUOut = A - B;        // Subtraction
        7: ALUOut = (A < B) ? 1 : 0;  // Set on less than
        12: ALUOut = ~(A | B);    // NOR operation
        default: ALUOut = 0;      // Default case
    endcase
end

endmodule
