module tb;

    logic [31:0]  i_instruction;
    logic [6:0]   o_opcode;
    logic [4:0]   o_rd;
    logic [2:0]   o_funct3;
    logic [4:0]   o_rs1;
    logic [11:0]  o_immediate;

decoder decoder_inst(
    .i_instruction (i_instruction),
    .o_opcode(o_opcode),
    .o_rd(o_rd),
    .o_funct3(o_funct3),
    .o_rs1(o_rs1),
    .o_immediate(o_immediate)
);

initial begin
    i_instruction = 32'h00000000; // 
    #10
    i_instruction = 32'h00F00513; // ADDI x10, x0, 15
    #10
    i_instruction = 32'hFFF00793; // ADDI x15, x0, -1
    #10
    i_instruction = 32'h00F51113; // ADDI x18(?), x10, 15
    $finish;
    
end

initial begin
    $monitor("i_instruction = %h, o_opcode = %h, o_rd = %0d, o_rs1 = %0d, o_imm = %0d",
             i_instruction,       o_opcode,      o_rd,       o_rs1,       o_immediate);
end

endmodule