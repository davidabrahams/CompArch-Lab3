module cpu;

    // System Clock
    wire clkOut;
    clock clk(clkOut);

    // Control Signals
    wire [1:0] PcNext;
    wire [1:0] RegDst;
    wire AluSrc;
    wire [1:0] AluCtrl;
    wire RegWe;
    wire [1:0] RegIn;
    wire MemWe;
    wire BEQ;
    wire BNE;

    // Program Counter
    wire [31:0] pcOut; // this might need to be a register
    wire [31:0] pcIn;
    assign pcAddOut = pcOut + pcAddMuxOut;
    mux4 pcMux(.out(pcIn),
               .address(PcNext),
               .input0(pcAddOut),
               .input1(pcJump),
               .input2(regDataA));
    PC pc(.clk(clkOut), .in(pcIn), .out(pcOut));

    // Program Counter Adder
    wire [31:0] pcAddOut, pcAddMuxOut;
    mux2 pcAddMux(.out(pcAddMuxOut),
                  .address(branch),
                  .input0(4),
                  .input1(4 * seImm + 4));

    // Instruction Memory
    wire [31:0] instructionOut, instructionAddr;
    assign instructionAddr = pcOut;
    instructionMemory instrMem(.clk(clkOut),
                               .dataOut(instructionOut),
                               .address(instructionAddr),
                               .writeEnable(0));

    // Instruction Decoder
    wire [5:0] opOut, functOut;
    wire [4:0] rsOut, rtOut, rdOut;
    wire [15:0] imm16Out;
    wire [25:0] addr26Out;
    instructionDecoder decoder(.instruction_in(instructionOut),
                               .op(opOut),
                               .rs(rsOut),
                               .rt(rtOut),
                               .rd(rdOut),
                               .funct(functOut),
                               .imm_16(imm16Out),
                               .address_26(addr26Out));

    // Concatenator
    wire [31:0] pcJump;
    assign pcJump = { pcOut[31:28], addr26Out, 2'b00 };

    // Sign Extender
    wire [31:0] seImm;
    assign seImm = { { 16 { imm16Out[15] } }, imm16Out };


    // Registers
    wire regWriteEnable;
    wire [4:0] regWriteAddr, regAddrA, regAddrB;
    wire [31:0] regDataIn, regDataA, regDataB;
    Registers regs(.clk(clkOut),
                   .write_addr(regWriteAddr),
                   .data_in(regDataIn),
                   .write_enable(RegWe),
                   .address_a(regAddrA),
                   .address_b(regAddrB),
                   .data_a(regDataA),
                   .data_b(regDataB));

    wire [4:0] ra = 5'd31;

    mux4 regWriteAddrMux(.out(regWriteAddr),
                         .address(RegDst),
                         .input0(rtOut),
                         .input1(rdOut),
                         .input2(ra));

    assign regAddrA = rsOut;
    assign regAddrB = rtOut;

    mux4 regDataWriteMux(.out(regDataIn),
                         .address(RegIn),
                         .input0(aluResult),
                         .input1(dataMemOut),
                         .input2(pcAddOut));

    // ALU
    wire [31:0] aluResult, aluOpA, aluOpB;
    wire aluCarryout, aluZero, aluOverflow;
    wire [2:0] aluCommand;
    ALU alu(.result(aluResult),
            .carryout(aluCarryOut),
            .zero(aluZero),
            .overflow(aluOverflow),
            .operandA(aluOpA),
            .operandB(aluOpB),
            .command(AluCtrl));

    assign aluOpA = regDataA;

    mux2 aluBMux(.out(aluOpB),
                 .address(AluSrc),
                 .input0(seImm),
                 .input1(regDataB));

    // Branch Control
    wire branch;
    assign branch = ((BEQ & aluZero) | (BNE & ~aluZero));

    // Data Memory
    wire [31:0] dataMemDataOut, dataMemAddr, dataMemDataIn;
    datamemory dataMem(.clk(clkOut),
                       .dataOut(dataMemOut),
                       .address(dataMemAddr),
                       .writeEnable(MemWe),
                       .dataIn(dataMemDataIn));

    assign dataMemAddr = aluResult;
    assign dataMemDataIn = regDataB;

    // Control Table
    controlTable controls(.clk(clkOut),
                          .op(opOut),
                          .funct(functOut),
                          .pc_next(PcNext),
                          .reg_dst(RegDst),
                          .alu_src(AluSrc),
                          .alu_ctrl(AluCtrl),
                          .reg_we(RegWe),
                          .reg_in(RegIn),
                          .mem_we(MemWe),
                          .beq(BEQ),
                          .bne(BNE));

    initial begin
        $dumpfile("cpu.vcd"); //dump info to create wave propagation later
        $dumpvars(0, cpu);

        #10;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        #20;
        $display("PC: %b", pcOut);
        // check our result registers!
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        #20
        $display("regA: %d, at address: %h", regDataA, regAddrA);
        $finish;
    end

endmodule
