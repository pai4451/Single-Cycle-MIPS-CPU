// Module: MipsCPU
// Description: This is the top module for a single-cycle MIPS CPU. It connects all the
//              submodules including the PC, instruction memory, data memory, ALU, control
//              unit, and various multiplexers to implement the single-cycle MIPS CPU.
// Inputs:
//    - clock: Clock signal
//    - reset: Reset signal

module MipsCPU(
    input wire clock,            // Clock signal
    input wire reset             // Reset signal
);

// Internal wires for connecting the modules
wire [31:0] PCin_S, PCout_S;
wire [31:0] PCoutinc_S;
wire [31:0] inst_S;
wire RegDst_S, RegWrite_S, ALUSrc_S, MemtoReg_S, MemRead_S, MemWrite_S, Branch_S;
wire [1:0] ALUOp_S;
wire [4:0] WriteReg_S;
wire [31:0] ReadData1_S, ReadData2_S;
wire [31:0] WriteData_Reg_S;  // Data to be written to the register file
wire [31:0] Extend32_S;
wire [31:0] ALU_B_S;
wire [31:0] ShiftOut_S;
wire [3:0] ALUCtl_S;
wire Zero_S;
wire [31:0] ALUOut_S;
wire [31:0] Add_ALUOut_S;
wire AndGateOut_S;
wire [31:0] ReadData_S;

// Connection of PC
PC pc_0(
    .clock(clock),
    .reset(reset),
    .PCin(PCin_S),
    .PCout(PCout_S)
);

// Connection of PCINC
PCINC pc_adder(
    .PCout1(PCout_S),
    .PCoutinc(PCoutinc_S)
);

// Connection of InstMem
InstMem instmem_0(
    .address(PCout_S),
    .inst(inst_S)
);

// Connection of MainControl
MainControl main_control_0(
    .Opcode(inst_S[31:26]),
    .RegDst(RegDst_S),
    .RegWrite(RegWrite_S),
    .ALUSrc(ALUSrc_S),
    .MemtoReg(MemtoReg_S),
    .MemRead(MemRead_S),
    .MemWrite(MemWrite_S),
    .Branch(Branch_S),
    .ALUOp(ALUOp_S)
);

// Connection of Mux1
Mux1 mux1_0(
    .inst20_16(inst_S[20:16]),
    .inst15_11(inst_S[15:11]),
    .RegDst(RegDst_S),
    .WriteReg(WriteReg_S)
);

// Connection of RegFile
RegFile regfile_0(
    .clock(clock),
    .reset(reset),
    .ReadReg1(inst_S[25:21]),
    .ReadReg2(inst_S[20:16]),
    .RegWrite(RegWrite_S),
    .WriteReg(WriteReg_S),
    .WriteData(WriteData_Reg_S),
    .ReadData1(ReadData1_S),
    .ReadData2(ReadData2_S)
);

// Connection of SignExtend
SignExtend sign_extend_0(
    .inst15_0(inst_S[15:0]),
    .Extend32(Extend32_S)
);

// Connection of Mux2
Mux2 mux2_0(
    .ALUSrc(ALUSrc_S),
    .ReadData2(ReadData2_S),
    .Extend32(Extend32_S),
    .ALU_B(ALU_B_S)
);

// Connection of ShiftLeft2
ShiftLeft2 shift_left2_0(
    .ShiftIn(Extend32_S),
    .ShiftOut(ShiftOut_S)
);

// Connection of ALUControl
ALUControl alu_control_0(
    .ALUOp(ALUOp_S),
    .FuncCode(inst_S[5:0]),
    .ALUCtl(ALUCtl_S)
);

// Connection of ALU
ALU alu_0(
    .A(ReadData1_S),
    .B(ALU_B_S),
    .ALUCtl(ALUCtl_S),
    .ALUOut(ALUOut_S),
    .Zero(Zero_S)
);

// Connection of Add_ALU
Add_ALU add_alu_0(
    .PCout(PCoutinc_S),
    .ShiftOut(ShiftOut_S),
    .Add_ALUOut(Add_ALUOut_S)
);

// Connection of AndGate
AndGate and_gate_0(
    .Branch(Branch_S),
    .Zero(Zero_S),
    .AndGateOut(AndGateOut_S)
);

// Connection of Mux4
Mux4 mux4_0(
    .PCout(PCoutinc_S),
    .Add_ALUOut(Add_ALUOut_S),
    .AndGateOut(AndGateOut_S),
    .PCin(PCin_S)
);

// Connection of DataMemory
DataMemory data_memory_0(
    .clock(clock),
    .reset(reset),
    .address(ALUOut_S[6:0]),
    .MemWrite(MemWrite_S),
    .MemRead(MemRead_S),
    .WriteData(ReadData2_S),
    .ReadData(ReadData_S)
);

// Connection of Mux3
Mux3 mux3_0(
    .MemtoReg(MemtoReg_S),
    .ReadData(ReadData_S),
    .ALUOut(ALUOut_S),
    .WriteData_Reg(WriteData_Reg_S)
);

endmodule
