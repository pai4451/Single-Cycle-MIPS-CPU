// Module: Mux3
// Description: This module selects between two input values based on the MemtoReg signal.
//              It is used to determine the data to be written back to the register file
//              in the MIPS CPU.
// Inputs:
//    - ReadData: Data read from memory (32-bit)
//    - ALUOut: Result from the ALU (32-bit)
//    - MemtoReg: Memory to register select signal
// Outputs:
//    - WriteData_Reg: Selected data to be written to the register file (32-bit)

module Mux3 (
    input wire [31:0] ReadData,    // Data read from memory
    input wire [31:0] ALUOut,      // Result from the ALU
    input wire MemtoReg,           // Memory to register select signal
    output reg [31:0] WriteData_Reg // Selected data to be written to the register file
);

// Always block to select the data to write back to the register file based on MemtoReg
always @(*) 
begin
    case (MemtoReg)
        0: WriteData_Reg = ALUOut;  // Select ALUOut if MemtoReg is 0
        1: WriteData_Reg = ReadData; // Select ReadData if MemtoReg is 1
    endcase
end

endmodule
