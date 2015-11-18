module Registers (
    input clk,
    input [4:0] write_addr,
    input [31:0] data_in,
    input write_enable,
    input [4:0] address_a,
    input [4:0] address_b,
    output [31:0] data_a,
    output [31:0] data_b
);

    reg [4:0] memory [31:0];

    always @(posedge clk) begin
        if (write_enable) begin
            memory[write_addr] <= data_in;
        end

        memory[5'b0] <= 31'b0;

    end

    assign data_a = memory[address_a];
    assign data_b = memory[address_b];

endmodule
