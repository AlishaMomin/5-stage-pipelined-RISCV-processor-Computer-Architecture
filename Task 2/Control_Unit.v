module Control_Unit(
  
  input [6:0] Opcode,
  input [2:0] funct3,
  output reg [1:0]ALUOp,
  output reg BranchEq,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,BranchGt);
  
  always @(*)
    begin
      //outputs ALUop,BranchEq,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,BranchGt
      //according to the given input of opcode 
      case(Opcode)
        7'b0110011:
          begin
            ALUOp = 2'b10;
            BranchEq = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
            BranchGt = 1'b0;
          end
        7'b0000011:
          begin
              ALUOp = 2'b00;
              BranchEq = 1'b0;
              MemRead = 1'b1;
              MemtoReg = 1'b1;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              BranchGt = 1'b0;
            end
        7'b0100011:
          begin
              ALUOp = 2'b00;
              BranchEq = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'bx;//---
              MemWrite = 1'b1;
              ALUSrc = 1'b1;
              RegWrite = 1'b0;
              BranchGt = 1'b0;
            end
        7'b1100011:
          begin
              ALUOp = 2'b01;
              BranchEq = 1'b1;
              MemRead = 1'b0;
              MemtoReg = 1'bx; //--
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;
              BranchGt = 1'b0;
            end
          7'b0010011:
            begin
              ALUOp = 2'b00;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;
              if (funct3 == 3'b000)
                begin
                    BranchEq = 1'b1;
                    BranchGt = 1'b0;
                end
            else
                begin
                    BranchEq = 1'b0;
                    BranchGt = 1'b1;
                end
            end

      endcase
	end
endmodule
