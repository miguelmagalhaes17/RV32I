`timescale 1ns/1ps

module rv32_tb;
    reg clk;
    reg rst;


    // Instantiate the Device Under Test (DUT)
    rv32 dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;

        // Reset sequence
        #15 rst = 1;
        
    end

    initial begin
        #1000 $display("Simulation finished.");
        $finish;
    end

    initial begin
        // Setup for Waveform dumping
        $dumpfile("out/waveform.vcd");
        $dumpvars(0, rv32_tb);
    end
endmodule