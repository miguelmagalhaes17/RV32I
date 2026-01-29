`include "alu_opcodes.svh"

module alu #(parameter WIDTH = 32)(
    input logic  [3:0]        i_alu_op;
    input logic  [WIDTH-1:0]  i_a;
    input logic  [WIDTH-1:0]  i_b;
    output logic [WIDTH-1:0]  o_result; 
);

always_comb begin
    case(i_alu_op)
        `OP_ALU_PC:     o_result = i_a + 4;
        `OP_ALU_ADD:    o_result = i_a + i_b;
        `OP_ALU_SUB:    o_result = i_a - i_b;
        `OP_ALU_AND:    o_result = i_a & i_b;
        `OP_ALU_OR:     o_result = i_a | i_b;
        `OP_ALU_XOR:    o_result = i_a ^ i_b;
        `OP_ALU_SLTU:   o_result = (i_a < i_b) ? 1 : 0;
        `OP_ALU_SLT:    o_result = ($signed(i_a) < $signed(i_b)) ? 1 : 0;
        `OP_ALU_SLL:    o_result = i_a << i_b[$clog2(WIDTH)-1:0];
        `OP_ALU_SRL:    o_result = i_a >> i_b[$clog2(WIDTH)-1:0];
        `OP_ALU_SRA:    o_result = $signed(i_a) >>> i_b[$clog2(WIDTH)-1:0];
        `OP_ALU_EQ:     o_result = (i_a == i_b) ? 1 : 0;
        `OP_ALU_NEQ:    o_result = (i_a != i_b) ? 1 : 0;
        /*
        `OP_ALU_GT:     o_result = ($signed(i_a) > $signed(i_b)) ? 1 : 0;
        `OP_ALU_GTU:    o_result = (i_a > i_b) ? 1 : 0;
        */

    default:            o_result = 0;
    endcase
end
endmodule
