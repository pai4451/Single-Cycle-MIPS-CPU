// Module: DataMemory
// Description: This module represents the data memory for the MIPS CPU. It supports 
//              reading and writing of 32-bit data at specified addresses.
// Inputs:
//    - clock: Clock signal
//    - address: Address for the memory operation (32-bit)
//    - MemWrite: Memory write enable signal
//    - MemRead: Memory read enable signal
//    - WriteData: Data to be written to memory (32-bit)
// Outputs:
//    - ReadData: Data read from memory (32-bit)

module DataMemory (
    input wire clock,            // Clock signal
    input wire [31:0] address,   // Address for the memory operation (32-bit)
    input wire MemWrite,         // Memory write enable signal
    input wire MemRead,          // Memory read enable signal
    input wire [31:0] WriteData, // Data to be written to memory
    output wire [31:0] ReadData  // Data read from memory
);

reg [31:0] Mem [0:127];          // Memory array with 128 entries, each 32 bits

// Assign the output data from the memory array
assign ReadData = Mem[address[8:2]];

// Always block triggered on the rising edge of the clock
always @ (posedge clock)
begin
    if (MemWrite && !MemRead)
    begin
        // Write data to memory if MemWrite is enabled and MemRead is disabled
        Mem[address[8:2]] <= WriteData;
    end
end

endmodule
