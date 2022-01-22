module EX_MEM( 
    input clk, reset,
    input [4:0] ID_EX_rd,
    input [63:0] ID_EX_MUX_FB, ID_EX_ALU,
    input [63:0] ID_EX_Adder,
    input ID_EX_zero,
    input ID_EX_Great,
    input ID_EX_BranchEq,
    input ID_EX_BranchGt,
    input ID_EX_MemRead,
    input ID_EX_MemWrite,
    input ID_EX_RegWrite,
    input ID_EX_MemtoReg,
    
    output reg [4:0] EX_MEM_Rd,
    output reg [63:0] EX_MEM_MUX_FB, EX_MEM_ALU,
    output reg [63:0] EX_MEM_Adder,
    output reg EX_MEM_zero,
    output reg EX_MEM_Great,
    output reg EX_MEM_BranchEq,
    output reg EX_MEM_BranchGt,
    output reg EX_MEM_MemRead,
    output reg EX_MEM_MemWrite,
    output reg EX_MEM_RegWrite,
    output reg EX_MEM_MemtoReg);


  always @(posedge clk or reset)
begin
    if (reset)
        begin
            EX_MEM_Rd = 0;
            EX_MEM_MUX_FB = 0;
            EX_MEM_ALU = 0;
            EX_MEM_Adder = 0;
            EX_MEM_MemRead = 0;
            EX_MEM_MemWrite = 0;
            EX_MEM_RegWrite = 0;
            EX_MEM_MemtoReg = 0;
            EX_MEM_zero = 0;
            EX_MEM_Great = 0;
            EX_MEM_BranchEq = 0;
            EX_MEM_BranchGt = 0;
        end
    else if (clk)
        begin
            EX_MEM_Rd = ID_EX_rd;
            EX_MEM_MUX_FB = ID_EX_MUX_FB;
            EX_MEM_ALU = ID_EX_ALU;
            EX_MEM_zero = ID_EX_zero;
            EX_MEM_Adder = ID_EX_Adder;
            EX_MEM_MemRead = ID_EX_MemRead;
            EX_MEM_MemWrite = ID_EX_MemWrite;
            EX_MEM_RegWrite = ID_EX_RegWrite;
            EX_MEM_MemtoReg = ID_EX_MemtoReg;
            
            EX_MEM_zero = ID_EX_zero;
            EX_MEM_Great = ID_EX_Great;
            EX_MEM_BranchEq = ID_EX_BranchEq;
            EX_MEM_BranchGt = ID_EX_BranchGt;
        end
        
end
endmodule







