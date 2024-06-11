// Module: PCINC (Program Counter Incrementer)
// Description: This module increments the program counter (PC) by 4, which
//              is typically the size of one instruction in the MIPS architecture.
// Inputs:
//    - PCin: Current value of the program counter (32-bit)
// Outputs:
//    - PCout: Incremented value of the program counter (32-bit)

module PCINC (
    input wire [31:0] PCin,      // Current PC value
    output wire [31:0] PCout     // Incremented PC value
);
   
// Assign statement for combinational logic
assign PCout = PCin + 4;        // Increment the PC by 4

endmodule
