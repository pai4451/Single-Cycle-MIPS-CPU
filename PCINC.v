// Module: PCINC (Program Counter Incrementer)
// Description: This module increments the program counter (PC) by 4, which
//              is typically the size of one instruction in the MIPS architecture.
// Inputs:
//    - PCout1: Current value of the program counter (32-bit)
// Outputs:
//    - PCoutinc: Incremented value of the program counter (32-bit)

module PCINC (
   input wire [31:0] PCout1,     // Current PC value
   output reg [31:0] PCoutinc    // Incremented PC value
);
   
// Always block triggered by any change in the input signals
always @(*)
begin
    PCoutinc = PCout1 + 4;       // Increment the PC by 4
end

endmodule
