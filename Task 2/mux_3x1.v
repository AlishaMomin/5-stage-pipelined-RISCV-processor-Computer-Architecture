module mux_3x1(
	input [63:0]a, b, c,
	input [1:0]sel,
    output [63:0] data_out
);
  
  reg [63:0] r;
  
  always @(*) 
      begin
        if (sel==00)
            r = a;
        
        else if (sel==01)
            r = b;
        
        else if (sel==2)
            r = c;
        
    end
    assign data_out=r;
  
endmodule 