`timescale 1ns/1ps

module tb_decoder;

    logic [31:0]  i_instruction;
    logic [6:0]   o_opcode;
    logic [4:0]   o_rd;
    logic [2:0]   o_funct3;
    logic [4:0]   o_rs1;
    logic [11:0]  o_immediate;

decoder decoder_inst(
    .i_instruction ( i_instruction ),
    .o_opcode      ( o_opcode      ),
    .o_rd          ( o_rd          ),
    .o_funct3      ( o_funct3      ),
    .o_rs1         ( o_rs1         ),
    .o_immediate   ( o_immediate   )
);

task check_expected_values(
    input [31:0] instruction,
    input [6:0] expected_opcode,
    input [4:0] expected_rd,
    input [2:0] expected_funct3,
    input [4:0] expected_rs1,
    input [11:0] expected_imm
);

    begin
        i_instruction = instruction;
        #10; // Wait for combinational logic to settle
        assert(o_opcode == expected_opcode) else $error("Opcode mismatch: got %h, expected %h", o_opcode, expected_opcode);
        assert(o_rd == expected_rd) else $error("RD mismatch: got %0d, expected %0d", o_rd, expected_rd);
        assert(o_rs1 == expected_rs1) else $error("RS1 mismatch: got %0d, expected %0d", o_rs1, expected_rs1);
        assert(o_immediate == expected_imm) else $error("Immediate mismatch: got %0d, expected %0d", o_immediate, expected_imm);
        assert(o_funct3 == expected_funct3) else $error("Funct3 mismatch: got %b, expected %b", o_funct3, expected_funct3);

    end

endtask

initial begin

    check_expected_values(32'h00000013, 7'b0010011, 5'b00000, 3'b000, 5'b00000, 12'b000000000000);

    check_expected_values(32'h00108093, 7'b0010011, 5'b00001, 3'b000, 5'b00001, 12'b000000000001);
    check_expected_values(32'hFFFF8113, 7'b0010011, 5'b00010, 3'b000, 5'b11111, 12'b111111111111);
    $display("All tests passed.");
    $finish;

end

initial begin
    // Setup for Waveform dumping
    $dumpfile("out/waveform.vcd");
    $dumpvars(0, tb_register_file);
end

initial begin
  #1000 $display("Simulation finished.");
    $finish;
end

endmodule