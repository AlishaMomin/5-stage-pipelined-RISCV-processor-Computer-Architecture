`include "ALU_Control.v"
`include "Control_Unit.v"
`include "Data_Memory.v"
`include "adder.v"
`include "alu_64.v"
`include "dataExtract.v"
`include "instruction_memory.v"
`include "instruction_parser.v"
`include "mux2_1.v"
`include "pc_counter.v"
`include "registerFile.v"

module RISC_V_Processor(
	input clk,
	input reset);

// ADDER:
// We have 2 adders in our diagram and the output of both the adders are given as an input to other module
  wire [63:0] out_adder1; 		// adder 1 output 
  wire [63:0] b1; 				//  As for adder1 the b=4 therefore b1 = adder2 input
  wire [63:0] out_adder2; 		// adder 2 output
// ALU CONTROL: 
  // it has 2 input: funct and ALUOP. ALUOP is the ouput of control unit 
  //Given that Funct should have the instruction[30,14-12] 
  //where the instructions is the ouput of instruction_memory.
  wire [3:0] Operation; 		// Output which is also given to ALU64 as an input
    wire [3:0] functx; 			// Input
  wire [2:0] funct_out; 		// Output
// CONTROL UNIT:
  // the input of control unit is the opcode of instruction parser.
  wire [1:0] ALUOp;  			// Output of control unit and given as an input to ALUOP of module ALU CONTROL 
  wire Branch,MemRead,MemtoReg,MemWrite,ALUSrc,Regwrite;   // output 
//DATA MEMORY 
  // 5 input : clk, write data (output of Register file module name: read data 2), 
  //Mem_addr (output of ALU64 module named Result), MemWrite (output of control unit module name: Memwrite),
  //MemRead (output of control unit module name: MemRead)
  wire [63:0] Read_Data; // output given to mux3 input b 
//IMMEDIATE DATA EXTRACTOR: 
  // 1 input = instruction which is the output of instruction_memory module name: instruction
  wire [63:0] imm_data;   // Output which is also tranfered to Mux2 input b and Adder2 input b by shifting that left with 1(we named it as b1)
  assign b1 = imm_data << 1; // imm_data shift left 1
// INSTRUCTION MEMORY 
  // input is Inst_addr which is basically the output of program counter 
  wire [31:0] Instruction;  //Output of Instruction memory which is also given as an input to instructon parser, 
							//   ALu_control and immediate data extractor 
// INSTRUCTION PARSER 
  // input is instruction which basically is the output of instruction memory 
  wire [6:0] opcode;    // Output which is used as a input of control unit module named:opcode
  wire [4:0] rd;  		// Output which is used as a input of Register file module named:RD
  wire [2:0] func3;     // Output
  wire [4:0] rs1;		// Output which is used as a input of Register file module named:RS1
  wire [4:0] rs2;       // Output which is used as a input of Register file module named:RS2
  wire [6:0] func7;     // Output
// MUX 2_1
  //input a and b and sel
  // ouput data out
  // input a-> mux1= ReadData2, Mux2= out_adder1 , Mux3= Read_Data
  wire sel; //mux1= ALUSrc, Mux2= (Branch & Zero) , Mux3= MemtoReg 
  wire [63:0] data_out;   // Output which is transeferd to the input of program counter module name:PC_In
  wire [63:0] data_out1;  // Output of mux1 Which is the input of ALU64 module named: b
// ALU_64
// input a, b and ALUOp taken from module register file, Mux1 and ALU_Control outputs (ReadData1,data_out1 and Operations)
  wire [63:0] Result; // output given to data memory input Mem_Addr
  wire equal_; //Output -> Named Zero in the diagram
// REGISTER FILE
  //input rs1,rs2,rd are the output of instruction parser 
  wire [4:0] RS1;  //input
  wire [4:0] RS2;  //input
  wire [4:0] RD;  //input
  wire [63:0] ReadData1; //Output which is also transfered to ALU64 input name: a
  wire [63:0] ReadData2; //Output which is also transfered to Mux1 and DataMemory module input name: b,WriteData
wire [63:0] data_out2; // the input of WriteData(namein diagram) is taken from the Mux3 output 
// PC COUNTER 
  // input PC_In is taken from the ouput of Mux2
  wire [63:0] PC_Out;    // Output given to the input of adder1, adder2 and instruction memory module named: a,a, inst_addr
//
  wire [63:0] b;        //ADDER1 input b which is 64'h4 = 4 in decimal
  assign b = 64'd4;		//ADDER1 input b which is 64'h4 = 4 in decimal
  assign sel = (Branch & equal_);  // AND gate used as SEL for mux2 which is basically (Branch & Zero)
  assign functx = {Instruction[30] ,Instruction[14:12]}; //ALU_control input->Instuction[30,14-12]->Instruction is from instruction_memory
 
pc_counter pc(
  .PC_In(data_out),
  .reset(reset),
  .clk(clk),
  .PC_Out(PC_Out)
);
  
adder adder1(
  .a(PC_Out), 
  .b(b), 
  .out(out_adder1)
);
  
instruction_memory  ins_mem(
  .Inst_Address(PC_Out),
  .Instruction(Instruction)
);
  
  
instruction_parser ins_par(
  .ins(Instruction),
  .opcode(opcode),
  .rd(rd),
  .func3(func3),
  .rs1(rs1),
  .rs2(rs2),
  .func7(func7)
);
  
Control_Unit ctrl_unit(
  .Opcode(opcode),
  .ALUOp(ALUOp),
  .Branch(Branch),
  .MemRead(MemRead),
  .MemtoReg(MemtoReg),
  .MemWrite(MemWrite),
  .ALUSrc(ALUSrc),
  .Regwrite(Regwrite)
);
  
  
registerFile reg_file(
  .clk(clk),
  .reset(reset),
  .RegWrite(Regwrite),
  .WriteData(data_out2),
  .RS1(rs1),
  .RS2(rs2),
  .RD(rd),
  .ReadData1(ReadData1),
  .ReadData2(ReadData2)
);
  
dataExtract ext(
  .instruction(Instruction),
  .imm_data(imm_data)
);
  
ALU_Control  alu_ctrl(
  .ALUOp(ALUOp),
  .Funct(functx),
  .Operation(Operation),
  .FunctOut(funct_out) 
);
  
  
  mux2_1 mux1( 
  .a(ReadData2),
  .b(imm_data),
  .sel(ALUSrc),
  .data_out(data_out1)
);
  
alu_64 alu64(
  .a(ReadData1),
  .b(data_out1),
  .ALUOp(Operation),
  .funct(funct_out),
  .Result(Result),
  .equal(equal_)
);

  adder adder2( 
    .a(PC_Out), 
    .b(b1), 
  .out(out_adder2)
);
  
  
  mux2_1 mux2( 
    .a(out_adder1),
    .b(out_adder2),
    .sel(sel), 
  .data_out(data_out)
);
  
Data_Memory  data_mem(
  .Mem_Addr(Result),
  .Write_Data(ReadData2),
  .clk(clk),
  .MemWrite(MemWrite),
  .MemRead(MemRead),
  .Read_Data(Read_Data)
);
  
  mux2_1 mux3(
  .a(Result),
  .b(Read_Data),
  .sel(MemtoReg),
  .data_out(data_out2)
);
  
	
endmodule