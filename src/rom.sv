module rom #(
    parameter WIDTH = 32
) 
(
    input  [WIDTH-1:0] addr,        // Address from the Program Counter
    output [WIDTH-1:0] instruction  // 32-bit instruction
);

    // Define memory size (e.g., 64 words of 32-bits each)
    reg [WIDTH-1:0] rom [63:0];

    // Initialize memory with a program file
    initial begin
        $readmemh("software/instructions.txt", rom);
    end

    // Asynchronous Read: Output changes whenever the address changes
    assign instruction = rom[addr];

endmodule