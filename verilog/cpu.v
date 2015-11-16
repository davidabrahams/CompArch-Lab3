module cpu;

    // System Clock
    wire clkOut;
    clk(.clkOut(clkOut));

    // Control Signals
    wire [1:0] pcNext;
    wire [1:0] regDst;
    wire aluSrc;
    wire [1:0] aluCtrl;
    wire regWe;
    wire [1:0] RegIn;
    wire MemWe;
    wire beq;
    wire bne;
    // fsm

    // Program Counter
    wire [31:0] pcOut; // this might need to be a register
    wire [31:0] pcIn;
    mux4 pcMux(.out(pcIn), 
               .address(pcNext), 
               .input0(pcAddOut), 
               .input1(dataA), 
               .input2(pcJump));
    PC pc(.clk(clkOut), .in(pcIn), .out(pcOut));

    // Program Counter Adder
    reg pcAddOut, pcAddMuxOut;
    mux2 pcAddMux(.out(pcAddMuxOut), 
                  .address(brch), 
                  .input0(4), 
                  .input1(seImm));
    pcAddOut = pcOut + pcAddMuxOut;

    // Instruction Memory
    wire [31:0] instructionOut, instructionAddr;
    datamemory #(.addresswidth(32), 
                 .depth(2048), 
                 .width(32)) instructionMemory(.clk(clkOut)
                                               .dataOut(instructionOut),
                                               .address(instructionAddr),
                                               .writeEnable(0));

    // Instruction Decoder
    wire [5:0]  decoderOp;
    wire [4:0]  decoderRs;
    wire [4:0]  decoderRt;
    wire [4:0]  decoderRd;
    wire [15:0] decorderImm16;
    wire [25:0] decoderAddr26;
    instructionDecoder decoder(.instruction_in(instructionOut),
                               .op(decoderOp),
                               .rs(decoderRs),
                               .rt(decoderRt),
                               .rd(decoderRd),
                               .imm_16(decoderImm16),
                               .address_26(decoderAddr26));

endmodule
