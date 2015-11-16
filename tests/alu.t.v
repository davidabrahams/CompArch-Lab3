module testAlu;

    reg[31:0] operandA, operandB;
    reg[2:0] command;
    wire carryout, zero, overflow;
    wire[31:0] result;

    reg dutpassed;

    ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
        $dumpfile("build/alu.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testAlu);

        $display("Testing ALU");
        $display();

        dutpassed = 1;

        // $display("Adding");
        // $display();
        // $display("A                                B                                command | result                           Cout zero overflow | Expected");
        command=3'b000;
        operandA=32'b11111111111111111111111111111111;
        operandB=32'b11111111111111111111111111111111;
        #1000000

        if (result!=32'b11111111111111111111111111111110 | carryout!=1'b1 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("Adding Test FAIL");
        end
        operandA=32'b11111111111111111111111111111100;
        operandB=32'b00000000000000000000000000000100;
        #1000000

        if (result!=32'b00000000000000000000000000000000 | carryout!=1'b1 | zero!=1'b1 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("Adding Test FAIL");
        end

        operandA=32'b01000000000000000000000000000000;
        operandB=32'b01000000000000000000000000000000;
        #1000000

        if (result!=32'b10000000000000000000000000000000 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b1) begin
            dutpassed = 0;
            $display("Adding Test FAIL");
        end
        command=3'b001;
        operandA=32'b11111111111111111111111111111100;
        operandB=32'b00000000000000000000000000000100;
        #1000000
        if (result!=32'b11111111111111111111111111111000 | carryout!=1'b1 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("Subtraction Test FAIL");
        end
        operandA=32'b00000000000000000000000000001001;
        operandB=32'b00000000000000000000000000001001;
        #1000000
        if (result!=32'b00000000000000000000000000000000 | carryout!=1'b1 | zero!=1'b1 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("Subtraction Test FAIL");
        end
        operandA=32'b10000000000000000000000000000000;
        operandB=32'b01111111111111111111111111111111;
        #1000000
        if (result!=32'b00000000000000000000000000000001 | carryout!=1'b1 | zero!=1'b0 | overflow!=1'b1) begin
            dutpassed = 0;
            $display("Subtraction Test FAIL");
        end
        command=3'b010;
        operandA=32'b10000011011110000000110000001100;
        operandB=32'b00000001000000000000111111000100;
        #1000000
        if (result!=32'b10000010011110000000001111001000 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("XOR Test FAIL");
        end
        command=3'b011;
        operandA=32'b11111111111111111111111111111111;
        operandB=32'b00000000000000000000000000000000;
        #1000000
        if (result!=32'b00000000000000000000000000000001 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        operandA=32'b00000000000000001111111111111111;
        operandB=32'b00000000000000000000000000000001;
        #1000000
        if (result!=32'b00000000000000000000000000000000 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        operandB=32'b00000000000000001111111111111111;
        operandA=32'b00000000000000000000000000000001;
        #1000000
        if (result!=32'b00000000000000000000000000000001 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        operandA=32'b10000001100000001111111111111111;
        operandB=32'b10000000000000000000000000000001;
        #1000000
        if (result!=32'b00000000000000000000000000000000 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        operandB=32'b10000000000000001111111111111111;
        operandA=32'b10000000000000000000001100000001;
        #1000000
        if (result!=32'b00000000000000000000000000000001 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        operandB=32'b10000000000000000111101111011111;
        operandA=32'b10000000000000000111101111011111;
        #1000000
        if (result!=32'b00000000000000000000000000000000 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("SLT Test FAIL");
        end
        command=3'b100;
        operandA=32'b10000011011110000000110000001100;
        operandB=32'b00000001000000000000111111000100;
        #1000000
        if (result!=32'b00000001000000000000110000000100 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("AND Test FAIL");
        end
        command=3'b101;
        operandA=32'b10000011011110000000110000001100;
        operandB=32'b00000001000000000000111111000100;
        #1000000
        if (result!=32'b11111110111111111111001111111011 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("NAND Test FAIL");
        end
        command=3'b110;
        operandA=32'b10000011011110000000110000001100;
        operandB=32'b00000001000000000000111111000100;
        #1000000
        if (result!=32'b01111100100001111111000000110011 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("NOR Test FAIL");
        end
        command=3'b111;
        operandA=32'b10000011011110000000110000001100;
        operandB=32'b00000001000000000000111111000100;
        #1000000
        if (result!=32'b10000011011110000000111111001100 | carryout!=1'b0 | zero!=1'b0 | overflow!=1'b0) begin
            dutpassed = 0;
            $display("NOR Test FAIL");
        end
        if (dutpassed == 1) begin
            $display("Alu Tests Passed");
        end
        else begin
            $display("Alu Tests Failed");
        end

        $finish;
    end

endmodule
