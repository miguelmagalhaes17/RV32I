`timescale 1ns/1ps

module program_counter #(
    parameter WIDTH = 32
)(
    input  logic              clk,    // Clock signal
    input  logic              rst,    // Active-low synchronous reset
    input  logic              i_en,   // Enable (increment)
    output logic  [WIDTH-1:0] o_pc    // Current Program Counter value
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset PC to the start of memory (usually 0)
            o_pc <= {WIDTH{1'b0}};
        end 
        else if (i_en) begin
            // Normal operation: Increment by 1
            o_pc <= o_pc + 1;
        end
    end
endmodule