module ALU_Control(
  input [1:0] ALUOp,
  input [3:0] Funct,
  output reg [3:0] Operation,
  output reg [2:0] FunctOut
);

 always @(*)
    begin
      // it will perform the operations acc to ALUOp and Funct
      case(ALUOp )
        2'b00: // I/S-type
          case ({Funct[2:0]})
            3'b001: Operation = 4'b0111; //slli
            default: Operation = 4'b0010; //add (r-type)etc.
          endcase
        2'b01: // sb-type
          Operation = 4'b0110;   //beq, bne
      	  
        2'b10 : // r-type
          case(Funct)
            4'b0000:
             Operation = 4'b0010; //add
            4'b1000:
             Operation = 4'b0110; //sub
            4'b0111:
             Operation = 4'b0000;
            4'b0110:
             Operation = 4'b0001;
          endcase
      endcase
      FunctOut = Funct[2:0];
    end
endmodule
