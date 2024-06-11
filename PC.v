// Module: PC (Program Counter)
// Description: This module represents the program counter (PC) which holds
//              the address of the next instruction to be executed.
// Inputs:
//    - clock: Clock signal
//    - reset: Reset signal (active low)
//    - PCin:  Input value for the PC (32-bit)
// Outputs:
//    - PCout: Output value of the PC (32-bit)

module PC (
    input wire clock,            // Clock signal
    input wire reset,            // Reset signal (active low)
    input wire [31:0] PCin,      // Input value for the PC
    output reg [31:0] PCout      // Output value of the PC
);

// Always block triggered on the rising edge of the clock or falling edge of the reset
always @(posedge clock or negedge reset)  
  begin
    if (!reset) 
        PCout <= 0;             // On reset, set PCout to 0
    else 
        PCout <= PCin;          // Otherwise, update PCout with PCin
  end
  
endmodule
