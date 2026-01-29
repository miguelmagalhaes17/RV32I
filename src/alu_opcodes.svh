`ifndef ALU_OPCODES_SVH
`define ALU_OPCODES_SVH
typedef enum logic [4:0] {
    OP_ALU_PC   = 5'd0,  // 00000
    OP_ALU_ADD  = 5'd1,  // 00001
    OP_ALU_SUB  = 5'd2,  // 00010
    OP_ALU_AND  = 5'd3,  // 00011
    OP_ALU_OR   = 5'd4,  // 00100
    OP_ALU_XOR  = 5'd5,  // 00101
    OP_ALU_SLTU = 5'd6,  // 00110
    OP_ALU_SLT  = 5'd7,  // 00111
    OP_ALU_SLL  = 5'd8,  // 01000
    OP_ALU_SRL  = 5'd9,  // 01001
    OP_ALU_SRA  = 5'd10, // 01010
    OP_ALU_EQ   = 5'd11, // 01011
    OP_ALU_NEQ  = 5'd12, // 01100
    OP_ALU_GT   = 5'd13, // 01101
    OP_ALU_GTU  = 5'd14  // 01110
} alu_op_t;

`endif
// FIX OP_CODES: separar por categorias, maybe dar match 'a spec/ pode ser arbitrario
