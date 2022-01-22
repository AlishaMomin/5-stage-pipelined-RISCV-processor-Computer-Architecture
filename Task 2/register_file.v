module registerFile 
  (input clk, reset,  
   input [63:0]WriteData,  
   input [4:0]rs1, rs2, rd,  
   input RegWrite, 
   output reg [63:0]ReadData1,ReadData2 
  );
  reg [63:0] Registers [31:0];
  initial    
    begin    
      Registers[0] = 64'd0;
      Registers[1] = 64'd10;
      Registers[2] = 64'd2;
      Registers[3] = 64'd3;
      Registers[4] = 64'd4;
      Registers[5] = 64'd5;
      Registers[6] = 64'd6;
      Registers[7] = 64'd7;
      Registers[8] = 64'd8;
      Registers[9] = 64'd9;
      Registers[10] = 64'd10;
      Registers[11] = 64'd11;
      Registers[12] = 64'd12;
      Registers[13] = 64'd13;
      Registers[14] = 64'd14;
      Registers[15] = 64'd15;
      Registers[16] = 64'd16;
      Registers[17] = 64'd17;
      Registers[18] = 64'd18;
      Registers[19] = 64'd19;
      Registers[20] = 64'd20;
      Registers[21] = 64'd21;
      Registers[22] = 64'd22;
      Registers[23] = 64'd23;
      Registers[24] = 64'd24;
      Registers[25] = 64'd25;
      Registers[26] = 64'd26;
      Registers[27] = 64'd27;
      Registers[28] = 64'd28;
      Registers[29] = 64'd29;
      Registers[30] = 64'd30;
      Registers[31] = 64'd31;   
    end 
 //Data writing in register should always be done when positive edge of clock 
//   and RegWrite signal is asserted (or set, i.e. High)(in pdf)
  always @ (posedge clk) 
    begin   
      case(RegWrite)  //if we have to write the data
        1'b1 : 
          Registers[rd] <= WriteData;   
      endcase  
    end 
  always @(*)  
    begin   
      if(reset)  
        begin //reset = 1
          ReadData1 = 64'b0;    
          ReadData2 = 64'b0;   
        end   
      else   //if we have to read the data
        begin    
          ReadData1 = Registers[rs1];    
          ReadData2 = Registers[rs2];   
        end  
    end  
endmodule 
