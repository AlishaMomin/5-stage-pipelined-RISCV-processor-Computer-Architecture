module ALU_Control(
  input [1:0] ALUOp,
  input [3:0] Funct,
  output reg [3:0] Operation);

 always @(*)
    begin
      //performs operation according
      //to ALUop and funct
      case(ALUOp )
        2'b00: 
          case ({Funct[2:0]})
            3'b001: Operation = 4'b0111; //slli
            default: Operation = 4'b0010; //add etc.
          endcase
        2'b01:
          Operation = 4'b0110;
        2'b10 :
          case(Funct)
            4'b0000:
             Operation = 4'b0010;
            4'b1000:
             Operation = 4'b0110;
            4'b0111:
             Operation = 4'b0000;
            4'b0110:
             Operation = 4'b0001;
          endcase
      endcase
    end
endmodule