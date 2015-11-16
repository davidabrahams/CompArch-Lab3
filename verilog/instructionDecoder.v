//------------------------------------------------------------------------
// Instruction Decoder
//   Positive edge triggered
//------------------------------------------------------------------------

module instructionDecoder
(
    input [31:0] instruction_in,
    output [5:0]     op,
    output [4:0]     rs,
    output [4:0]     rt,
    output [4:0]     rd,
    output [5:0]     funct,
    output [15:0]    imm_16,
    output [25:0]   address_26
);

  assign op = instruction_in[31:26];
  assign rs = instruction_in[25:21];
  assign rt = instruction_in[20:16];
  assign rd = instruction_in[15:11];
  assign funct = instruction_in[5:0];
  assign imm_16 = instruction_in[15:0];
  assign address_26 = instruction_in[25:0];

endmodule
