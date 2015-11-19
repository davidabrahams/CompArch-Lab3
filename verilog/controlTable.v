//------------------------------------------------------------------------
// Control table
// Sets Control signals based on Op Code
//------------------------------------------------------------------------

module controlTable
(
    input           clk,
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



always @ (posedge clk or op or funct) begin

  case (op)

    alu: begin

      case (funct)

        add: begin

           pc_next = 2'b0;
           reg_dst = 2'b1;
           alu_src = 1'b1;
           alu_ctrl = 2'b0;
           reg_we = 1'b1;
           reg_in = 2'b0;
           mem_we = 1'b0;
           beq = 1'b0;
           bne = 1'b0;

        end

        sub: begin

           pc_next = 2'b0;
           reg_dst = 2'b1;
           alu_src = 1'b1;
           alu_ctrl = 2'b1;
           reg_we = 1'b1;
           reg_in = 2'b0;
           mem_we = 1'b0;
           beq = 1'b0;
           bne = 1'b0;

        end

        slt: begin

           pc_next = 2'b0;
           reg_dst = 2'b1;
           alu_src = 1'b1;
           alu_ctrl = 2'b11;
           reg_we = 1'b1;
           reg_in = 2'b0;
           mem_we = 1'b0;
           beq = 1'b0;
           bne = 1'b0;

        end

        jr: begin

           pc_next = 2'b10;
           reg_dst = 2'bx;
           alu_src = 1'bx;
           alu_ctrl = 2'bx;
           reg_we = 1'b0;
           reg_in = 2'bx;
           mem_we = 1'b0;
           beq = 1'b0;
           bne = 1'b0;

        end

        default: begin

          $display("********* default alu **********");
           pc_next = 2'b0;
           reg_dst = 2'bx;
           alu_src = 1'bx;
           alu_ctrl = 2'bx;
           reg_we = 1'b0;
           reg_in = 2'bx;
           mem_we = 1'b0;
           beq = 1'b0;
           bne = 1'b0;

        end

      endcase

    end

    lw: begin

       pc_next = 2'b0;
       reg_dst = 2'b0;
       alu_src = 1'b0;
       alu_ctrl = 2'b0;
       reg_we = 1'b1;
       reg_in = 2'b1;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b0;

    end

    sw: begin

       pc_next = 2'b0;
       reg_dst = 2'bx;
       alu_src = 1'b0;
       alu_ctrl = 2'b0;
       reg_we = 1'b0;
       reg_in = 2'bx;
       mem_we = 1'b1;
       beq = 1'b0;
       bne = 1'b0;

    end

    j: begin

       pc_next = 2'b1;
       reg_dst = 2'bx;
       alu_src = 1'bx;
       alu_ctrl = 2'bx;
       reg_we = 1'b0;
       reg_in = 2'bx;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b0;

    end

    jal: begin

       pc_next = 2'b1;
       reg_dst = 2'b10;
       alu_src = 1'bx;
       alu_ctrl = 2'bx;
       reg_we = 1'b1;
       reg_in = 2'b10;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b0;

    end

    beq_code: begin

       pc_next = 2'b0;
       reg_dst = 2'bx;
       alu_src = 1'b1;
       alu_ctrl = 2'b1;
       reg_we = 1'b0;
       reg_in = 2'bx;
       mem_we = 1'b0;
       beq = 1'b1;
       bne = 1'b0;

    end

    bne_code: begin

       pc_next = 2'b0;
       reg_dst = 2'bx;
       alu_src = 1'b1;
       alu_ctrl = 2'b1;
       reg_we = 1'b0;
       reg_in = 2'bx;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b1;

    end

    xori: begin

       pc_next = 2'b0;
       reg_dst = 2'b0;
       alu_src = 1'b0;
       alu_ctrl = 2'b10;
       reg_we = 1'b1;
       reg_in = 2'b0;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b0;

    end

    default: begin

      /*$display("********* default **********");*/
       pc_next = 2'b0;
       reg_dst = 2'bx;
       alu_src = 1'bx;
       alu_ctrl = 2'bx;
       reg_we = 1'b0;
       reg_in = 2'bx;
       mem_we = 1'b0;
       beq = 1'b0;
       bne = 1'b0;

    end

  endcase
    /*$display("pc_next: %b", pc_next);
    $display("op: %b", op);*/

end

endmodule
