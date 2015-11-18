//------------------------------------------------------------------------
// Clock module
//   Flips output every cycle
//------------------------------------------------------------------------

module clock
#(
  parameter cyclelength = 10
)
(
  output reg clk
);

  initial begin
    clk = 0; 
  end

  always #cyclelength clk = !clk;

endmodule
