`include "alu_opcodes.svh"

module alu_decode(

    input logic  [ 6:0 ] i_opcode,
    input logic  [ 2:0 ] i_funct3,
    output alu_op_t o_alu_code

);

always_comb begin

    case(i_opcode)

        7'b0010011: begin
            case(i_funct3) begin
                3'b000: o_alu_code = OP_ALU_ADD;
            end
            endcase
        end
    endcase
    
end

endmodule