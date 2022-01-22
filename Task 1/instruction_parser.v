module instruction_parser(
  input [31:0] ins,
  output [6:0] opcode, [4:0] rd,[2:0] func3,[4:0] rs1,[4:0] rs2,[6:0] func7
);
  assign opcode = ins[6:0];
  assign rd = ins[11:7];
  assign func3 = ins[14:12];
  assign rs1 = ins[19:15];
  assign rs2 = ins[24:20];
  assign func7 = ins[31:25];

endmodule
