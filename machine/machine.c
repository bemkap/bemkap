#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "machine.h"
extern int yyparse();
extern FILE*yyin;

int count,entry=0;
struct Instruction code[512];
const char*regname[REGS]={"\%zero","\%pc","\%sp","\%r0","\%r1","\%r2","\%r3","\%flags"};
struct Machine machine;

int reg(const char*r){
  int i;
  for(i=0;i<REGS;i++) if(strcmp(r,regname[i])==0) return i;
  printf("Unkown Register %s\n",r);
  abort();
}

void dumpMachine(){
  int i;
  printf("**************** Machine state at PC=%d **************\n",machine.reg[PC]);
  for(i=0;i<REGS;i++) 
    if(strlen(regname[i])==0) continue; 
    else printf("%s\t\t= \t\t%d \t\t%x\n",regname[i],machine.reg[i],machine.reg[i]);
  printf("******************************************************\n");
}

void setBit(int*n,int p,int b){
  if(b>=0&&b<=1){ // b=0 o b=1
    *n&=~(1<<p); // n[p]=0
    *n|=(b<<p);  // n[p]|=b
  }
}

void runIns(struct Instruction i){
  int*ASRC[]={&i.src.val,&machine.reg[i.src.val],(int*)&machine.memory[i.src.val]};
  int*ADST[]={&i.dst.val,&machine.reg[i.dst.val],(int*)&machine.memory[i.dst.val]};
  switch(i.op){
  case NOP   : break;
  case MOV   : *ADST[i.dst.type]=*ASRC[i.src.type]; break;
  case LW    : *ADST[i.dst.type]=machine.memory[*ASRC[i.src.type]]; break;
  case SW    : machine.memory[*ADST[i.dst.type]]=*ASRC[i.src.type]; break;
  case PUSH  : machine.reg[SP]-=4; machine.memory[machine.reg[SP]]=*ASRC[i.src.type]; break;
  case POP   : *ASRC[i.src.type]=machine.reg[SP]; machine.reg[SP]+=4; break;
  case PRINT : printf("%d\n",*ASRC[i.src.type]); break;
  case READ  : scanf("%d",ASRC[i.src.type]); break;
  case ADD   : *ADST[i.dst.type]+=*ASRC[i.src.type]; break;
  case SUB   : *ADST[i.dst.type]-=*ASRC[i.src.type]; break;
  case MUL   : *ADST[i.dst.type]*=*ASRC[i.src.type]; break;
  case DIV   : *ADST[i.dst.type]/=*ASRC[i.src.type]; break;
  case AND   : *ADST[i.dst.type]&=*ASRC[i.src.type]; break;
  case OR    : *ADST[i.dst.type]|=*ASRC[i.src.type]; break;
  case XOR   : *ADST[i.dst.type]^=*ASRC[i.src.type]; break;
  case NOT   : *ASRC[i.src.type]=~*ASRC[i.src.type]; break;
  case SHR   : *ADST[i.dst.type]=((unsigned)*ADST[i.dst.type])>>*ASRC[i.src.type]; break;
  case SHL   : case SAL: *ADST[i.dst.type]<<=*ASRC[i.src.type]; break;
  case SAR   : *ADST[i.dst.type]>>=*ASRC[i.src.type]; break;
  case CMP   :
    setBit(&machine.reg[FLAGS],EQUAL_BIT_FLAGS,*ADST[i.dst.type]==*ASRC[i.src.type]);
    setBit(&machine.reg[FLAGS],LOWER_BIT_FLAGS,*ADST[i.dst.type]< *ASRC[i.src.type]);
    break;
  /* jumps y call restan 1 al pc porque después se incrementa en run() */
  case JMP   : machine.reg[PC]=*ASRC[i.src.type]-1; break;
  case JMPE  : if(ISSET_EQUAL) machine.reg[PC]=*ASRC[i.src.type]-1; break;
  case JMPL  : if(ISSET_LOWER) machine.reg[PC]=*ASRC[i.src.type]-1; break;
  case HLT   : abort();
  case LABEL : break;
  case CALL  :
    machine.reg[SP]-=4; machine.memory[machine.reg[SP]]=machine.reg[PC];
    machine.reg[PC]=*ASRC[i.src.type]-1;
    break;
  case RETURN: machine.reg[PC]=machine.memory[machine.reg[SP]]; machine.reg[SP]+=4; break;
  default    : printf("Instruction not implemented\n"); abort();
  }
}

void run(struct Instruction*code){
  machine.reg[PC]=entry; //Start at main function
  machine.reg[SP]=MEM_SIZE; 
  while(code[machine.reg[PC]].op!=HLT){
    runIns(code[machine.reg[PC]]);
    //If not a jump, continue with next instruction
    machine.reg[PC]++;
  }
}

void processLabels(){
  int i,j,k;
  for(i=0;i<count;i++){
    if(code[i].op==LABEL){
      if(strcmp(code[i].src.lab,"main")==0) entry=i;
      for(j=0;j<count;j++){
	if(code[j].op==JMP || code[j].op==JMPE || code[j].op==JMPL || code[j].op==CALL){
	  if(code[j].src.lab && strcmp(code[j].src.lab,code[i].src.lab)==0){
	    code[j].src.type=IMM;
	    code[j].src.val=i;
	    code[j].src.lab=NULL;
	  }
	}
      }
      for(j=i;j<count-1;j++) code[j]=code[j+1];
      count--;     
    }
  }
  for(j=0;j<count;j++){
    if(code[j].op==JMP || code[j].op==JMPE || code[j].op==JMPL || code[j].op==CALL){
      if(code[j].src.lab){
	printf("Jump to unkown label %s\n",code[j].src.lab);
	exit(-1);
      }
    }
  }
}

void printOperand(struct Operand s){
  switch(s.type){
  case IMM: printf("$%d",s.val); break;
  case REG: printf("%s",regname[s.val]); break;
  case MEM: printf("%d",s.val); break;
  } 
}

void printInstr(struct Instruction i){
  const char*opname[]={"NOP\n","MOV ","LW ","SW ","PUSH ",
                       "POP ","PRINT ","READ ","ADD ","SUB ","MUL ",
                       "DIV ","AND ","OR ","XOR ","NOT ","SHR ","SHL ",
                       "SAR ","SAL ","CMP ","JMP ","JMPZ ","JMPE ","JMPL ",
                       "HLT\n","LABEL ","CALL ","RETURN "};
  printf(opname[i.op]);
  if(i.op!=NOP && i.op!=HLT && i.op!=RETURN) printOperand(i.src);
  switch(i.op){
  case MOV:case LW:case SW:case ADD:case MUL:case SUB:case DIV:case CMP:
  case AND:case OR:case XOR:case SHR:case SHL:case SAR:case SAL:
    printf(","); printOperand(i.dst); break;
  case JMP:case JMPZ:case JMPE:case JMPL:
    if(i.src.lab) printf("%s",i.src.lab); break;
  }
  printf("\n");
}

int main(int argc,char*argv[]){
  int i;
  if(argc>0){
    yyin=fopen(argv[1],"r");
    yyparse();
    processLabels();
    printf("Running the following code\n");
    for(i=0;i<count;i++){
      printf("%02d. ",i);
      printInstr(code[i]);
    }
    printf("***************\n");
    run(code);
  }
  return 0;
}
