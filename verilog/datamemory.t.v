//-------------------------------
// Data Memory Test
//-------------------------------

module testDataMemory;

    reg clk;
    wire [7:0] dataOut;
    reg [6:0] address;
    reg writeEnable;
    reg  [7:0] dataIn;

    reg dutpassed;

    datamemory DUT(clk, dataOut, address, writeEnable, dataIn);

    initial clk = 0;
    always #10 clk = !clk;

    initial begin
        $dumpfile("dataMemory.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testDataMemory);

        $display("Testing DataMemory");
        $display();

        dutpassed = 1;

        // Test 1
        writeEnable = 1;
        address = 7'b0000001;
        dataIn = 8'b10;
        #40

        if (dataOut != 8'b10) begin
            dutpassed = 0;
            $display("Test 1 FAIL: %b", dataOut);
        end

        // Test 2
        writeEnable = 0;
        address = 7'b0000001;
        dataIn = 8'b111;
        #40

        if (dataOut != 8'b10) begin
            dutpassed = 0;
            $display("Test 2 FAIL: %b", dataOut);
        end

        // Test 3
        writeEnable = 0;
        address = 7'b1111111;
        dataIn = 8'b111;
        #40

        if (dataOut != 7'bx) begin
            dutpassed = 0;
            $display("Test 3 FAIL: %b", dataOut);
        end

        // Test 4
        writeEnable = 1;
        address = 7'b1111110;
        dataIn = 8'b111;
        #40

        if (dataOut != 8'b111) begin
            dutpassed = 0;
            $display("Test 4 FAIL: %b", dataOut);
        end

        // Test 5
        writeEnable = 0;
        address = 7'b0000001;
        dataIn = 8'b101;
        #40

        if (dataOut != 8'b10) begin
            dutpassed = 0;
            $display("Test 5 FAIL: %b", dataOut);
        end

        if (dutpassed == 1) begin
            $display("All Tests Passed");
        end
        else begin
            $display("Tests Failed");
        end
        $finish;

    end

endmodule
