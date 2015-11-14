//------------------------------------------------------------------------
// Instruction Decoder
//   Positive edge triggered
//------------------------------------------------------------------------

module instructionDecoder
(
    input reg [31:0]    instruction_in,
    output reg [5:0]    op,
    output reg [4:0]    rs,
    output reg [4:0]    rt,
    output reg [4:0]    rd,
    output reg [15:0]   imm_16,
    output reg [25:0]   address_26,
);


  assign op <= instruction_in[31:26];
  assign rs <= instruction_in[25:21];
  assign rt <= instruction_in[20:16];
  assign rd <= instruction_in[15:11];
  assign imm_16 <= instruction_in[15:0];
  assign address_26 <= instruction_in[25:0];

endmodule
