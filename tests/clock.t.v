//-------------------------------
// Clock Test
//-------------------------------

module testClock;
  wire clk;
  reg dutpassed;

  clock clocker(clk);

  initial begin
    $dumpfile("clock.vcd"); //dump info to create wave propagation later
    $dumpvars(0, testClock);

    $display("Testing clock");

    dutpassed = 1;

    #5
    if (clk !== 0) begin
      dutpassed = 0;
      $display("Test 1 FAIL: %b", clk);
    end

    #10
    if (clk !== 1) begin
      dutpassed = 0;
      $display("Test 2 FAIL: %b", clk);
    end


    #20
    if (clk !== 1) begin
      dutpassed = 0;
      $display("Test 3 FAIL: %b", clk);
    end

    #10
    if (clk !== 0) begin
      dutpassed = 0;
      $display("Test 4 FAIL: %b", clk);
    end

    if (dutpassed == 1) begin
      $display("Clk Tests Passed");
    end
    else begin
      $display("Clk Tests Failed");
    end
    $display();
    $finish;

  end

endmodule
