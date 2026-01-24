`timescale 1ns/1ps

module tb_rv32;
    reg clk;
    reg rst_n;
    reg d;
    wire q;

    // Instantiate the Device Under Test (DUT)
    flip_flop dut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Setup for Waveform dumping
        $dumpfile("out/waveform.vcd");
        $dumpvars(0, tb_rv32);

        // Initialize signals
        clk = 0;
        rst_n = 0;
        d = 0;

        // Reset sequence
        #15 rst_n = 1;
        
        // Stimulus
        #10 d = 1;
        #10 d = 0;
        #10 d = 1;
        #20;

    end

    initial begin
        #1000 $display("Simulation finished.");
        $finish;
    end
endmodule