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

// Initial block to load the memory with instructions
initial 
begin
    Mem[0] = 'h00221820;   // add: R3, R1, R2  
    Mem[1] = 'hAC010000;   // sw: R1, 0(R0)
    Mem[2] = 'h8C240000;   // lw R4, 0(R1)
    Mem[3] = 'h10210001;   // beq R1, R1, +8 (Branch taken)
    Mem[4] = 'h00001820;   // add R3, R0, R0 (Skipped because of branch taken)
    Mem[5] = 'h00411822;   // sub R3, R2, R1  
end

// Always block triggered by any change in the address
always @(*)
begin
    inst = Mem[address[31:2]];    // Fetch the instruction at the given address
end

endmodule
