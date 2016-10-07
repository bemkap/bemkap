#include<time.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef unsigned char byte;
typedef unsigned short word;
typedef void(*inst)(word);

struct CHIP8 {
  byte DT,ST,SP,MEM[4096],SCR[32][64],V[16];
  word I,PC,KB,STK[16];
} M;

byte MAP[256];

#define F0(id,body) void id(word opcode){do{body;}while(0);}
#define F1(id,body) void id(word opcode){byte x=opcode&0x0f00>>8;do{body;}while(0);}
#define F2(id,body) void id(word opcode){byte x=opcode&0x0f00>>8,y=opcode&0x00f0>>4;do{body;}while(0);}
#define F3(id,body) void id(word opcode){byte x=opcode&0x0f00>>8,y=opcode&0x00f0>>4,n=opcode&0x000f;do{body;}while(0);}
#define FK(id,body) void id(word opcode){byte x=opcode&0x0f00>>8,kk=opcode&0x00ff;do{body;}while(0);}
#define FN(id,body) void id(word opcode){byte nnn=opcode&0x0fff;do{body;}while(0);}

F0(x00e0,for(byte i=0;i<32*64;++i)M.SCR[i/64][i%64]=0;M.PC+=2)				   //CLS
F0(x00ee,M.PC=M.STK[M.ST--])								   //RET
FN(x1nnn,M.PC=nnn)									   //JP   addr
FN(x2nnn,M.STK[++M.SP]=M.PC;M.PC=nnn)							   //CALL addr
FK(x3xkk,if(M.V[x]==kk)M.PC+=2)								   //SE   Vx, addr
FK(x4xkk,if(M.V[x]!=kk)M.PC+=2)								   //SNE  Vx, byte
F2(x5xy0,if(M.V[x]==M.V[y])M.PC+=2)							   //SE   Vx, Vy
FK(x6xkk,M.V[x]=kk;M.PC+=2)								   //LD   Vx, byte
FK(x7xkk,M.V[x]+=kk;M.PC+=2)								   //ADD  Vx, byte
F2(x8xy0,M.V[y]=M.V[x];M.PC+=2)								   //LD   Vx, Vy
F2(x8xy1,M.V[x]|=M.V[y];M.PC+=2)							   //OR   Vx, Vy
F2(x8xy2,M.V[x]&=M.V[y];M.PC+=2)							   //AND  Vx, Vy
F2(x8xy3,M.V[x]^=M.V[y];M.PC+=2)							   //XOR  Vx, Vy
F2(x8xy4,word S=M.V[x]+M.V[y];M.V[x]=S&0xf;M.V[0xf]=(0x10&S)>>8;M.PC+=2)		   //ADD  Vx, Vy
F2(x8xy5,M.V[0xf]=M.V[x]>M.V[y];M.V[x]-=M.V[y];M.PC+=2)					   //SUB  Vx, Vy
F2(x8xy6,M.V[0xf]=M.V[x]&1;M.V[x]>>=1;M.PC+=2)						   //SHR  Vx{, Vy}
F2(x8xy7,M.V[0xf]=M.V[y]>M.V[x];M.V[x]=M.V[y]-M.V[x];M.PC+=2)				   //SUBN Vx, Vy
F2(x8xye,M.V[0xf]=M.V[x]&0x80;M.V[x]<<=1;M.PC+=2)					   //SHL  Vx{, Vy}
F2(x9xy0,M.PC+=2*(M.V[x]!=M.V[y]);M.PC+=2)						   //SNE  Vx, Vy
FN(xannn,M.I=nnn;M.PC+=2)								   //LD   I, addr
FN(xbnnn,M.PC=nnn+M.V[0])								   //JP   V0, addr
FK(xcxkk,srand(time(NULL));M.V[x]=(rand()%256)&kk;M.PC+=2)				   //RND  Vx, byte
F3(xdxyn,M.V[0xf]=0;for(byte i=0;i<n;++i) for(byte j=0;j<8;++j){  			   //DRW  Vx, Vy, nibble
      if(M.SCR[M.V[x]+i][(M.V[y]+j)%64]+(M.MEM[M.I+i]>>j)&1==2)M.V[0xf]=1;
      M.SCR[M.V[x]+i][(M.V[y]+j)%64]^=(M.MEM[M.I+i]>>j)&1;
    }
  M.PC+=2)
F1(xex9e,M.PC+=2*(M.KB&(1<<M.V[x]));M.PC+=2)						   //SKP  Vx
F1(xexa1,M.PC+=2*(0==M.KB&(1<<M.V[x]));M.PC+=2)						   //SKPN Vx
F1(xfx07,M.V[x]=M.DT;M.PC+=2)								   //LD   Vx, DT
F1(xfx0a,M.V[x]=MAP[getchar()];M.PC+=2)						           //LD   Vx, K
F1(xfx15,M.DT=M.V[x];M.PC+=2)								   //LD   DT, Vx
F1(xfx18,M.ST=M.V[x];M.PC+=2)								   //LD   ST, Vx
F1(xfx1e,M.I+=M.V[x];M.PC+=2)								   //ADD  I, Vx
F1(xfx29,M.I=M.MEM[M.V[x]];M.PC+=2)							   //LD   F, Vx
F1(xfx33,M.MEM[M.I]=M.V[x]/100;M.MEM[M.I+1]=(M.V[x])%100/10;M.MEM[M.I+2]=M.V[x]%10;M.PC+=2)//LD   B, Vx
F1(xfx55,for(byte i=0;i<M.V[x];++i)M.MEM[M.I+i]=M.V[i];M.PC+=2)   			   //LD   [I], Vx
F1(xfx65,for(byte i=0;i<M.V[x];++i)M.V[i]=M.MEM[M.I+i];M.PC+=2)	         		   //LD   Vx, [I]

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
    OP[(i&0xf000)>>12](i);
  }
  return 0;
}
