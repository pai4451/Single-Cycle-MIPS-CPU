// Module: MIPSCPU_TB (Testbench for MIPS CPU)
// Description: This module is a testbench for simulating the single-cycle MIPS CPU. It
//              provides clock and reset signals and initializes the simulation.
// Inputs: None (all signals are generated internally)
// Outputs: None (all outputs are observed through waveforms)

module MIPSCPU_TB ();
    reg CLK;      // Clock signal
    reg RST;      // Reset signal
    parameter Period = 20;  // Clock period in time units

    // Initial block to run the simulation
    initial 
    begin
        // Save waveform
        $dumpfile("MIPS.vcd");       
        $dumpvars; 

        // Initialization
        initialize();

        // Reset
        resett();

        // Run the simulation for a specified number of clock periods
        #(6 * Period);

        // Stop the simulation
        $stop;
    end    

    // Task to initialize signals
    task initialize;
    begin
        CLK = 1'b0;  // Initialize clock signal to 0
        RST = 1'b1;  // Initialize reset signal to 1
    end
    endtask

    // Task to reset the CPU
    task resett;
    begin
        RST = 1'b1;    // Set reset signal to 1
        #(Period);
        RST = 1'b0;    // Set reset signal to 0
        #(Period);
        RST = 1'b1;    // Set reset signal to 1 again
    end
    endtask  

    // Always block to generate the clock signal
    always #(Period / 2) CLK = ~CLK;

    // Instantiate the MipsCPU module (Device Under Test)
    MipsCPU DUT (
        .clock (CLK),
        .reset (RST)
    );

endmodule