// Module: Add_ALU
// Description: This module performs addition of the PC value and the shifted value.
//              It is typically used in the MIPS CPU for calculating branch target addresses.
// Inputs:
//    - PCout: Current value of the program counter (32-bit)
//    - ShiftOut: Shifted value (32-bit), usually the result of a shift left operation
// Outputs:
//    - Add_ALUOut: Result of the addition (32-bit)

module Add_ALU (
    input wire [31:0] PCout,       // Current value of the program counter
    input wire [31:0] ShiftOut,    // Shifted value
    output reg [31:0] Add_ALUOut   // Result of the addition
);

// Always block to perform the addition
always @(*) 
begin
    Add_ALUOut = PCout + ShiftOut; // Add PCout and ShiftOut
end

endmodule
