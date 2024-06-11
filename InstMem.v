// Module: InstMem (Instruction Memory)
// Description: This module represents the instruction memory, which stores the
//              instructions to be executed by the MIPS CPU. It outputs the instruction
//              located at the given address.
// Inputs:
//    - address: Address of the instruction to fetch (32-bit)
// Outputs:
//    - inst: Fetched instruction (32-bit)

module InstMem(
    input wire [31:0] address,    // Address of the instruction to fetch
    output reg [31:0] inst        // Fetched instruction
);
    
reg [31:0] Mem [0:127];           // Memory array to hold instructions

// Always block triggered by any change in the address
always @(*)
begin
    inst = Mem[address[8:2]];    // Fetch the instruction at the given address
end

endmodule
