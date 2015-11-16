//------------------------------------------------------------------------
// Control table
// Sets Control signals based on Op Code
//------------------------------------------------------------------------

module controlTable
(
    input [5:0]     op,
    input [5:0]     funct,
    output reg [1:0] pc_next,
    output reg [1:0] reg_dst,
    output reg alu_src,
    output reg [1:0] alu_ctrl,
    output reg reg_we,
    output reg [1:0] reg_in,
    output reg mem_we,
    output reg beq,
    output reg bne
);

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

always @ (op or funct) begin

  case (op)

    alu: begin

      case (funct)

        add: begin

          assign pc_next = 2'b0;
          assign reg_dst = 2'b1;
          assign alu_src = 1'b1;
          assign alu_ctrl = 2'b0;
          assign reg_we = 1'b1;
          assign reg_in = 2'b0;
          assign mem_we = 1'b0;
          assign beq = 1'b0;
          assign bne = 1'b0;

        end

        sub: begin

          assign pc_next = 2'b0;
          assign reg_dst = 2'b1;
          assign alu_src = 1'b1;
          assign alu_ctrl = 2'b1;
          assign reg_we = 1'b1;
          assign reg_in = 2'b0;
          assign mem_we = 1'b0;
          assign beq = 1'b0;
          assign bne = 1'b0;

        end

        slt: begin

          assign pc_next = 2'b0;
          assign reg_dst = 2'b1;
          assign alu_src = 1'b1;
          assign alu_ctrl = 2'b11;
          assign reg_we = 1'b1;
          assign reg_in = 2'b0;
          assign mem_we = 1'b0;
          assign beq = 1'b0;
          assign bne = 1'b0;

        end

        jr: begin

          assign pc_next = 2'b10;
          assign reg_dst = 2'bx;
          assign alu_src = 1'bx;
          assign alu_ctrl = 2'bx;
          assign reg_we = 1'b0;
          assign reg_in = 2'bx;
          assign mem_we = 1'b0;
          assign beq = 1'b0;
          assign bne = 1'b0;

        end

      endcase

    end

    lw: begin

      assign pc_next = 2'b0;
      assign reg_dst = 2'b0;
      assign alu_src = 1'b0;
      assign alu_ctrl = 2'b0;
      assign reg_we = 1'b1;
      assign reg_in = 2'b1;
      assign mem_we = 1'b0;
      assign beq = 1'b0;
      assign bne = 1'b0;

    end

    sw: begin

      assign pc_next = 2'b0;
      assign reg_dst = 2'bx;
      assign alu_src = 1'b0;
      assign alu_ctrl = 2'b0;
      assign reg_we = 1'b0;
      assign reg_in = 2'bx;
      assign mem_we = 1'b1;
      assign beq = 1'b0;
      assign bne = 1'b0;

    end

    j: begin

      assign pc_next = 2'b1;
      assign reg_dst = 2'bx;
      assign alu_src = 1'bx;
      assign alu_ctrl = 2'bx;
      assign reg_we = 1'b0;
      assign reg_in = 2'bx;
      assign mem_we = 1'b0;
      assign beq = 1'b0;
      assign bne = 1'b0;

    end

    jal: begin

      assign pc_next = 2'b1;
      assign reg_dst = 2'b10;
      assign alu_src = 1'bx;
      assign alu_ctrl = 2'bx;
      assign reg_we = 1'b1;
      assign reg_in = 2'b10;
      assign mem_we = 1'b0;
      assign beq = 1'b0;
      assign bne = 1'b0;

    end

    beq_code: begin

      assign pc_next = 2'b0;
      assign reg_dst = 2'bx;
      assign alu_src = 1'b1;
      assign alu_ctrl = 2'b1;
      assign reg_we = 1'b0;
      assign reg_in = 2'bx;
      assign mem_we = 1'b0;
      assign beq = 1'b1;
      assign bne = 1'b0;

    end

    bne_code: begin

      assign pc_next = 2'b0;
      assign reg_dst = 2'bx;
      assign alu_src = 1'b1;
      assign alu_ctrl = 2'b1;
      assign reg_we = 1'b0;
      assign reg_in = 2'bx;
      assign mem_we = 1'b0;
      assign beq = 1'b0;
      assign bne = 1'b1;

    end

    xori: begin

      assign pc_next = 2'b0;
      assign reg_dst = 2'b0;
      assign alu_src = 1'b0;
      assign alu_ctrl = 2'b10;
      assign reg_we = 1'b1;
      assign reg_in = 2'b0;
      assign mem_we = 1'b0;
      assign beq = 1'b0;
      assign bne = 1'b0;

    end

  endcase

end

endmodule
