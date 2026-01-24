`timescale 1ns/1ps

module tb_register_file;
    logic                  clk;
    logic                  rst;
    logic                  i_we;
    logic [ADDR_WIDTH-1:0] i_addr;
    logic [DATA_WIDTH-1:0] i_data;
    logic [DATA_WIDTH-1:0] o_data;

    parameter ADDR_WIDTH = 5;      // 32 Registers
    parameter DATA_WIDTH = 32;     // 32-bit wide data

    // Instantiate the Device Under Test (DUT)
    register_file_single_port  
    #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut
    (
        .clk    ( clk    ),
        .rst    ( rst    ),
        .i_we   ( i_we   ),
        .i_addr ( i_addr ),
        .i_data ( i_data ),
        .o_data ( o_data )
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk    = 0;
        rst    = 0;
        i_we   = 0;
        i_addr = 0;
        i_data = 0;

        // Reset sequence
        #15 rst = 1;
        
        for (int i=0; i<32; i++) begin
            @ (posedge clk);
            i_we = 1;
            i_addr = i;
            i_data = i+1;
        end

        i_we = 0;
        for (int i=0; i<32; i++) begin
            @ (posedge clk);
            i_addr = i;
            @ (posedge clk);
            assert(o_data == (i+1));
        end

        #1000 $display("Simulation finished.");
        $finish;
    end

    initial begin
        // Setup for Waveform dumping
        $dumpfile("out/waveform.vcd");
        $dumpvars(0, tb_register_file);
    end

    initial begin
        #1000 $display("Simulation finished.");
        $finish;
    end
endmodule