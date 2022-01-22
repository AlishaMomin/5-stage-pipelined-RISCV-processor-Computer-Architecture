module mux_2x1
  (input [63:0] a,b,
   input sel,
   output reg [63:0] data_out);
    reg [63:0] n;
always@* begin
if (sel == 0)
	n = a;
else if (sel ==1)
	n = b;
end
assign data_out = n;
 
endmodule