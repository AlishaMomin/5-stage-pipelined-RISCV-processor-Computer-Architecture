module pc_counter(
	input [63:0] PC_In,
	input reset,clk,
	output reg [63:0] PC_Out
	
);
  always @(posedge reset or posedge clk)
    begin
      if (reset)
        PC_Out = 0;
      else
        PC_Out = PC_In;
    end
endmodule