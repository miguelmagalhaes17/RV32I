`timescale 1ns/1ps

module register_file_single_port #(
    parameter ADDR_WIDTH = 5,      // 32 Registers
    parameter DATA_WIDTH = 32      // 32-bit wide data
)(
    input  logic                   clk,
    input  logic                   rst,
    input  logic                   i_we,    // Write Enable
    input  logic [ADDR_WIDTH-1:0]  i_addr,  // Register Address
    input  logic [DATA_WIDTH-1:0]  i_data,  // Data Input
    output logic [DATA_WIDTH-1:0]  o_data   // Data Output
);

    // The Register Array 
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];
    integer i;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
                mem[i] <= {DATA_WIDTH{1'b0}};
            end
        end
        if (i_we) begin
            // Write operation
            mem[i_addr] <= i_data;
        end
        // Read operation (Synchronous read)
        o_data <= mem[i_addr];
    end

endmodule