module mux2
(
output[31:0]   out,
input          address,
input[31:0]    input0, input1
);

  wire[31:0] mux[1:0];

  assign mux[0] = input0;
  assign mux[1] = input1;
  assign out = mux[address];
endmodule

module mux4
(
output[31:0]    out,
input[1:0]      address,
input[31:0]     input0, input1, input2, input3
);

  wire[31:0] mux[3:0];         // Create a 2D array of wires

  assign mux[0] = input0;       // Connect the sources of the array
  assign mux[1] = input1;
  assign mux[2] = input2;
  assign mux[3] = input3;
  assign out = mux[address];    // Connect the output of the array
endmodule

module multiplexer(
    output out,
    input[2:0] address,
    input[7:0] in
);

    wire[2:0] naddress;
    wire[7:0] outputs;

    not(naddress[0], address[0]);
    not(naddress[1], address[1]);
    not(naddress[2], address[2]);

    and(outputs[0], naddress[2], naddress[1], naddress[0], in[0]);
    and(outputs[1], naddress[2], naddress[1], address[0], in[1]);
    and(outputs[2], naddress[2], address[1], naddress[0], in[2]);
    and(outputs[3], naddress[2], address[1], address[0], in[3]);
    and(outputs[4], address[2], naddress[1], naddress[0], in[4]);
    and(outputs[5], address[2], naddress[1], address[0], in[5]);
    and(outputs[6], address[2], address[1], naddress[0], in[6]);
    and(outputs[7], address[2], address[1], address[0], in[7]);

    or(out, outputs[7], outputs[6], outputs[5], outputs[4], outputs[3], outputs[2], outputs[1], outputs[0]);

endmodule
