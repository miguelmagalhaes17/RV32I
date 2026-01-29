`define OP_ALU_PC     5'b00000 // PC+4
`define OP_ALU_ADD    5'b00001 // Add
`define OP_ALU_SUB    5'b00010 // Subtract
`define OP_ALU_AND    5'b00011 // Bitwise AND
`define OP_ALU_OR     5'b00100 // Bitwise OR
`define OP_ALU_XOR    5'b00101 // Bitwise XOR
`define OP_ALU_SLTU   5'b00110 // Set Less Than (unsigned)
`define OP_ALU_SLT    5'b00111 // Set Less Than (signed)
`define OP_ALU_SLL    5'b01000 // Shift Left Logical
`define OP_ALU_SRL    5'b01001 // Shift Right Logical
`define OP_ALU_SRA    5'b01010 // Shift Right Arithmetic
`define OP_ALU_EQ     5'b01011 // Equal
`define OP_ALU_NEQ    5'b01100 // Not equal
`define OP_ALU_GT     5'b01101 // Greater Than
`define OP_ALU_GTU    5'b01110 // Greater Than (unsigned)

// FIX OP_CODES: separar por categorias, maybe dar match 'a spec/ pode ser arbitrario
