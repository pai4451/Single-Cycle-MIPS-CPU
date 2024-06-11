// Module: Mux4
// Description: This module selects between the current PC value and the branch target address
//              based on the output of the AND gate. It is used to determine the next PC value
//              in the MIPS CPU.
// Inputs:
//    - PCout: Current PC value (32-bit)
//    - Add_ALUOut: Branch target address (32-bit)
//    - AndGateOut: Branch control signal (output of the AND gate)
// Outputs:
//    - PCin: Selected next PC value (32-bit)

module Mux4 (
    input wire [31:0] PCout,       // Current PC value
    input wire [31:0] Add_ALUOut,  // Branch target address
    input wire AndGateOut,         // Branch control signal
    output reg [31:0] PCin         // Selected next PC value
);

// Initialize PCin to 0
initial
begin
    PCin = 0;
end

// Always block to select the next PC value based on AndGateOut
always @(*) 
begin
    case (AndGateOut)
        0: PCin = PCout;        // Select PCout if AndGateOut is 0
        1: PCin = Add_ALUOut;   // Select Add_ALUOut if AndGateOut is 1
    endcase
end

endmodule
