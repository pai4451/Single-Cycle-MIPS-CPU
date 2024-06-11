// Module: ALUControl
// Description: This module generates the control signals for the ALU based on the 
//              ALUOp and FuncCode inputs. It is responsible for selecting the 
//              appropriate ALU operation.
// Inputs:
//    - ALUOp: ALU operation control signal (2-bit)
//    - FuncCode: Function code from the instruction (6-bit)
// Outputs:
//    - ALUCtl: ALU control signal (4-bit)

module ALUControl (
    input wire [1:0] ALUOp,       // ALU operation control signal
    input wire [5:0] FuncCode,    // Function code from the instruction
    output reg [3:0] ALUCtl       // ALU control signal
);

// Always block to generate ALU control signals based on ALUOp and FuncCode
always @(*) 
begin
    if (ALUOp == 2'b00)
        ALUCtl = 4'b0010;       // LW and SW use add (ALUOp = 00)
    else if (ALUOp == 2'b01)
        ALUCtl = 4'b0110;       // Branch use subtract (ALUOp = 01)
    else
    begin
        // R-type instructions (ALUOp = 10)
        case (FuncCode)
            6'b100000: ALUCtl = 4'b0010; // add
            6'b100010: ALUCtl = 4'b0110; // subtract
            6'b100100: ALUCtl = 4'b0000; // and
            6'b100101: ALUCtl = 4'b0001; // or
            6'b100111: ALUCtl = 4'b1100; // nor
            6'b101010: ALUCtl = 4'b0111; // slt
            default:   ALUCtl = 4'b1111; // should not happen (default case)
        endcase
    end
end

endmodule
