`timescale 1ns/1ps

module register_file #(
    parameter ADDR_WIDTH =  5,     // 32 Registers
    parameter DATA_WIDTH = 32      // 32-bit wide data
)(
    input  logic                   clk,
    input  logic                   rst,
    // Write
    input  logic                   i_we,         // Write Enable
    input  logic [ADDR_WIDTH-1:0]  i_wr_address, // Write Address
    input  logic [DATA_WIDTH-1:0]  i_wr_data,    // Write Data
    // Read
    input  logic [ADDR_WIDTH-1:0]  i_rd_addr_1,  // Read Address 1
    output logic [DATA_WIDTH-1:0]  o_rd_data_1,  // Read Data    1

    input  logic [ADDR_WIDTH-1:0]  i_rd_addr_2,  // Read Address 2
    output logic [DATA_WIDTH-1:0]  o_rd_data_2   // Read Data    2
);

    // The Register Array 
    reg [DATA_WIDTH-1:0] regs [0:(1<<ADDR_WIDTH)-1];
    integer i;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
                regs[i] <= {DATA_WIDTH{1'b0}};
            end
        end
        if (i_we) begin
            // Write operation
            regs[i_wr_address] <= i_wr_data;
        end
    end

    assign o_rd_data_1 = (i_rd_addr_1 == {ADDR_WIDTH{1'b0}}) ? {DATA_WIDTH{1'b0}} : regs[i_rd_addr_1];
    assign o_rd_data_2 = (i_rd_addr_2 == {ADDR_WIDTH{1'b0}}) ? {DATA_WIDTH{1'b0}} : regs[i_rd_addr_2];

endmodule