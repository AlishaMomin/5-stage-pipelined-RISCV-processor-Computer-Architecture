module alu_64(
	input [63:0] a, 
    input [63:0] b,
    input [3:0] ALUOp,
    input [2:0] funct,
	output reg [63:0] Result,
	output reg equal
);
  always @(*)
    begin
      //generates result according 
      //to the given input ALUop
      case(ALUOp) 
        4'b0000: Result = a & b;
        4'b0001: Result = a | b;
        4'b0010: Result = a + b ; 
        4'b0110:
          if (a>b)
              Result = a - b;
        else
          Result = b - a;
        4'b1100: Result = ~(a|b);
        4'b0111: Result = a << b;
        
      endcase
      
      if ( Result==64'b0 & funct == 3'b000)   //beq     //if equal
		begin
			equal = 1'b1;
		end
      else if ((a>=b) & funct == 3'b101) 
		begin
			equal = 1'b1; 

		end
      else
        equal =0;
    end
  
endmodule