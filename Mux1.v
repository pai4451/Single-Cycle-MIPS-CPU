// Module: Mux1
// Description: This module selects between two input registers based on the RegDst signal.
//              It is used to determine the destination register for the write-back stage in the MIPS CPU.
// Inputs:
//    - inst20_16: Bits [20:16] from the instruction (5-bit)
//    - inst15_11: Bits [15:11] from the instruction (5-bit)
//    - RegDst: Register destination select signal
// Outputs:
//    - WriteReg: Selected register for writing (5-bit)

module Mux1 (
    input wire [4:0] inst20_16,  // Bits [20:16] from the instruction
    input wire [4:0] inst15_11,  // Bits [15:11] from the instruction
    input wire RegDst,           // Register destination select signal
    output reg [4:0] WriteReg    // Selected register for writing
);

// Always block to select the destination register based on RegDst
always @(*) begin
    case (RegDst)
        0 : WriteReg <= inst20_16;  // Select inst20_16 if RegDst is 0
        1 : WriteReg <= inst15_11;  // Select inst15_11 if RegDst is 1
    endcase
end

endmodule
