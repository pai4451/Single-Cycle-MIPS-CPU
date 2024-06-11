// Module: MainControl
// Description: This module generates the control signals for the MIPS CPU based on the
//              Opcode from the instruction. It determines the operation type and sets
//              the control signals accordingly.
// Inputs:
//    - Opcode: Opcode from the instruction (6-bit)
// Outputs:
//    - RegDst: Register destination signal
//    - RegWrite: Register write enable signal
//    - ALUSrc: ALU source signal
//    - MemtoReg: Memory to register signal
//    - MemRead: Memory read enable signal
//    - MemWrite: Memory write enable signal
//    - Branch: Branch control signal
//    - ALUOp: ALU operation control signal (2-bit)

module MainControl (
    input wire [5:0] Opcode,      // Opcode from the instruction
    output reg RegDst,            // Register destination signal
    output reg RegWrite,          // Register write enable signal
    output reg ALUSrc,            // ALU source signal
    output reg MemtoReg,          // Memory to register signal
    output reg MemRead,           // Memory read enable signal
    output reg MemWrite,          // Memory write enable signal
    output reg Branch,            // Branch control signal
    output reg [1:0] ALUOp        // ALU operation control signal
);

// Always block to generate control signals based on the Opcode
always @(*)
begin
    // Default values for control signals
    RegDst = 0;
    ALUSrc = 0;
    MemtoReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    ALUOp = 2'b00;

    // Generate control signals based on the Opcode
    case (Opcode)
        6'b000000: begin
            // R-Type instructions
            RegDst = 1;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
        end
        6'b100011: begin
            // lw (load word)
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
        6'b101011: begin
            // sw (store word)
            RegDst = 0;
            ALUSrc = 1;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00;
        end
        6'b000100: begin
            // beq (branch if equal)
            RegDst = 0;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01;
        end
        default: begin
            // Default case for unsupported instructions
            RegDst = 0;
            ALUSrc = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
        end
    endcase
end

endmodule
