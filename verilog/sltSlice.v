module sltSlice(
    output out,
    output keepLookingOut, // 1 if this bit pair and all more significant
                           // bit pairs are equal
    output ansOut, // SLT answer, if determined before or within this block
    input keepLookingIn, // 1 if all more significant bit pairs are equal
    input ansIn, // SLT answer, if determined before this block
    input a,
    input b,
    input first // 1 if this is the first bit slice
);

    // Keep looking if A and B are equal and we haven't already stopped looking
    wire AxnorB, logicalKOut;
    xnor(AxnorB, a, b);
    and(logicalKOut, AxnorB, keepLookingIn);

    // Hand keepLookingIn straight through to keepLookingOut if first block
    wire notFirst, notFirstCaseAns, firstCaseAns;
    not(notFirst, first);
    and(notFirstCaseAns, notFirst, logicalKOut);
    and(firstCaseAns, first, keepLookingIn);
    or(keepLookingOut, notFirstCaseAns, firstCaseAns);

    // ansOut=1 if A=0 and B=1 and we haven't already stopped looking, or if
    // we already determined ans=1.
    wire notA;
    wire notAandBandKin;
    not(notA, a);
    and(notAandBandKin, notA, b, keepLookingIn);
    or(ansOut, notAandBandKin, ansIn);

    // Always output 0
    buf(out, 1'b0);

endmodule
