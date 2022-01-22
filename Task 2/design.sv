`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Data_Memory.v"
`include "Instruction_parser.v"
`include "ALU_64_bit.v"
`include "register_file.v"
`include "Control_Unit.v"
`include "ALU_Control.v"
`include "adder.v"
`include "mux_2x1.v"
`include "Immidiate_data_gen.v"
`include "Forwarding_Unit.v"
`include "mux_3x1.v"
`include "IF_ID.v"
`include "EX_MEM.v"
`include "ID_EX.v"
`include "MEM_WB.v"

module RISC_V_Processor(
    input clk, reset

);

wire [31:0] Instruction; 
wire [63:0] PC_Out, PC_4_Adder, MUX_Branch;
wire [2:0] func3; 
wire [6:0] func7; 

//IF_ID
wire [31:0] IF_ID_Instruction;
wire [63:0] IF_ID_PC_Out; 
wire [6:0] IF_ID_opcode; 
wire [4:0] IF_ID_rs1, IF_ID_rs2, IF_ID_rd;
wire [63:0] IF_ID_ReadData1, IF_ID_ReadData2, IF_ID_immdata; 
wire [1:0] IF_ID_ALUOp;
wire IF_ID_ALUSrc, IF_ID_MemRead, IF_ID_MemWrite, IF_ID_RegWrite, IF_ID_MemtoReg, IF_ID_BranchEq, IF_ID_BranchGt;

//ID_EX
wire [3:0] ID_EX_Instruction;
wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
wire [63:0] ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_immdata, ID_EX_PC_Out;
wire [1:0] ID_EX_ALUOp;
wire ID_EX_ALUSrc, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_BranchEq, ID_EX_BranchGt, ID_EX_zero, ID_EX_Great;
wire [3:0] ID_EX_Operation;
wire [1:0] ID_EX_ForwardA, ID_EX_ForwardB;
wire [63:0] ID_EX_Adder_Branch, ID_EX_MUX_to_Adder, ID_EX_MUX_ForwardA, ID_EX_MUX_ForwardB, ID_EX_ALU_Main;

//MEM_WB
wire [4:0] MEM_WB_rd;
wire [63:0] MEM_WB_ALU_Main, MEM_WB_ReadData, MEM_WB_MUX_out;
wire MEM_WB_RegWrite, MEM_WB_MemtoReg;

//EX_MEM
wire [4:0] EX_MEM_rd;		
wire [63:0] EX_MEM_MUX_out, EX_MEM_ALU_Main, EX_MEM_Adder_Branch, EX_MEM_ReadData, MUX_BranchG;
wire EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_BranchEq, EX_MEM_BranchGt, EX_MEM_zero, EX_MEM_Great;



//Initalising modules

Program_Counter ProgCounter
(
	.clk(clk),
	.reset(reset),
	.PC_In(MUX_BranchG),
	.PC_Out(PC_Out)
);

Instruction_Memory InstrucMem
(
	.Inst_Address(PC_Out),
	.Instruction(Instruction)
);

Instruction_parser InstrucPar
(
	.instruction(IF_ID_Instruction),
	.opcode(IF_ID_opcode),
	.rd(IF_ID_rd),
	.func3(func3),
	.rs1(IF_ID_rs1),
	.rs2(IF_ID_rs2),
	.func7(func7)
);
  
registerFile regFile
(
	.clk(clk),
	.reset(reset),
	.WriteData(MEM_WB_MUX_out),
	.rs1(IF_ID_rs1),
	.rs2(IF_ID_rs2),
	.rd(MEM_WB_rd),
	.RegWrite(MEM_WB_RegWrite),
	.ReadData1(IF_ID_ReadData1),
	.ReadData2(IF_ID_ReadData2)
);
  
Immidiate_data_gen ImmDataGen
(
	.instruction(IF_ID_Instruction),
	.imm_data(IF_ID_immdata)
);
 
  

Control_Unit ContU
(
  	.Opcode(IF_ID_opcode),
	.funct3(func3),
  	.ALUOp(IF_ID_ALUOp),
	.BranchEq(IF_ID_BranchEq),
	.MemRead(IF_ID_MemRead),
	.MemtoReg(IF_ID_MemtoReg),
	.MemWrite(IF_ID_MemWrite),
	.ALUSrc(IF_ID_ALUSrc),
    .RegWrite(IF_ID_RegWrite),
  	.BranchGt(IF_ID_BranchGt)
);
  
ALU_Control ALUCont
(
	.ALUOp(ID_EX_ALUOp),
	.Funct(ID_EX_Instruction),
	.Operation(ID_EX_Operation)
);
  
Data_Memory DataMem
(
	.clk(clk),
	.MemWrite(EX_MEM_MemWrite),
	.MemRead(EX_MEM_MemRead),
	.MemAdd(EX_MEM_ALU_Main),
	.WriteData(EX_MEM_MUX_out),
	.ReadData1(EX_MEM_ReadData)
);
  
adder ALU_4_PC
(
	.a(PC_Out),
	.b(64'd4),
	.out(PC_4_Adder)
);

adder ALUBranch
(
	.a(ID_EX_PC_Out),
	.b(ID_EX_immdata << 1),
	.out(ID_EX_Adder_Branch)
);
  
ALU_64_bit ALUMain
(
	.a(ID_EX_MUX_ForwardA),
	.b(ID_EX_MUX_to_Adder),
	.ALUop(ID_EX_Operation),
	.Result(ID_EX_ALU_Main),
  .zero(ID_EX_zero),
	.Great(ID_EX_Great)
);
  


mux_2x1 MUX_B
(
	.a(PC_4_Adder),
	.b(EX_MEM_Adder_Branch),
    .sel(EX_MEM_BranchEq & EX_MEM_zero),
	.data_out(MUX_Branch)
);

mux_2x1 MUX_BG
(
	.a(MUX_Branch),
	.b(EX_MEM_Adder_Branch),
	.sel(EX_MEM_BranchGt & EX_MEM_Great),
	.data_out(MUX_BranchG)
);

mux_2x1 MUX_ID_EX
(
    .a(ID_EX_MUX_ForwardB),
	.b(ID_EX_immdata),
	.sel(ID_EX_ALUSrc),
	.data_out(ID_EX_MUX_to_Adder)
);

mux_2x1 MUX_MEM_WB
(
	.a(MEM_WB_ALU_Main),
	.b(MEM_WB_ReadData),
	.sel(MEM_WB_MemtoReg),
	.data_out(MEM_WB_MUX_out)
);

mux_3x1 MUX_ForwardA
(
	.a(ID_EX_ReadData1),
	.b(MEM_WB_MUX_out),
	.c(EX_MEM_ALU_Main),
	.sel(ID_EX_ForwardA),
	.data_out(ID_EX_MUX_ForwardA)
);

mux_3x1 MUX_ForwardB
(
	.a(ID_EX_ReadData2),
	.b(MEM_WB_MUX_out),
	.c(EX_MEM_ALU_Main),
	.sel(ID_EX_ForwardB),
	.data_out(ID_EX_MUX_ForwardB)
);


forwarding_Unit ForwardU
(
	.ID_EX_rs1(ID_EX_rs1),
	.ID_EX_rs2(ID_EX_rs2),
	.EX_MEM_rd(EX_MEM_rd),
	.EX_MEM_RegWrite(EX_MEM_RegWrite),
	.MEM_WB_rd(MEM_WB_rd),
	.MEM_WB_RegWrite(MEM_WB_RegWrite),
	.forward_A(ID_EX_ForwardA),
	.forward_B(ID_EX_ForwardB)
);
 
IF_ID IF_ID
(
	.clk(clk),
	.reset(reset),
	.instruction(Instruction),
	.PC_Out(PC_Out),

	.IF_ID_instruction(IF_ID_Instruction),
	.IF_ID_PC_Out(IF_ID_PC_Out)
); 

ID_EX ID_EX
(
	.clk(clk),
	.reset(reset),
	.IF_ID_instruction({IF_ID_Instruction[30], IF_ID_Instruction[14:12]}),
	.IF_ID_rd(IF_ID_rd), 
	.IF_ID_rs1(IF_ID_rs1),
	.IF_ID_rs2(IF_ID_rs2),
	.IF_ID_ReadData1(IF_ID_ReadData1),
  	.IF_ID_ReadData2(IF_ID_ReadData2),
	.IF_ID_imm_data(IF_ID_immdata),
	.IF_ID_PC_Out(IF_ID_PC_Out),
  	.IF_ID_ALUOp(IF_ID_ALUOp),
	.IF_ID_ALUSrc(IF_ID_ALUSrc),
	.IF_ID_BranchEq(IF_ID_BranchEq),
	.IF_ID_BranchGt(IF_ID_BranchGt),
	.IF_ID_MemRead(IF_ID_MemRead),
	.IF_ID_MemWrite(IF_ID_MemWrite),
	.IF_ID_RegWrite(IF_ID_RegWrite),
	.IF_ID_MemtoReg(ID_EX_MemtoReg),

	.ID_EX_instruction(ID_EX_Instruction),
	.ID_EX_rd(ID_EX_rd),
	.ID_EX_rs2(ID_EX_rs2),
	.ID_EX_rs1(ID_EX_rs1),
	.ID_EX_imm_data(ID_EX_immdata),
	.ID_EX_ReadData2(ID_EX_ReadData2),
	.ID_EX_ReadData1(ID_EX_ReadData1),
	.ID_EX_PC_Out(ID_EX_PC_Out),
	.ID_EX_ALUSrc(ID_EX_ALUSrc),
	.ID_EX_ALUOp(ID_EX_ALUOp),
	.ID_EX_BranchEq(ID_EX_BranchEq),
	.ID_EX_BranchGt(ID_EX_BranchGt),
	.ID_EX_MemRead(ID_EX_MemRead),
	.ID_EX_MemWrite(ID_EX_MemWrite),
	.ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_MemtoReg(ID_EX_MemtoReg)
);
  
  
EX_MEM EX_MEM
(
	.clk(clk),
	.reset(reset),
	.ID_EX_rd(ID_EX_rd),
  	.ID_EX_MUX_FB(ID_EX_MUX_ForwardB),
	.ID_EX_ALU(ID_EX_ALU_Main),
	.ID_EX_Adder(ID_EX_Adder_Branch),
    .ID_EX_zero(ID_EX_zero),
	.ID_EX_Great(ID_EX_Great),
  	.ID_EX_BranchEq(ID_EX_BranchEq),
  	.ID_EX_BranchGt(ID_EX_BranchEq),
	.ID_EX_MemRead(ID_EX_MemRead),
	.ID_EX_MemWrite(ID_EX_MemWrite),
	.ID_EX_RegWrite(ID_EX_RegWrite),
	.ID_EX_MemtoReg(ID_EX_MemtoReg),

	.EX_MEM_Rd(EX_MEM_rd),
	.EX_MEM_MUX_FB(EX_MEM_MUX_out),
	.EX_MEM_ALU(EX_MEM_ALU_Main),
	.EX_MEM_Adder(EX_MEM_Adder_Branch),
    .EX_MEM_zero(EX_MEM_zero),
  	.EX_MEM_Great(EX_MEM_Great),
	.EX_MEM_BranchEq(EX_MEM_BranchEq),
	.EX_MEM_BranchGt(EX_MEM_BranchGt),
	.EX_MEM_MemRead(EX_MEM_MemRead),
	.EX_MEM_MemWrite(EX_MEM_MemWrite),
	.EX_MEM_RegWrite(EX_MEM_RegWrite),
	.EX_MEM_MemtoReg(EX_MEM_MemtoReg)
);
  

  
MEM_WB MEM_WB
(
	.clk(clk),
	.reset(reset),
	.EX_MEM_rd(EX_MEM_rd),
	.EX_MEM_ALU(EX_MEM_ALU_Main),
	.EX_MEM_ReadData(EX_MEM_ReadData),
	.EX_MEM_RegWrite(EX_MEM_RegWrite),
	.EX_MEM_MemtoReg(EX_MEM_MemtoReg),
		
	.MEM_WB_rd(MEM_WB_rd),
	.MEM_WB_ALU(MEM_WB_ALU_Main),
	.MEM_WB_ReadData(MEM_WB_ReadData),
	.MEM_WB_RegWrite(MEM_WB_RegWrite),
	.MEM_WB_MemtoReg(MEM_WB_MemtoReg)
);

endmodule 