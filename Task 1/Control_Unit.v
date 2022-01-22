module Control_Unit(
  input [6:0] Opcode,
  output reg [1:0] ALUOp,
  output reg Branch,MemRead,MemtoReg,MemWrite,ALUSrc,Regwrite);
  always @ (*)
    begin
      case (Opcode[6:0])
        7'b0110011:
          begin
            ALUSrc = 0;
            MemtoReg = 0;
            Regwrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b10;
          end
        7'b0000011:
          begin
            ALUSrc = 1;
            MemtoReg = 1;
            Regwrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
          end
        7'b0100011:
          begin
            ALUSrc = 1;
            MemtoReg = 1'bX;
            Regwrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 2'b00;
          end
        7'b1100011:
          begin //branch
            ALUSrc = 0;
            MemtoReg = 1'bX;
            Regwrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 2'b01;
          end
        7'b0010011:
          begin
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            Regwrite = 1'b1;
            ALUOp = 2'b00;
          end
        default:
          begin
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Regwrite = 1'b0;
            MemRead = 1'b0;
            MemWrite = 1'b0;
            Branch = 1'b0;
          	ALUOp = 2'b00;
          end
      endcase
    end
endmodule
 