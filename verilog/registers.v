module Registers (
    input clk,
    input [31:0] write_addr,
    input [31:0] data_in,
    input write_enable,
    input [31:0] address_a,
    input [31:0] address_b,
    output [31:0] data_a,
    output [31:0] data_b
);

    reg [31:0] memory [31:0];

    always @(posedge clk) begin
        if (write_enable) begin
            memory[write_addr] = data_in;
        end

        data_a <= memory[address_a];
        data_b <= memory[address_b];

        memory[32'b0] <= 0;
    end

endmodule
