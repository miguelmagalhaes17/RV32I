`timescale 1ns/1ps

module register_file_tb;
    logic                   clk;
    logic                   rst;
    logic                   i_we;         // Write Enable
    logic [ADDR_WIDTH-1:0]  i_wr_address; // Write Address
    logic [DATA_WIDTH-1:0]  i_wr_data;    // Write Data
    
    logic [ADDR_WIDTH-1:0]  i_rd_addr_1;  // Read Address 1
    logic [DATA_WIDTH-1:0]  o_rd_data_1;  // Read Data    1

    logic [ADDR_WIDTH-1:0]  i_rd_addr_2;  // Read Address 2
    logic [DATA_WIDTH-1:0]  o_rd_data_2;  // Read Data    2

    parameter ADDR_WIDTH = 5;             // 32 Registers
    parameter DATA_WIDTH = 32;            // 32-bit wide data

    // Instantiate the Device Under Test (DUT)
    register_file
    #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut
    (
        .clk            ( clk          ),
        .rst            ( rst          ),
        .i_we           ( i_we         ),
        .i_wr_address   ( i_wr_address ),
        .i_wr_data      ( i_wr_data    ),
        .i_rd_addr_1    ( i_rd_addr_1  ),
        .o_rd_data_1    ( o_rd_data_1  ),
        .i_rd_addr_2    ( i_rd_addr_2  ),
        .o_rd_data_2    ( o_rd_data_2  )
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk          = 0;
        rst          = 0;
        i_we         = 0;
        i_wr_address = 0;
        i_wr_data    = 0;
        i_rd_addr_1  = 0;
        i_rd_addr_2  = 0;

        // Reset sequence
        #15 rst = 1;
        
        for (int i=0; i<32; i++) begin
            @ (posedge clk);
            i_we = 1;
            i_wr_address = i;
            i_wr_data    = i+1;
        end

        i_we = 0;
        for (int i=0; i<32; i = i+2) begin
            @ (posedge clk);
            i_rd_addr_1 = i;
            i_rd_addr_2 = i+1;
            #1
            if(i_rd_addr_1 == 0) assert(o_rd_data_2 == 0);
            else                 assert(o_rd_data_1 == (i+1));
            if(i_rd_addr_2 == 0) assert(o_rd_data_2 == 0);
            else                 assert(o_rd_data_2 == (i+2));
        end

        #1000 $display("Simulation finished.");
        $finish;
    end

    initial begin
        // Setup for Waveform dumping
        $dumpfile("out/waveform.vcd");
        $dumpvars(0, register_file_tb);
    end

    initial begin
        #1000 $display("Simulation finished.");
        $finish;
    end
endmodule