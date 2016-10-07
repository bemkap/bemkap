#pragma once

#include<time.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<SDL2/SDL.h>

#define WHITE 0xffffff
#define BLACK 0x000000

typedef unsigned char byte;
typedef unsigned short word;

struct CHIP8 {
  byte DT,ST,SP,MEM[4096],SCR[32*64],V[16];
  word I,PC,KB,STK[16];
};

typedef void(*inst)(struct CHIP8*,word);

#define F(id,body) void id(struct CHIP8*M,word oc){        \
    byte Vx=M->V[oc>>8&0xf],Vy=M->V[oc>>4&0xf];            \
    byte V0=M->V[0x0],VF=M->V[0xf];                        \
    byte n=oc&0xf,kk=oc&0xff,nnn=oc&0xfff;                 \
    byte DT=M->DT,ST=M->ST,SP=M->SP;                       \
    byte *MEM=M->MEM,*SCR=M->SCR,*V=M->V;                  \
    word I=M->I,PC=M->PC,KB=M->KB,*STK=M->STK;             \
    do{body;}while(0);                                     \
  }
