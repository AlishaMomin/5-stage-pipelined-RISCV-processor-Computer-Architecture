module Instruction_Memory(input [63:0] Inst_Address,
                          output reg [31:0] Instruction);
  reg [7:0] registers [15:0];
  initial 
    begin
 
// registers[15] = 8'b00000000;
// registers[14] = 8'b00000000;
// registers[13] = 8'b00000011;
// registers[12] = 8'b10110011;


//add x13, x5, x12 => 0000000|01100|00101|000|01101|0110011
registers[11] = 8'b00000000;
registers[10] = 8'b11000010;
registers[9] = 8'b10000110;
registers[8] = 8'b10110011;
      
//note these bits at address of 4
//sub x12. x19, x3 => 0100000|00011|10011|000|01100|0110011
registers[7] = 8'b01000000;
registers[6] = 8'b00111001;
registers[5] = 8'b10000110;
registers[4] = 8'b00110011;

//note these bits at address of 0
//add x19, x0, x1 => 0000000|00001|00000|000|10011|0110011
registers[3] = 8'b00000000;
registers[2] = 8'b00010000;
registers[1] = 8'b00001001;
registers[0] = 8'b10110011; 



//Opcodes, rd, rs1 and rs2 are made over here
//and then parsed in instruction_parseer
                 
    end                 
  always @(Inst_Address) 
    begin
      assign Instruction = {registers[Inst_Address+3], registers[Inst_Address+2],
       registers[Inst_Address+1], registers[Inst_Address]};
    end
endmodule