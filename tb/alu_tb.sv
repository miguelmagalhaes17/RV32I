`timescale 1ns/1ps
`include "alu_opcodes.svh"

module alu_tb;

    localparam OP_WIDTH = 5;
    localparam WIDTH = 32;

    alu_op_t       i_alu_op;
    logic [ WIDTH-1:0 ] i_a;   
    logic [ WIDTH-1:0 ] i_b;
    logic [ WIDTH-1:0 ] o_result;



    alu #( .WIDTH ( WIDTH ) ) dut (
    
        .i_alu_op ( i_alu_op ),
        .i_a      ( i_a      ),
        .i_b      ( i_b      ),
        .o_result ( o_result )
    );

// --------------- Reference ALU model --------------- //

function automatic logic [ WIDTH-1:0 ] alu_ref(
    input alu_op_t             alu_op,
    input logic [ WIDTH-1:0 ]    a,
    input logic [ WIDTH-1:0 ]    b
);

    logic [WIDTH-1:0] r;
    logic [$clog2(WIDTH)-1:0] shamt;
    shamt = b[$clog2(WIDTH)-1:0];

    begin
        case(alu_op)

            OP_ALU_PC:     r = a + 4;
            OP_ALU_ADD:    r = a + b;
            OP_ALU_SUB:    r = a - b;
            OP_ALU_AND:    r = a & b;
            OP_ALU_OR:     r = a | b;
            OP_ALU_XOR:    r = a ^ b;
            OP_ALU_SLTU:   r = (a < b);
            OP_ALU_SLT:    r = ($signed(a) < $signed(b)) ? 1 : 0;
            OP_ALU_SLL:    r = a << shamt;
            OP_ALU_SRL:    r = a >> shamt;
            OP_ALU_SRA:    r = $signed(a) >>> shamt;
            OP_ALU_EQ:     r = (a == b) ? 1 : 0;
            OP_ALU_NEQ:    r = (a != b) ? 1 : 0;
            /*
            OP_ALU_GT:     r = ($signed(a) > $signed(b)) ? 1 : 0;
            OP_ALU_GTU:    r = (a > b) ? 1 : 0;
            */
            default:            r = 0;

        endcase
        
        return r;

    end
    
endfunction

// --------------- ------------------- --------------- //

task comparison_dut_ref();
    logic [ WIDTH-1: 0 ] expected_value;
    begin 
        expected_value = alu_ref(i_alu_op, i_a, i_b);
        assert (o_result == expected_value) $display("Expected value matches ALU value.");
        else $error("ALU value %h didn't match expected value %h for instruction %d", o_result, expected_value, i_alu_op);
    end

endtask

initial begin 
    i_alu_op = OP_ALU_ADD; i_a = 1; i_b = 1;
    #1
    comparison_dut_ref();
    i_alu_op = OP_ALU_AND; i_a = 1; i_b = 2; 
    #1
    comparison_dut_ref();
end



endmodule