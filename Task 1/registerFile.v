module registerFile (
    input clk, reset, RegWrite,
    input [63:0] WriteData,
    input [4:0] RS1, RS2, RD,
    output reg [63:0] ReadData1, ReadData2
);
  reg[63:0] Registers[31:0];
 
  initial
    begin
      for (int i = 0 ; i < 32; i++)
        begin
          Registers[i]   = 64'b0;
        end
      Registers[11] = 64'd6;
    end
 
  always @(posedge clk)
    begin
      if (RegWrite == 1'b1)
        Registers[RD] = WriteData;
    end
 
  always @(*)
    begin
      if (reset == 1'b1)
        begin
          ReadData1 = 64'b0;
          ReadData2 = 64'b0;
        end
      else
        begin
          ReadData1 = Registers[RS1];
          ReadData2 = Registers[RS2];
        end
    end
endmodule