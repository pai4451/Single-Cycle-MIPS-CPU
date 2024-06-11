// Module: ShiftLeft2
// Description: This module shifts the input value left by 2 bits. It is typically used
//              in the MIPS CPU to calculate branch target addresses.
// Inputs:
//    - ShiftIn: 32-bit input value to be shifted
// Outputs:
//    - ShiftOut: 32-bit output value after shifting left by 2 bits

module ShiftLeft2 (
    input wire [31:0] ShiftIn,     // 32-bit input value
    output reg [31:0] ShiftOut     // 32-bit output value after shifting left by 2 bits
);

// Always block to perform the shift left operation
always @(*) 
begin
    ShiftOut = ShiftIn << 2;       // Shift the input value left by 2 bits
end 

endmodule
