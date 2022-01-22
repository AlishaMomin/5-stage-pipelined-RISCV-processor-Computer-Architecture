module ID_EX(
    input clk, reset,
    input [3:0] IF_ID_instruction,
	input [4:0] IF_ID_rd, IF_ID_rs1, IF_ID_rs2,
	input [63:0] IF_ID_ReadData1, IF_ID_ReadData2,
	input [63:0] IF_ID_imm_data, IF_ID_PC_Out,
	input [1:0] IF_ID_ALUOp,
    input IF_ID_ALUSrc,
	input IF_ID_BranchEq,
	input IF_ID_BranchGt,
	input IF_ID_MemRead,
	input IF_ID_MemWrite,
	input IF_ID_RegWrite,
	input IF_ID_MemtoReg,

    output reg [3:0] ID_EX_instruction,
	output reg [4:0] ID_EX_rd, ID_EX_rs2, ID_EX_rs1, 
	output reg [63:0] ID_EX_imm_data, ID_EX_ReadData2,
	output reg [63:0] ID_EX_ReadData1, ID_EX_PC_Out,
	output reg ID_EX_ALUSrc,
	output reg [1:0] ID_EX_ALUOp,
	output reg ID_EX_BranchEq,
	output reg ID_EX_BranchGt,
	output reg ID_EX_MemRead,
	output reg ID_EX_MemWrite,
	output reg ID_EX_RegWrite,
	output reg ID_EX_MemtoReg);

always@(posedge clk or posedge reset)
begin
    if(reset)
        begin
            ID_EX_instruction = 0;
			ID_EX_rs2 = 0;
			ID_EX_rs1 = 0;
            ID_EX_rd = 0;
			ID_EX_imm_data = 0;
			ID_EX_ReadData2 = 0;
			ID_EX_ReadData1 = 0;
			ID_EX_PC_Out = 0;
			ID_EX_ALUOp = 0;
            ID_EX_ALUSrc = 0;
            ID_EX_BranchEq = 0;
			ID_EX_MemRead = 0;
			ID_EX_MemWrite = 0;
			ID_EX_RegWrite = 0;
			ID_EX_MemtoReg = 0;
	        ID_EX_BranchGt = 0;
        end 
    else 
        begin
            ID_EX_instruction = IF_ID_instruction;
			ID_EX_rs2 = IF_ID_rs2;
			ID_EX_rs1 = IF_ID_rs1;
            ID_EX_rd = IF_ID_rd;
			ID_EX_imm_data = IF_ID_imm_data;
			ID_EX_ReadData2 = IF_ID_ReadData2;
			ID_EX_ReadData1 = IF_ID_ReadData1;
			ID_EX_PC_Out = IF_ID_PC_Out;
			ID_EX_ALUOp = IF_ID_ALUOp;
            ID_EX_ALUSrc = IF_ID_ALUSrc;
            ID_EX_BranchEq = IF_ID_BranchEq;
			ID_EX_MemRead = IF_ID_MemRead;
			ID_EX_MemWrite = IF_ID_MemWrite;
			ID_EX_RegWrite = IF_ID_RegWrite;
			ID_EX_MemtoReg = IF_ID_MemtoReg;
	        ID_EX_BranchGt = IF_ID_BranchGt;
        end
end
endmodule