// Module: AndGate
// Description: This module performs a logical AND operation on the Branch and Zero signals.
//              It is typically used in the MIPS CPU to determine if a branch should be taken.
// Inputs:
//    - Branch: Branch control signal
//    - Zero: Zero flag from the ALU
// Outputs:
//    - AndGateOut: Result of the AND operation (1 if both inputs are 1, otherwise 0)

module AndGate (
    input wire Branch,            // Branch control signal
    input wire Zero,              // Zero flag from the ALU
    output reg AndGateOut         // Result of the AND operation
);

// Always block to perform the AND operation
always @(*) 
begin
    AndGateOut = Branch && Zero;  // Perform logical AND on Branch and Zero
end

endmodule
