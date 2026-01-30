`timescale 1ns/1ps

module rv32 #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = $clog2(DATA_WIDTH)
)
(
    input wire clk,
    input wire rst
);

    // Logic declaration
    logic [DATA_WIDTH-1: 0] pc;
    logic                   pc_en;
    logic                   i_we;         // Write Enable
    logic [ADDR_WIDTH-1: 0] i_wr_address; // Write Address
    logic [DATA_WIDTH-1: 0] i_wr_data;    // Write Data
    
    logic [ADDR_WIDTH-1: 0] i_rd_addr_1;  // Read Address 1
    logic [DATA_WIDTH-1: 0] o_rd_data_1;  // Read Data    1

    logic [ADDR_WIDTH-1: 0] i_rd_addr_2;  // Read Address 2
    logic [DATA_WIDTH-1: 0] o_rd_data_2;  // Read Data    2

    logic [DATA_WIDTH-1: 0] instruction;
    logic           [ 6: 0] opcode;
    logic           [11: 7] rd;
    logic           [14:12] funct3;
    logic           [19:15] rs1;
    logic [DATA_WIDTH-1:20] immediate;


    // ------------- Program counter ------------- 
    always_ff @ (posedge clk or negedge rst) begin
        if(!rst) pc_en <= 1'b0;
        else     pc_en <= 1'b1;
    end

    program_counter #(
        .WIDTH          ( DATA_WIDTH   )
    ) u_program_counter (
        .clk            ( clk          ),
        .rst            ( rst          ),
        .i_en           ( pc_en        ),
        .o_pc           ( pc           )
    );
    // ------------ /Program counter ------------- 

    // ------------- Register File --------------- 
    // TODO: For now assign to zero while decode is not done
    assign i_we         = 0;
    assign i_wr_address = 0;
    assign i_wr_data    = 0;
    assign i_rd_addr_1  = 0;
    assign i_rd_addr_2  = 0;


    register_file #(
        .ADDR_WIDTH     ( ADDR_WIDTH   ),
        .DATA_WIDTH     ( DATA_WIDTH   )
    ) u_register_file (
        .clk            ( clk          ),
        .rst            ( rst          ),
        .i_we           ( i_we         ),
        .i_wr_address   ( i_wr_address ),
        .i_wr_data      ( i_wr_data    ),
        .i_rd_addr_1    ( i_rd_addr_1  ),
        .o_rd_data_1    ( o_rd_data_1  ),
        .i_rd_addr_2    ( i_rd_addr_2  ),
        .o_rd_data_2    ( o_rd_data_2  )
    );
    // ------------ /Register File --------------- 

    // --------------- Decoder ------------------- 
    decoder #(
        .WIDTH          ( DATA_WIDTH   )
    ) u_decoder (
        .i_instruction  ( instruction  ),
        .o_opcode       ( opcode       ),
        .o_rd           ( rd           ),
        .o_funct3       ( funct3       ),
        .o_rs1          ( rs1          ),
        .o_immediate    ( immediate    )
    );
    // --------------- /Decoder ------------------

    // ----------------- ROM --------------------- 
    rom #(
        .WIDTH          ( DATA_WIDTH   )
    ) u_rom (
        .addr           ( pc           ),
        .instruction    ( instruction  )
    );
    // ---------------- /ROM --------------------- 

endmodule