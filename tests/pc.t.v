module testPc;

    reg clk;
    reg [31:0] in;
    wire [31:0] out;

    initial clk = 0;
    always #10 clk = !clk;

    reg dutpassed = 1;

    PC pc(.clk(clk), .in(in), .out(out));

    initial begin
        $dumpfile("build/pc.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testPc);

        $display("Testing PC");

        // Test 1: pc is initially set to 0
        if (out !== 32'b0) begin
            dutpassed = 0;
            $display("Test 1 Failed");
        end

        // Test 2
        in = 32'b1;
        #20
        if (out !== 32'b1) begin
            dutpassed = 0;
            $display("Test 2 Failed");
        end

        if (dutpassed === 1) begin
            $display("PC Tests Passed");
        end
        else begin
            $display("PC Tests Failed");
        end

        $display();
        $finish;
    end

endmodule
