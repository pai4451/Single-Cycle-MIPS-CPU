// Module: MIPSCPU_TB (Testbench for MIPS CPU)
// Description: This module is a testbench for simulating the single-cycle MIPS CPU. It
//              provides clock and reset signals and initializes the simulation.
// Inputs: None (all signals are generated internally)
// Outputs: None (all outputs are observed through waveforms)

`timescale 1ps/1ps

module tb();

reg clk, rst_;

initial begin
    clk <= 0;
    forever #10 clk = ~clk;
end

initial begin
    rst_ <= 0;
    repeat (3) @(posedge clk);
    @(negedge clk);
    rst_ = 1;
end


MipsCPU cpu( clk, rst_);

initial #1000 $finish;

/* initial values to store in memory */
initial begin
     //data, startaddr, endaddr
    $readmemh("instructions_2.txt", cpu.instmem_0.Mem); 
    $readmemh("register_file_2.txt", cpu.regfile_0.reg_mem);
    $readmemh("data_memory_2.txt", cpu.data_memory_0.Mem);
end

/* check instruction idx[0]: ADD */
initial begin
    //repeat (3) @(posedge clk);  
    //rst done
    @(posedge clk);  
    //instruction: ADD done (operate at begining, not controlled by reset)
    @(posedge clk);
    #1; //can check RegFile *add delay*
    $writememh("CHECK_RegFile_for_inst0_add.txt", cpu.regfile_0.reg_mem);
end

/* check instruction idx[1]: SW */
initial begin
    repeat (3) @(posedge clk);  
    //rst done
    @(posedge clk);  
    //instruction: SW done
    @(posedge clk);
    #1; //can check DMem *add delay*
    $writememh("CHECK_DMem_for_inst1_sw.txt", cpu.data_memory_0.Mem, 0, 127);
                                        //top_CPU.data_mem.RAM
end

/* check instruction idx[2]: LW */
initial begin
    repeat (3) @(posedge clk);  
    //rst done
    repeat (2) @(posedge clk);  
    //instruction: LW done
    @(posedge clk);
    #1; //can check RegFile *add delay*
    $writememh("CHECK_RegFile_for_inst2_lw.txt", cpu.regfile_0.reg_mem);
end


/* check instruction idx[5]: SUB */
initial begin
    repeat (3) @(posedge clk);  
    //rst done
    repeat (4) @(posedge clk);  
    //instruction: SUB done 
    @(posedge clk);
    
    #1; //can check RegFile *add delay*
    $writememh("CHECK_RegFile_for_inst5_sub.txt", cpu.regfile_0.reg_mem);
end


/* check instruction idx[4]: ADD */
initial begin
    repeat (3) @(posedge clk);  
    //rst done
    repeat (6) @(posedge clk);  
    //instruction: ADD done 
    @(posedge clk);
    
    #1; //can check RegFile *add delay*
    $writememh("CHECK_RegFile_for_inst4_add.txt", cpu.regfile_0.reg_mem);
end



initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
    //$fsdbDumpMDA();
end

endmodule 