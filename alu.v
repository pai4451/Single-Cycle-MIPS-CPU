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

// Define ALU control signal values for better readability
parameter AND = 4'b0000;
parameter OR  = 4'b0001;
parameter ADD = 4'b0010;
parameter SUB = 4'b0110;
parameter SLT = 4'b0111;
parameter NOR = 4'b1100;

// Always block to compute ALU operation based on ALUCtl
always @(*) begin
    ALUOut = 32'b0; // Initialize ALUOut to avoid latch inference
    case (ALUCtl)
        AND: ALUOut = A & B;        // AND operation
        OR:  ALUOut = A | B;        // OR operation
        ADD: ALUOut = A + B;        // Addition
        SUB: ALUOut = A - B;        // Subtraction
        SLT: ALUOut = (A < B) ? 1 : 0;  // Set on less than
        NOR: ALUOut = ~(A | B);     // NOR operation
        default: ALUOut = 32'b0;    // Default case
    endcase
end

endmodule
