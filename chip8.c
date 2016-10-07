#include"chip8.h"
#include<time.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct CHIP8 M;

F(x00e0,for(byte i=0;i<32*64;++i) SCR[i/64][i%64]=0;PC+=2)		//CLS
F(x00ee,PC=STK[ST--])							//RET
F(x1nnn,PC=nnn)								//JP   addr
F(x2nnn,STK[++SP]=PC;PC=nnn)						//CALL addr
F(x3xkk,if(Vx==kk) PC+=2)						//SE   Vx, addr
F(x4xkk,if(Vx!=kk) PC+=2)						//SNE  Vx, byte
F(x5xy0,if(Vx==Vy) PC+=2)						//SE   Vx, Vy
F(x6xkk,Vx=kk;PC+=2)							//LD   Vx, byte
F(x7xkk,Vx+=kk;PC+=2)							//ADD  Vx, byte
F(x8xy0,Vy=Vx;PC+=2)							//LD   Vx, Vy
F(x8xy1,Vx|=Vy;PC+=2)							//OR   Vx, Vy
F(x8xy2,Vx&=Vy;PC+=2)							//AND  Vx, Vy
F(x8xy3,Vx^=Vy;PC+=2)							//XOR  Vx, Vy
F(x8xy4,word S=Vx+Vy;Vx=S&0xf;VF=S>>8&0x1;PC+=2)			//ADD  Vx, Vy
F(x8xy5,VF=Vx>Vy;Vx-=Vy;PC+=2)						//SUB  Vx, Vy
F(x8xy6,VF=Vx&1;Vx>>=1;PC+=2)						//SHR  Vx{, Vy}
F(x8xy7,VF=Vy>Vx;Vx=Vy-Vx;PC+=2)					//SUBN Vx, Vy
F(x8xye,VF=Vx&0x80;Vx<<=1;PC+=2)					//SHL  Vx{, Vy}
F(x9xy0,PC+=2*(Vx!=Vy);PC+=2)						//SNE  Vx, Vy
F(xannn,I=nnn;PC+=2)							//LD   I, addr
F(xbnnn,PC=nnn+V0)							//JP   V0, addr
F(xcxkk,srand(time(NULL));Vx=(rand()%256)&kk;PC+=2)			//RND  Vx, byte
F(xdxyn,VF=0;for(byte i=0;i<n;++i) for(byte j=0;j<8;++j){		//DRW  Vx, Vy, nibble
      if(SCR[Vx+i][(Vy+j)%64]+(MEM[I+i]>>j)&1==2)VF=1;
      SCR[Vx+i][(Vy+j)%64]^=(MEM[I+i]>>j)&1;
    }
  PC+=2)
F(xex9e,PC+=2*(KB&(1<<Vx));PC+=2)					//SKP  Vx
F(xexa1,PC+=2*(0==KB&(1<<Vx));PC+=2)					//SKPN Vx
F(xfx07,Vx=DT;PC+=2)							//LD   Vx, DT
F(xfx0a,Vx=MAP[getchar()];PC+=2)					//LD   Vx, K
F(xfx15,DT=Vx;PC+=2)							//LD   DT, Vx
F(xfx18,ST=Vx;PC+=2)							//LD   ST, Vx
F(xfx1e,I+=Vx;PC+=2)							//ADD  I, Vx
F(xfx29,I=MEM[Vx];PC+=2)						//LD   F, Vx
F(xfx33,MEM[I]=Vx/100;MEM[I+1]=(Vx)%100/10;MEM[I+2]=Vx%10;PC+=2)	//LD   B, Vx
F(xfx55,for(byte i=0;i<Vx;++i) MEM[I+i]=V[i];PC+=2)			//LD   [I], Vx
F(xfx65,for(byte i=0;i<Vx;++i) V[i]=MEM[I+i];PC+=2)			//LD   Vx, [I]

void f0(word opcode){(inst[]){f00e0,f00ee}[opcode>>1&1](opcode);}
void f8(word opcode){(inst[]){f8xy0,f8xy1,f8xy2,f8xy3,f8xy4,f8xy5,f8xy6,f8xy7,0,0,0,0,0,0,f8xye,0}[opcode&0xf](opcode);}
void fe(word opcode){(inst[]){fex9e,fexa1}[opcode&1](opcode);}
void ff(word opcode){inst H[256];
  H[0x07]=ffx07;H[0x0a]=ffx0a;H[0x15]=ffx15;H[0x18]=ffx18;H[0x1e]=ffx1e;
  H[0x29]=ffx29;H[0x33]=ffx33;H[0x55]=ffx55;H[0x65]=ffx65;
  H[opcode&0xff](opcode);
}

byte charset[5*16]={
  0xF0,0x90,0x90,0x90,0xF0,  0x20,0x60,0x20,0x20,0x70,  0xF0,0x10,0xF0,0x80,0xF0,  0xF0,0x10,0xF0,0x10,0xF0,
  0x90,0x90,0xF0,0x10,0x10,  0xF0,0x80,0xF0,0x10,0xF0,  0xF0,0x80,0xF0,0x90,0xF0,  0xF0,0x10,0x20,0x40,0x40,
  0xF0,0x90,0xF0,0x90,0xF0,  0xF0,0x90,0xF0,0x10,0xF0,  0xF0,0x90,0xF0,0x90,0x90,  0xE0,0x90,0xE0,0x90,0xE0,
  0xF0,0x80,0x80,0x80,0xF0,  0xE0,0x90,0x90,0x90,0xE0,  0xF0,0x80,0xF0,0x80,0xF0,  0xF0,0x80,0xF0,0x80,0x80
};

int main(int argc,char*argv[]){
  inst OP[16]={f0,f1nnn,f2nnn,f3xkk,f4xkk,f5xy0,f6xkk,f7xkk,f8,f9xy0,fannn,fbnnn,fcxkk,fdxyn,fe};
  FILE*in=fopen(argv[1],"rb");
  fread(M.MEM+0x200,1,4096-0x200,in);
  fclose(in);
  memcpy(M.MEM,charset,5*16);
  M.PC=0x200;
  M.I=M.SP=0;
  for(;;){
    word i=*(word*)(M.MEM+0x200+i);
    OP[i>>12&0xf](i);
  }
  return 0;
}
