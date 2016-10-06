#include<time.h>
#include<stdio.h>
#include<stdlib.h>

typedef unsigned char byte;
typedef unsigned short word;
typedef void(*inst)(word);

struct CHIP8 {
  byte DT,ST,SP,MEM[4096],SCR[32][8],V[16];
  word I,PC,KB,STK[16];
} M;

byte MAP[256];

#define F0(id,body) void f##id(word opcode){do{body}while(0);}
#define F1(id,body) void f##id(word opcode){byte x=opcode&0x0f00>>8;do{body}while(0);}
#define F2(id,body) void f##id(word opcode){byte x=opcode&0x0f00>>8,y=opcode&0x00f0>>4;do{body}while(0);}
#define F3(id,body) void f##id(word opcode){byte x=opcode&0x0f00>>8,y=opcode&0x00f0>>4,n=opcode&0x000f;do{body}while(0);}
#define FK(id,body) void f##id(word opcode){byte x=opcode&0x0f00>>8,kk=opcode&0x00ff;do{body}while(0);}
#define FN(id,body) void f##id(word opcode){byte nnn=opcode&0x0fff;do{body}while(0);}

F0(00e0,byte i;for(i=0;i<256;++i)M.SCR[i/8][i%8]=0;M.PC+=2;)					//CLS
F0(00ee,M.PC=M.STK[M.ST--];)									//RET
FN(1nnn,M.PC=nnn;)										//JP   addr
FN(2nnn,M.STK[++M.SP]=M.PC;M.PC=nnn;)								//CALL addr
FK(3xkk,if(M.V[x]==kk)M.PC+=2;)								        //SE   Vx, addr
FK(4xkk,if(M.V[x]!=kk)M.PC+=2;)								        //SNE  Vx, byte
F2(5xy0,if(M.V[x]==M.V[y])M.PC+=2;)								//SE   Vx, Vy
FK(6xkk,M.V[x]=kk;M.PC+=2;)									//LD   Vx, byte
FK(7xkk,M.V[x]+=kk;M.PC+=2;)									//ADD  Vx, byte
F2(8xy0,M.V[y]=M.V[x];M.PC+=2;)								        //LD   Vx, Vy
F2(8xy1,M.V[x]|=M.V[y];M.PC+=2;)								//OR   Vx, Vy
F2(8xy2,M.V[x]&=M.V[y];M.PC+=2;)								//AND  Vx, Vy
F2(8xy3,M.V[x]^=M.V[y];M.PC+=2;)								//XOR  Vx, Vy
F2(8xy4,word S=M.V[x]+M.V[y];M.V[x]=S&0xf;M.V[0xf]=(0x10&S)>>8;M.PC+=2;)		        //ADD  Vx, Vy
F2(8xy5,M.V[0xf]=M.V[x]>M.V[y];M.V[x]-=M.V[y];M.PC+=2;)					        //SUB  Vx, Vy
F2(8xy6,M.V[0xf]=M.V[x]&1;M.V[x]>>=1;M.PC+=2;)						        //SHR  Vx{, Vy}
F2(8xy7,M.V[0xf]=M.V[y]>M.V[x];M.V[x]=M.V[y]-M.V[x];M.PC+=2;)					//SUBN Vx, Vy
F2(8xye,M.V[0xf]=M.V[x]&0x80;M.V[x]<<=1;M.PC+=2;)						//SHL  Vx{, Vy}
F2(9xy0,M.PC+=2*(M.V[x]!=M.V[y]);M.PC+=2;)							//SNE  Vx, Vy
FN(annn,M.I=nnn;M.PC+=2;)									//LD   I, addr
FN(bnnn,M.PC=nnn+M.V[0];)									//JP   V0, addr
FK(cxkk,srand(time(NULL));M.V[x]=(rand()%256)&kk;M.PC+=2;)					//RND  Vx, byte
F3(dxyn,M.V[0xf]=0;byte i;for(i=0;i<n;++i){							//DRW  Vx, Vy, nibble
    //if pixel erased set VF=1
    M.SCR[M.V[x]+i][M.V[y]/8]^=M.MEM[M.I+i]>>M.V[y];
    M.SCR[M.V[x]+i][(M.V[y]/8+1)%8]^=M.MEM[M.I+i]<<(8-M.V[y]);}
  M.PC+=2;)
F1(ex9e,M.PC+=2*(M.KB&(1<<M.V[x]));M.PC+=2;)							//SKP  Vx
F1(exa1,M.PC+=2*(0==M.KB&(1<<M.V[x]));M.PC+=2;)						        //SKPN Vx
F1(fx07,M.V[x]=M.DT;M.PC+=2;)									//LD   Vx, DT
F1(fx0a,M.V[x]=MAP[getchar()];M.PC+=2;)						                //LD   Vx, K
F1(fx15,M.DT=M.V[x];M.PC+=2;)									//LD   DT, Vx
F1(fx18,M.ST=M.V[x];M.PC+=2;)									//LD   ST, Vx
F1(fx1e,M.I+=M.V[x];M.PC+=2;)									//ADD  I, Vx
//The value of I is set to the location for the hexadecimal sprite corresponding to the value of Vx.
F1(fx29,M.PC+=2;)										//LD   F, Vx
F1(fx33,M.MEM[M.I]=M.V[x]/100;M.MEM[M.I+1]=(M.V[x])%100/10;M.MEM[M.I+2]=M.V[x]%10;M.PC+=2;)	//LD   B, Vx
F1(fx55,byte i;for(i=0;i<M.V[x];++i)M.MEM[M.I+i]=M.V[i];M.PC+=2;)				//LD   [I], Vx
F1(fx65,byte i;for(i=0;i<M.V[x];++i)M.V[i]=M.MEM[M.I+i];M.PC+=2;)				//LD   Vx, [I]

void f0(word opcode){inst H[2]={f00e0,f00ee};H[opcode>>1&1](opcode);}
void f1(word opcode){f1nnn(opcode);}
void f2(word opcode){f2nnn(opcode);}
void f3(word opcode){f3xkk(opcode);}
void f4(word opcode){f4xkk(opcode);}
void f5(word opcode){f5xy0(opcode);}
void f6(word opcode){f6xkk(opcode);}
void f7(word opcode){f7xkk(opcode);}
void f8(word opcode){inst H[16]={f8xy0,f8xy1,f8xy2,f8xy3,f8xy4,f8xy5,f8xy6,f8xy7,0,0,0,0,0,0,f8xye,0};H[opcode&0xf](opcode);}
void f9(word opcode){f9xy0(opcode);}
void fa(word opcode){fannn(opcode);}
void fb(word opcode){fbnnn(opcode);}
void fc(word opcode){fcxkk(opcode);}
void fd(word opcode){fdxyn(opcode);}
void fe(word opcode){inst H[2]={fex9e,fexa1};H[opcode&1](opcode);}
void ff(word opcode){switch(opcode&0xff){
  case 0x07:ffx07(opcode);break;
  case 0x0a:ffx0a(opcode);break;
  case 0x15:ffx15(opcode);break;
  case 0x18:ffx18(opcode);break;
  case 0x1e:ffx1e(opcode);break;
  case 0x29:ffx29(opcode);break;
  case 0x33:ffx33(opcode);break;
  case 0x55:ffx55(opcode);break;
  case 0x65:ffx65(opcode);break;}}

int main(int argc,char*argv[]){
  inst OP[16]={f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe};
  long s;size_t n,i;
  FILE*in=fopen(argv[1],"rb");
  fseek(in,0,SEEK_END);
  s=ftell(in);
  rewind(in);
  n=fread(M.MEM+0x200,1,s,in);
  for(i=0;i<n;++i)printf("%02hhx  ",M.MEM[0x200+i]);
  fclose(in);
  return 0;
}
