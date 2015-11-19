//-------------------------------
// Data Memory Test
//-------------------------------

module testControlTable;

    reg [5:0]     op;
    reg [5:0]     funct;
    wire [1:0] pc_next;
    wire [1:0] reg_dst;
    wire alu_src;
    wire [1:0] alu_ctrl;
    wire reg_we;
    wire [1:0] reg_in;
    wire mem_we;
    wire beq;
    wire bne;

    reg dutpassed;

    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter j = 6'b000010;
    parameter jal = 6'b000011;
    parameter beq_code = 6'b000100;
    parameter bne_code = 6'b000101;
    parameter xori = 6'b001110;
    parameter alu = 6'b000000;

    parameter add = 6'b100000;
    parameter sub = 6'b100010;
    parameter slt = 6'b101010;
    parameter jr = 6'b001000;

    // System Clock
    wire clkOut;
    clock clk(clkOut);

    controlTable DUT(clkOut, op, funct, pc_next, reg_dst, alu_src, alu_ctrl,
                     reg_we, reg_in, mem_we, beq, bne);

    initial begin
        $dumpfile("controlTable.vcd"); //dump info to create wave propagation later
        $dumpvars(0, testControlTable);

        $display("Testing controlTable");


        dutpassed = 1;

        op = alu;
        funct = add;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'b1 || alu_src !== 1'b1 || alu_ctrl !== 2'b0 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("ADD Test failed");
        end

        funct = sub;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'b1 || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("SUB Test failed");
        end

        funct = slt;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'b1 || alu_src !== 1'b1 || alu_ctrl !== 2'b11 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("SLT Test failed");
        end

        funct = jr;
        #30
        if (pc_next !== 2'b10 || reg_dst !== 2'bx || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("JR Test failed");
        end

        op = lw;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'b0 || alu_src !== 1'b0 || alu_ctrl !== 2'b0 || reg_we !== 1'b1 || reg_in !== 2'b1 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("LW Test failed");
        end

        op = sw;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'bx || alu_src !== 1'b0 || alu_ctrl !== 2'b0 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b1 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("SW Test failed");
        end

        op = j;
        #30
        if (pc_next !== 2'b1 || reg_dst !== 2'bx || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("J Test failed");
        end

        op = jal;
        #30
        if (pc_next !== 2'b1 || reg_dst !== 2'b10 || alu_src !== 1'bx || alu_ctrl !== 2'bx || reg_we !== 1'b1 || reg_in !== 2'b10 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("JAL Test failed");
        end

        op = beq_code;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'bx || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b1 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("BEQ Test failed");
        end

        op = bne_code;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'bx || alu_src !== 1'b1 || alu_ctrl !== 2'b1 || reg_we !== 1'b0 || reg_in !== 2'bx || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b1) begin
            dutpassed = 0;
            $display("BNE Test failed");
        end

        op = xori;
        #30
        if (pc_next !== 2'b0 || reg_dst !== 2'b0 || alu_src !== 1'b0 || alu_ctrl !== 2'b10 || reg_we !== 1'b1 || reg_in !== 2'b0 || mem_we !== 1'b0 || beq !== 1'b0 || bne !== 1'b0) begin
            dutpassed = 0;
            $display("XORI Test failed");
        end

        if (dutpassed == 1) begin
            $display("ControlTable Tests Passed");
        end

        else begin
            $display("ControlTable Tests Failed");
        end
        $display();
        $finish;

    end

endmodule
