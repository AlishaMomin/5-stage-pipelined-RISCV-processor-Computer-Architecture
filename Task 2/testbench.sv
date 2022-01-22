// `timescale 1ns/1ps
module tb();
reg clk, reset;
  RISC_V_Processor rp(.clk(clk), .reset(reset));
initial
	begin
	clk = 0;
	reset = 0;
	#5;
	
	reset = 1;
	#5;
	
	reset = 0;
	#3;
	
	clk = ~clk;
	#3;
	
	#2;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;
	
	clk = ~clk;
	#10;	
     
   end
   initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars();  
    end
endmodule