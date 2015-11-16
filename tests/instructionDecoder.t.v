//-------------------------------
// Data Memory Test
//-------------------------------

module testInstructionDecoder;

    reg [31:0]    instruction_in;
    wire [5:0]    op;
    wire [4:0]    rs;
    wire [4:0]    rt;
    wire [4:0]    rd;
    wire [5:0]    funct;
    wire [15:0]   imm_16;
    wire [25:0]   address_26;

    reg dutpassed;

    instructionDecoder DUT(instruction_in, op, rs, rt, rd, funct, imm_16, address_26);

    initial begin
        $dumpfile("instructionDecoder.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testInstructionDecoder);

        $display("Testing instructionDecoder");

        dutpassed = 1;

        // Test 1: R-Type Instruction

        instruction_in = 32'b10000000001000100001100000000000;
        #10
        if (op !== 6'b100000 || rs !== 5'b00001 || rt !== 5'b00010 || rd !== 5'b00011) begin
            dutpassed = 0;
            $display("Test 1 FAIL");
            $display("op: %b, rs: %b", op, rs);
            $display("rt: %b, rd: %b", rt, rd);
        end


        // Test 2: I-Type Instruction

        instruction_in = 32'b00100001001100101101100010100111;
        #10
        if (op !== 6'b001000 || rs !== 5'b01001 || rt !== 5'b10010 || imm_16 !== 16'b1101100010100111) begin
            dutpassed = 0;
            $display("Test 2 FAIL");
            $display("op: %b, rs: %b", op, rs);
            $display("rt: %b, imm_16: %b", rt, imm_16);
        end


        // Test 2: J-Type Instruction

        instruction_in = 32'b00001010101010001110010100101011;
        #10
        if (op !== 6'b000010 || address_26 !== 26'b10101010001110010100101011) begin
            dutpassed = 0;
            $display("Test 3 FAIL");
            $display("op: %b", op);
            $display("address: %b", address_26);
        end

        if (dutpassed == 1) begin
            $display("All Tests Passed");
        end
        else begin
            $display("Tests Failed");
        end
        $display();
        $finish;

    end

endmodule
