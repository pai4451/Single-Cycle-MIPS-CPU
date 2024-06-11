// Module: RegFile (Register File)
// Description: This module represents the register file in the MIPS CPU, which
//              contains 32 registers. It provides the ability to read from two registers
//              and write to one register.
// Inputs:
//    - clock: Clock signal
//    - RegWrite: Register write enable signal
//    - reset: Reset signal (active low)
//    - ReadReg1: Address of the first register to read (5-bit)
//    - ReadReg2: Address of the second register to read (5-bit)
//    - WriteReg: Address of the register to write (5-bit)
//    - WriteData: Data to write to the register (32-bit)
// Outputs:
//    - ReadData1: Data read from the first register (32-bit)
//    - ReadData2: Data read from the second register (32-bit)

module RegFile(
    input wire clock,             // Clock signal
    input wire RegWrite,          // Register write enable signal
    input wire reset,             // Reset signal (active low)
    input wire [4:0] ReadReg1,    // Address of the first register to read
    input wire [4:0] ReadReg2,    // Address of the second register to read
    input wire [4:0] WriteReg,    // Address of the register to write
    input wire [31:0] WriteData,  // Data to write to the register
    output wire [31:0] ReadData1, // Data read from the first register
    output wire [31:0] ReadData2  // Data read from the second register
);

reg [31:0] reg_mem [0:31];        // Memory array to hold register values

// Assign the output data from the register file
assign ReadData1 = reg_mem[ReadReg1];  // Read data from the first register
assign ReadData2 = reg_mem[ReadReg2];  // Read data from the second register

// Always block triggered on the rising edge of the clock or falling edge of the reset
always @(posedge clock or negedge reset) 
begin
    if (!reset)
    begin
        // Initialize registers on reset
        reg_mem[0] <= 0;       // Register $0
        reg_mem[1] <= 8;       // Register R1
        reg_mem[2] <= 20;      // Register R2
    end
    else if (RegWrite)
    begin
        // Write data to the specified register if RegWrite is enabled
        reg_mem[WriteReg] <= WriteData;
    end
end  

endmodule
