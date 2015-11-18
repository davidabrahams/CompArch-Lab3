//------------------------------------------------------------------------
// Instruction Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//------------------------------------------------------------------------

module instructionMemory
(
    input         clk,
    output [31:0] dataOut,
    input [31:0]  address,
    input         writeEnable,
    input [31:0]  dataIn
);


    reg [31:0] memory [1023:0];

    always @(posedge clk) begin
        if(writeEnable)
            memory[address] <= dataIn;
    end

    assign dataOut = memory[address / 4];
    initial $readmemh("../load/divide-instructions.txt", memory);

endmodule
