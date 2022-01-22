module forwarding_Unit(
    input [4:0] ID_EX_rs1, ID_EX_rs2,
	input [4:0] EX_MEM_rd,
	input EX_MEM_RegWrite,
	input [4:0] MEM_WB_rd,
	input MEM_WB_RegWrite,
  output reg [1:0] forward_A, forward_B

);
  always @(*)
      begin
        //For forward A
         //Example--> add x19, x0, x1 (x19 (rd) in EX/MEM) and sub x12. x19, x3 (x19 (rs1)in ID/EX)
        //add x19, x0, x1 => 0000000|00001|00000|000|10011|0110011
        //sub x12. x19, x3 => 0100000|00011|10011|000|01100|0110011
        if (EX_MEM_rd != 0 && EX_MEM_RegWrite == 1 && EX_MEM_rd == ID_EX_rs1)
            forward_A = 2'b10;
        
		else if (MEM_WB_RegWrite == 1 && MEM_WB_rd != 0 && MEM_WB_rd == ID_EX_rs1 && !(EX_MEM_RegWrite == 1 && EX_MEM_rd == ID_EX_rs1 && EX_MEM_rd != 0))
			forward_A = 2'b01;
        
		else
			forward_A = 2'b00;
		
        //For forward B
        if (EX_MEM_rd != 0 && EX_MEM_RegWrite == 1 && EX_MEM_rd == ID_EX_rs2)
            forward_B = 2'b10;
        
        else if (MEM_WB_RegWrite == 1 && MEM_WB_rd != 0 && MEM_WB_rd == ID_EX_rs2 && !(EX_MEM_RegWrite == 1 && EX_MEM_rd == ID_EX_rs2 && EX_MEM_rd != 0))
        	forward_B = 2'b01;
        
        else 
            forward_B = 2'b00;
        
      end
endmodule