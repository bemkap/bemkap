Instruction code[]={
  Instruction(LABEL,Operand("main",LABELOP)),
  Instruction(MOV,Operand(IMM,0),Operand(REG,R0)),
  Instruction(LABEL,Operand("loop",LABELOP)),
  Instruction(MOV,Operand(REG,R1),Operand(REG,R2)),
  Instruction(SUB,Operand(IMM,1),Operand(REG,R2)),
  Instruction(AND,Operand(REG,R2),Operand(REG,R1)),
  Instruction(ADD,Operand(IMM,1),Operand(REG,R0)),
  Instruction(CMP,Operand(REG,R1),Operand(IMM,0)),
  Instruction(JMPL,Operand("loop",LABELOP)),
  Instruction(PRINT,Operand(REG,R0)),
  Instruction(HLT)
}
