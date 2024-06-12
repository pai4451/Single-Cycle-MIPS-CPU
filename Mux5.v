// Module: Mux5
// Description: This module selects between the output of Mux4 and the jump target address
//              based on the Jump control signal. It is used to determine the next PC value
//              in the MIPS CPU.
// Inputs:
//    - PCin: Output from Mux4 (32-bit)
//    - JumpTarget: Calculated jump target address (32-bit)
//    - Jump: Jump control signal
// Outputs:
//    - PCout: Selected next PC value (32-bit)

module Mux5 (
    input wire [31:0] PCin,         // Output from Mux4
    input wire [31:0] JumpTarget,   // Calculated jump target address
    input wire Jump,                // Jump control signal
    output reg [31:0] PCout         // Selected next PC value
);

// Initialize PCout to 0
initial
begin
    PCout = 0;
end

// Always block to select the next PC value based on Jump control signal
always @(*) 
begin
    if (Jump)
        PCout = JumpTarget;
    else
        PCout = PCin;
end

endmodule