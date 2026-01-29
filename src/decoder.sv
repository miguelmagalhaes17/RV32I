`timescale 1ns/1ps

module decoder #(
    parameter WIDTH = 32
)(
    input logic  [WIDTH-1:0]  i_instruction,
    output logic [6:0]        o_opcode,
    output logic [11:7]       o_rd,
    output logic [14:12]      o_funct3,
    output logic [19:15]      o_rs1,
    output logic [WIDTH-1:20] o_immediate
);

    always_comb begin
        o_opcode    = i_instruction[6:0];
        o_rd        = i_instruction[11:7];
        o_funct3    = i_instruction[14:12]; 
        o_rs1       = i_instruction[19:15]; 
        o_immediate = i_instruction[WIDTH-1:20]; 
    end

endmodule
