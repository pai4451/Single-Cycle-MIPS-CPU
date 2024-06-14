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
wire [31:0] pc_next, pc_current;
wire [31:0] pc_incremented;
wire [31:0] instruction;
wire reg_dst, reg_write, alu_src, mem_to_reg, mem_read, mem_write, branch, jump;
wire [1:0] alu_op;
wire [4:0] write_reg;
wire [31:0] reg_read_data1, reg_read_data2;
wire [31:0] reg_write_data;
wire [31:0] sign_extended_imm;
wire [31:0] alu_operand_b;
wire [31:0] shifted_imm;
wire [3:0] alu_ctrl_signal;
wire alu_zero;
wire [31:0] alu_result;
wire [31:0] branch_target;
wire branch_and_zero;
wire [31:0] mem_read_data;
wire [31:0] jump_target;
wire [31:0] mux4_out;

// Connection of PC
PC pc_0(
    .clock(clock),
    .reset(reset),
    .PCin(pc_next),
    .PCout(pc_current)
);

// Connection of PCINC
PCINC pc_adder(
    .PCin(pc_current),
    .PCout(pc_incremented)
);

// Connection of InstMem
InstMem instmem_0(
    .address(pc_current),
    .inst(instruction)
);

// Connection of MainControl
MainControl main_control_0(
    .Opcode(instruction[31:26]),
    .RegDst(reg_dst),
    .RegWrite(reg_write),
    .ALUSrc(alu_src),
    .MemtoReg(mem_to_reg),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .Branch(branch),
    .Jump(jump),
    .ALUOp(alu_op)
);

// Connection of Mux1
Mux1 mux1_0(
    .inst20_16(instruction[20:16]),
    .inst15_11(instruction[15:11]),
    .RegDst(reg_dst),
    .WriteReg(write_reg)
);

// Connection of RegFile
RegFile regfile_0(
    .clock(clock),
    .ReadReg1(instruction[25:21]),
    .ReadReg2(instruction[20:16]),
    .RegWrite(reg_write),
    .WriteReg(write_reg),
    .WriteData(reg_write_data),
    .ReadData1(reg_read_data1),
    .ReadData2(reg_read_data2)
);

// Connection of SignExtend
SignExtend sign_extend_0(
    .inst15_0(instruction[15:0]),
    .Extend32(sign_extended_imm)
);

// Connection of Mux2
Mux2 mux2_0(
    .ALUSrc(alu_src),
    .ReadData2(reg_read_data2),
    .Extend32(sign_extended_imm),
    .ALU_B(alu_operand_b)
);

// Connection of ShiftLeft2
ShiftLeft2 shift_left2_0(
    .ShiftIn(sign_extended_imm),
    .ShiftOut(shifted_imm)
);

// Connection of ALUControl
ALUControl alu_control_0(
    .ALUOp(alu_op),
    .FuncCode(instruction[5:0]),
    .ALUCtl(alu_ctrl_signal)
);

// Connection of ALU
ALU alu_0(
    .A(reg_read_data1),
    .B(alu_operand_b),
    .ALUCtl(alu_ctrl_signal),
    .ALUOut(alu_result),
    .Zero(alu_zero)
);

// Connection of Add_ALU
Add_ALU add_alu_0(
    .PCout(pc_incremented),
    .ShiftOut(shifted_imm),
    .Add_ALUOut(branch_target)
);

// Connection of AndGate
AndGate and_gate_0(
    .Branch(branch),
    .Zero(alu_zero),
    .AndGateOut(branch_and_zero)
);

// Connection of Mux4
Mux4 mux4_0(
    .PCout(pc_incremented),
    .Add_ALUOut(branch_target),
    .AndGateOut(branch_and_zero),
    .PCin(mux4_out)
);

// Calculate jump target address
assign jump_target = {pc_incremented[31:28], instruction[25:0], 2'b00};

// Connection of Mux5
Mux5 mux5_0(
    .PCin(mux4_out),
    .JumpTarget(jump_target),
    .Jump(jump),
    .PCout(pc_next)
);

// Connection of DataMemory
DataMemory data_memory_0(
    .clock(clock),
    .address(alu_result),
    .MemWrite(mem_write),
    .MemRead(mem_read),
    .WriteData(reg_read_data2),
    .ReadData(mem_read_data)
);

// Connection of Mux3
Mux3 mux3_0(
    .MemtoReg(mem_to_reg),
    .ReadData(mem_read_data),
    .ALUOut(alu_result),
    .WriteData_Reg(reg_write_data)
);

endmodule
