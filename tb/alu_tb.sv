`timescale 1ns/1ps
`include "alu_opcodes.svh"

module alu_tb;

    localparam OP_WIDTH = 5;
    localparam WIDTH = 32;

    logic [ 4:0  ] i_alu_op;
    logic [ 31:0 ] i_a;   
    logic [ 31:0 ] i_b;
    logic [ 31:0 ] o_result;


    alu #(.WIDTH(WIDTH)) dut (
    
        .i_alu_op ( i_alu_op ),
        .i_a      ( i_a      ),
        .i_b      ( i_b      ),
        .o_result ( o_result )
    );


endmodule