module ALU_64_bit (
  input [63:0] a,
  input [63:0] b,
  input [3:0] ALUop, 
  output reg [63:0]Result, 
  output reg zero,
  output reg Great
);

  always @(*)
    begin
      //generates result according 
      //to the given input ALUop
      case(ALUop) 
        4'b0000: Result = a & b;
        4'b0001: Result = a | b;
        4'b0010: Result = a + b ; 
        4'b0110: Result = a - b;
        4'b1100: Result = ~(a|b);
      endcase
      if (Result == 0)
      	zero = 1;
      else
      	zero = 0;

      if (Result > 64'd0)
		begin
			Great = 1'b1;
		end
	else
		begin
			Great = 1'b0;
		end
    end

endmodule
