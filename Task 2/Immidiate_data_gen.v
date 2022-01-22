module Immidiate_data_gen(
  input [31:0]instruction,
  output reg [63:0] imm_data);
  
  //add x19, x0, x1 => 0000000|00001|00000|000|10011|0110011 => 000000001100
//sub x12. x19, x3 => 0100000|00011|10011|000|01100|0110011
 reg [11:0] temp;
  wire [51:0] temp2;
  always @(*)
    begin
      case(instruction[6:5])
        2'b00: //I
        begin
          temp = instruction[31:20];
        end
        2'b01: //S
        begin
          temp = {instruction[31:25],instruction[11:7]};
        end
        2'b11:  //beq
        begin
          temp = {instruction[31],instruction[7], instruction[30:25],instruction[11:8] };
        end
      endcase
    end
  
endmodule