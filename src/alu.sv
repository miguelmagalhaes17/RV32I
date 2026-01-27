`define OP_ALU_PC     6'b000000 // PC+4
`define OP_ALU_ADD    6'b000001 // Add
`define OP_ALU_SUB    6'b000010 // Subtract
`define OP_ALU_AND    6'b000011 // Bitwise AND
`define OP_ALU_OR     6'b000100 // Bitwise OR
`define OP_ALU_XOR    6'b000101 // Bitwise XOR
`define OP_ALU_SLTU   6'b000111 // Set Less Than (unsigned)
`define OP_ALU_SLT    6'b001000 // Set Less Than (signed)
`define OP_ALU_SLL    6'b001001 // Shift Left Logical
`define OP_ALU_SRL    6'b001010 // Shift Right Logical
`define OP_ALU_SRA    6'b001011 // Shift Right Arithmetic
`define OP_ALU_EQ     6'b001100 // Equal
`define OP_ALU_NEQ    6'b001101 // Not equal
`define OP_ALU_GT
`define OP_ALU_GTU

// FIX OP_CODES: separar por categorias, maybe dar match 'a spec/ pode ser arbitrario


module alu #(parameter WIDTH = 32)(
    input logic  [3:0]        i_alu_op;
    input logic  [WIDTH-1:0]  i_a;
    input logic  [WIDTH-1:0]  i_b;
    output logic [WIDTH-1:0]  o_result; 
);

always_comb begin
    case(i_alu_op)
        `OP_ALU_ADD:   o_result = i_a + i_b;
        `OP_ALU_SUB:   o_result = i_a - i_b;
        `OP_ALU_AND:   o_result = i_a & i_b;
        `OP_ALU_OR:    o_result = i_a | i_b;
        `OP_ALU_XOR:   o_result = i_a ^ i_b;
        `OP_ALU_SLTU:   o_result = (i_a < i_b) ? 1 : 0;
        `OP_ALU_SLT:  o_result = ($signed(i_a) < $signed(i_b)) ? 1 : 0;
        `OP_ALU_SLL:   o_result = i_a << i_b[4:0];
        `OP_ALU_SRL:   o_result = i_a >> i_b[4:0];
        `OP_ALU_SRA:   o_result = $signed(i_a) >>> i_b[4:0]
    default: o_result = 0;
    endcase
end
endmodule
