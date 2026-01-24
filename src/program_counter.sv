module program_counter #(
    parameter WIDTH = 32
)(
    input  wire              clk,    // Clock signal
    input  wire              rst_n,  // Active-low synchronous reset
    input  wire              i_en,   // Enable (increment)
    output reg  [WIDTH-1:0]  o_pc    // Current Program Counter value
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset PC to the start of memory (usually 0)
            o_pc <= {WIDTH{1'b0}};
        end 
        else if (i_en) begin
            // Normal operation: Increment by 4 (byte addressable)
            o_pc <= o_pc + 4;
        end
    end

endmodule