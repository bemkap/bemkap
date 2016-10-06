#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define na(n,a) (((n&0xf)<<12)|(a&0xfff))
#define nnb(n,m,b) (((n&0xf)<<12)|(m&0xf<<8)|(b&0xff))
#define nnnn(n,m,o,p) (((n&0xf)<<12)|((m&0xf)<<8)|((o&0xf)<<4)|(p&0xf))

void line(unsigned short*p){
  unsigned short a;
  unsigned char b,c;
  if(scanf("CLS")) *p=0x00e0;
  else if(scanf("RET")) *p=0x00ee;
  else if(scanf("JP %hu",&a)) *p=na(1,a);
  else if(scanf("CALL %hu",&a)) *p=na(2,a);
  else if(scanf("SE %hhu, %hhu",&b,&c)) *p=nnb(3,b,c);
  else if(scanf("SNE %hhu, %hhu",&b,&c)) *p=nnb(4,b,c);
  else if(scanf("SE %hhu, %hhu",&b,&c)) *p=nnnn(5,b,c,0);
  else if(scanf("LD %hhu, %hhu",&b,&c)) *p=nnb(6,b,c);
  else if(scanf("ADD %hhu, %hhu",&b,&c)) *p=nnb(7,b,c);
  else if(scanf("LD %hhu, %hhu",&b,&c)) *p=nnb(7,b,c);
}

/*
CLS         
RET         
JP   addr   
CALL addr   
SE   Vx, addr
SNE  Vx, byte
SE   Vx, Vy 
LD   Vx, byte
ADD  Vx, byte
LD   Vx, Vy 
OR   Vx, Vy 
AND  Vx, Vy 
XOR  Vx, Vy 
ADD  Vx, Vy 
SUB  Vx, Vy 
SHR  Vx{, Vy}
SUBN Vx, Vy 
SHL  Vx{, Vy}
SNE  Vx, Vy 
LD   I, addr
JP   V0, addr
RND  Vx, byte
DRW  Vx, Vy, nibble
SKP  Vx     
SKPN Vx     
LD   Vx, DT 
LD   Vx, K  
LD   DT, Vx 
LD   ST, Vx 
ADD  I, Vx  
LD   F, Vx  
LD   B, Vx  
LD   [I], Vx
LD   Vx, [I]
*/

