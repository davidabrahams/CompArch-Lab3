module fullAdder(
   output out,
   output addCarryout,
   input a,
   input b,
   input addCarryIn
);

    wire AxorB, fullAnd, AandB;

    xor(AxorB, a, b);
    and(AandB, a, b);
    and(fullAnd, addCarryIn, AxorB);

    xor(out, AxorB, addCarryIn);
    xor(addCarryout, AandB, fullAnd);

endmodule
