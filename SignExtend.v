// Module: SignExtend
// Description: This module extends a 16-bit immediate value to a 32-bit signed value.
// Inputs:
//    - inst15_0: 16-bit input value (typically an immediate value from an instruction)
// Outputs:
//    - Extend32: 32-bit signed extended output value

module SignExtend (
    input wire [15:0] inst15_0,    // 16-bit input immediate value
    output reg [31:0] Extend32     // 32-bit signed extended output value
);

// Always block to perform sign extension
always @(*) 
begin
    // Extend the 16-bit input to 32 bits by sign-extending the most significant bit
    Extend32 <= { {16{inst15_0[15]}}, inst15_0 };
end

endmodule
