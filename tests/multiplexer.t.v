//-------------------------------
// Multiplexer Test
//-------------------------------

module testMux;

  wire[31:0] out2, out4;
  reg address2;
  reg[1:0] address4;
  reg[31:0] input0, input1, input2, input3;

  reg dutpassed;

  mux2 DUT2(out2, address2, input0, input1);
  mux4 DUT4(out4, address4, input0, input1, input2, input3);

  initial begin
    $dumpfile("mux.vcd");
    $dumpvars(0, testMux);

    $display("Testing Multiplexers");
    $display();

    dutpassed = 1;

    // Test 1: Port 0
    input0 = 32'd0;
    input1 = 32'd151;
    input2 = 32'd56;
    input3 = 32'd3;

    address2 = 0;
    address4 = 0;

    #20
    if (out2 !== 0 || out4 !== 0) begin
      dutpassed = 0;
      $display("Test 1 FAIL: 2 = %b, 4 = %b", out2, out4);
    end

    // Test 2: Port 1
    address2 = 1;
    address4 = 1;

    #20
    if (out2 !== 151 || out4 !== 151) begin
      dutpassed = 0;
      $display("Test 1 FAIL: 2 = %b, 4 = %b", out2, out4);
    end

    // Test 3: Port 2
    address4 = 2;

    #20
    if (out4 !== 56) begin
      dutpassed = 0;
      $display("Test 1 FAIL: 4 = %b", out4);
    end

    // Test 4: Port 3
    address4 = 3;

    #20
    if (out4 !== 3) begin
      dutpassed = 0;
      $display("Test 1 FAIL: 4 = %b", out4);
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
