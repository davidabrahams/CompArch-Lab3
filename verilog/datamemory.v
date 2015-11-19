//------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//   If writeEnable is true, writes dataIn to mem[address]
//------------------------------------------------------------------------

module datamemory
(
    input 		      clk,
    output [31:0] dataOut,
    input [31:0]      address,
    input             writeEnable,
    input [31:0]      dataIn
);


    reg [31:0] memory [1023:0];

    always @(posedge clk) begin
        if(writeEnable)
            memory[address] <= dataIn;
    end

    initial $readmemh("load/add-data.txt", memory);
    assign dataOut = memory[address];

endmodule
