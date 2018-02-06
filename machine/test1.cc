Instruction code[]={
  Instruction(LABEL,Operand("main",LABELOP)),
  Instruction(READ,Operand(REG,R0)),
  Instruction(CMP,Operand(REG,R0),Operand(IMM,0)),
  Instruction(JMPL,Operand("prnt",LABELOP)),
  Instruction(MUL,Operand(IMM,-1),Operand(REG,R0)),
  Instruction(LABEL,Operand("prnt",LABELOP)),
  Instruction(PRINT,Operand(REG,R0)),
  Instruction(HLT)
}
