module Program_Counter(
  input clk, reset, 
  input [63:0] PC_In, 
  output reg [63:0] PC_Out
);
  always @(posedge reset or posedge clk)
    begin
      //if signal is high, set PC_Out to 0
      if (reset)
        begin
          PC_Out = 0;
        end
      else
        //At posedge of clk, reflect value of PC_In to PC_Out
        begin
          PC_Out = PC_In;
        end
    end
endmodule
