#pragma once

typedef unsigned char byte;
typedef unsigned short word;
typedef void(*inst)(word);

struct CHIP8 {
  byte DT,ST,SP,MEM[4096],SCR[32][64],V[16];
  word I,PC,KB,STK[16];
};

extern struct CHIP8 M;

#define F(id,body) void id(word oc){			\
    byte Vx=M.V[oc>>8&0xf],Vy=M.V[oc>>4&0xf];		\
    byte n=oc&0xf,kk=oc&0xff,nnn=oc&0xfff;		\
    byte DT=M.DT,ST=M.ST,*MEM=M.MEM,**SCR=M.SCR;	\
    word I=M.I,PC=M.PC,KB=M.KB,*STK=M.STK;		\
    do{body;}while(0);					\
  }
