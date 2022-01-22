module Data_Memory(
  input [63:0] Mem_Addr, 
  input [63:0] Write_Data,
  input clk, MemWrite, MemRead,
  output reg [63:0] Read_Data,
  output [63:0] element1,
  output [63:0] element2,
  output [63:0] element3,
  output [63:0] element4,
  output [63:0] element5,
  output [63:0] element6
//   output [63:0] element7,
//   output [63:0] element8
  
);
  reg [7:0] memory [63:0];
     initial
    begin
      for (int i = 0; i< 64; i= i+1)
        begin
          memory[i] = 0;
        end
      memory[0]= 8'h8;
      memory[8]= 8'h2;
      memory[16]= 8'h3;
      memory[24]= 8'h9;
      memory[32]= 8'h10;
      memory[40]= 8'h13;
//       memory[48]= 8'h5;
//       memory[56]= 8'h4;     
    end
  always @(posedge clk)
    begin
      if (MemWrite)
        begin
          memory[Mem_Addr] = Write_Data[7:0];
          memory[Mem_Addr + 1] = Write_Data[15:8]; 
          memory[Mem_Addr + 2] = Write_Data[23:16];
          memory[Mem_Addr + 3] = Write_Data[31:24];
          memory[Mem_Addr + 4] = Write_Data[39:32];
          memory[Mem_Addr + 5] = Write_Data[47:40];
          memory[Mem_Addr + 6] = Write_Data[55:48];
          memory[Mem_Addr + 7] = Write_Data[63:56];
        end
    end
  always @(*) begin
    if (MemRead)
      Read_Data = {memory[Mem_Addr + 7], memory[Mem_Addr + 6], memory[Mem_Addr + 5], memory[Mem_Addr + 4], memory[Mem_Addr + 3], memory[Mem_Addr + 2], memory[Mem_Addr + 1], memory[Mem_Addr]};
  end
      assign element1 = {memory[7], memory[6],memory[5],memory[4],memory[3],memory[2],memory[1],memory[0]};
      assign element2 = {memory[15] , memory[14], memory[13], memory[12], memory[11],memory[10], memory[9], memory[8]};
      assign element3 = {memory[23] ,memory[22],memory[21],memory[20],memory[19],memory[18],memory[17],memory[16]};
      assign element4 = {memory[31] , memory[30],memory[29],memory[28],memory[27],memory[26],memory[25],memory[24]};
      assign element5 = {memory[39] , memory[38],memory[37],memory[36],memory[35] ,memory[34],memory[33],memory[32]};
      assign element6 = {memory[47] ,memory[46],memory[45],memory[44],memory[43],memory[42],memory[41],memory[40]};
//       assign element7 = {memory[55],memory[54],memory[53],memory[52],memory[51],memory[50],memory[49],memory[48]};
//       assign element8 = {memory[63], memory[62],memory[61],memory[60],memory[59],memory[58],memory[57],memory[56]};
endmodule