module tb();
  reg clk, reset;
  RISC_V_Processor r(.clk(clk),.reset(reset));
 initial 
 
 begin 
  
  clk = 1'b0; 
   
  reset = 1'b1; 
   
  #10 reset = 1'b0; 
 end 
  
  
always  
 
 #5 clk = ~clk;
  initial
    begin
     $dumpfile("dump.vcd");
     $dumpvars();
      #8000
      $finish;
    end
endmodule