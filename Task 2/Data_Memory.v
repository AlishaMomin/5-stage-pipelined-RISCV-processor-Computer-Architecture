module Data_Memory(
  input clk, 
  input MemWrite, MemRead,
  input [63:0] MemAdd,WriteData,
  output reg [63:0] ReadData1);
  reg [7:0] memory [63:0];
  integer i;
  integer j;
  initial 
    begin
      for (i=0; i<64; i=i+1)
        begin j = $urandom%100;
          memory[i] = j; 
          $display("data = ", j,"mem = ",i);
       end 
    end 
  always @(*)
    begin 
      if (MemRead) //if 1, reads the data from the memory
        begin 
          ReadData1[7:0] = memory[MemAdd+0];
          ReadData1[15:8] = memory[MemAdd+1];
          ReadData1[23:16] = memory[MemAdd+2];
          ReadData1[31:24] = memory[MemAdd+3];
          ReadData1[39:32] = memory[MemAdd+4];
          ReadData1[47:40] = memory[MemAdd+5];
          ReadData1[55:48] = memory[MemAdd+6];
          ReadData1[63:56] = memory[MemAdd+7];
        end
    end
  always @(posedge clk)
    begin 
      if (MemWrite) //if 1, writes the data in the memory
        begin
          memory[MemAdd] = WriteData[7:0];
          memory[MemAdd+1] = WriteData[15:8];
          memory[MemAdd+2] = WriteData[23:16];
          memory[MemAdd+3] = WriteData[31:24];
          memory[MemAdd+4] = WriteData[39:32];
          memory[MemAdd+5] = WriteData[47:40];
          memory[MemAdd+6] = WriteData[55:48];
          memory[MemAdd+7] = WriteData[63:56];
        end
    end
endmodule