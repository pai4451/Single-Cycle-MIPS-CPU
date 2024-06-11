// Module: MIPSCPU_TB (Testbench for MIPS CPU)
// Description: This module is a testbench for simulating the single-cycle MIPS CPU. It
//              provides clock and reset signals and initializes the simulation.
// Inputs: None (all signals are generated internally)
// Outputs: None (all outputs are observed through waveforms)

module MIPSCPU_TB ();
    reg CLK;      // Clock signal
    reg RST;      // Reset signal
    parameter Period = 20;  // Clock period in time units

    // Initial block to generate the clock signal
    initial 
    begin
        // Generate clock signal
        CLK = 1'b0;  // Initialize clock signal to 0
        forever #(Period / 2) CLK = ~CLK;  // Toggle clock signal every half period
    end

    // Initial block to initialize and apply reset
    initial 
    begin
        // Initialize and apply reset
        RST = 1'b1;  // Initialize reset signal to 1 (reset not asserted)
        #(Period / 2);   // Wait for one clock period
        RST = 1'b0;  // Assert reset signal (active low)
        #(Period / 2);   // Wait for one clock period
        RST = 1'b1;  // Release reset signal (deassert)
    end

    // Initial block to save waveform and run simulation
    initial 
    begin
        // Save waveform
        $dumpfile("wave.vcd");       
        $dumpvars; 

        // Run the simulation for a specified number of clock periods
        #(8 * Period);

        // Stop the simulation
        $stop;
    end

    // Instantiate the MipsCPU module (Device Under Test)
    MipsCPU DUT (
        .clock (CLK),
        .reset (RST)
    );

endmodule
