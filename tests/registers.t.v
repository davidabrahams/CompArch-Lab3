module testRegisters;

    reg [4:0] write_addr, address_a, address_b;
    reg write_enable, clk;
    reg [31:0] data_in;
    wire [31:0] data_a, data_b;
    reg dutpassed = 1;

    initial clk = 0;
    always #10 clk = !clk;

    Registers DUT(.clk(clk),
                   .write_addr(write_addr),
                   .data_in(data_in),
                   .write_enable(write_enable),
                   .address_a(address_a),
                   .address_b(address_b),
                   .data_a(data_a),
                   .data_b(data_b)
                   );

    initial begin
        $dumpfile("build/registers.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testRegisters);

        $display("Testing Registers");
        $display();

        // Test 1: zero register
        write_enable = 0;
        address_a = 5'b0;
        #40
        if (data_a !== 0) begin
            dutpassed = 0;
            $display("Test 1 Failed (a)");
        end

        write_enable = 1;
        address_a = 5'b0;
        data_in = 32'b1;
        #20
        if (data_a !== 0) begin
            dutpassed = 0;
            $display("Test 1 Failed (b)");
        end

        // Test 2: set register, then read register
        write_enable = 1;
        write_addr = 5'b1;
        data_in = 32'b10;
        #40

        write_enable = 0;
        address_a = 5'b1;
        #40
        if (data_a !== 32'b10) begin
            dutpassed = 0;
            $display("Test 2 Failed");
        end

        // Test 3: Read two registers
        write_enable = 1;
        write_addr = 5'b10;
        data_in = 32'b11;
        #40

        write_enable = 0;
        address_a = 5'b1;
        address_b = 5'b10;
        #40
        if (data_a !== 32'b10 && data_b !== 32'b11 ) begin
            dutpassed = 0;
            $display("Test 3 Failed");
        end

        if (dutpassed == 1) begin
            $display("Register Tests Passed");
        end
        else begin
            $display("Register Tests Failed");
        end

        $finish;
    end

endmodule
