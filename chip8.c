#include<time.h>
#include<stdlib.h>

struct CHIP8 {
  unsigned char MEM[4096],SCR[32][8],V[16];
  unsigned char DT,ST,SP;
  unsigned short STK[16];
  unsigned short I,PC,KB;
} M;

#define F0(inst,opcode,body) void inst##opcode(){do{body}while(0);}
#define F1(inst,opcode,body) void inst##opcode(){unsigned x=opcode&0x0f00>>8;do{body}while(0);}
#define F2(inst,opcode,body) void inst##opcode(){unsigned x=opcode&0x0f00>>8,y=opcode&0x00f0>>4;do{body}while(0);}
#define F2(inst,opcode,body) void inst##opcode(){unsigned x=opcode&0x0f00>>8,y=opcode&0x00f0>>4,n=opcode&0x000f;do{body}while(0);}
#define FK(inst,opcode,body) void inst##opcode(){unsigned x=opcode&0x0f00>>8,kk=opcode&0x00ff;do{body}while(0);}
#define FN(inst,opcode,body) void inst##opcode(){unsigned nnn=opcode&0x0fff;do{body}while(0);}

F0( cls,00e0,int i;for(i=0;i<256;++i)M.SCR[i]=0;M.PC+=2;)
F0( ret,00ee,M.PC=STK[ST--];)
FN(  jp,1nnn,M.PC=nnn;)
FN(call,2nnn,STK[++SP]=PC;PC=nnn;)
FK(  se,3xkk,if(M.V[x]==kk)M.PC+=2;)
FK( sne,4xkk,if(M.V[x]!=kk)M.PC+=2;)
F2(  se,5xy0,if(M.V[x]==M.V[y])M.PC+=2;)
FK(  ld,6xkk,M.V[x]=kk;M.PC+=2;)
FK( add,7xkk,M.V[x]+=kk;M.PC+=2;)
F2(  ld,8xy0,M.V[y]=M.V[x];M.PC+=2;)
F2(  or,8xy1,M.V[x]|=M.V[y];M.PC+=2;)
F2( and,8xy2,M.V[x]&=M.V[y];M.PC+=2;)
F2( xor,8xy3,M.V[x]^=M.V[y];M.PC+=2;)
F2( add,8xy4,unsigned short S=M.V[x]+M.V[y];M.V[x]=S&0xf;M.V[0xf]=(0x10&S)>>8;M.PC+=2;)
F2( sub,8xy5,M.V[0xf]=M.V[x]>M.V[y];M.V[x]-=M.V[y];M.PC+=2;)
F2( shr,8xy6,M.V[0xf]=V[x]&1;V[x]>>=1;M.PC+=2;)
F2(subn,8xy7,M.V[0xf]=M.V[y]>M.V[x];M.V[x]=M.V[y]-M.V[x];M.PC+=2;)
F2( shl,8xyE,M.V[0xf]=M.V[x]&0x80;M.V[×]<<=1;M.PC+=2;)
F2( sne,9xy0,M.PC+=2*(M.V[x]!=M.V[y]);M.PC+=2;)
FN(  ld,Annn,M.I=nnn;M.PC+=2;)
FN(  jp,Bnnn,M.PC=nnn+V[0];)
FK( rnd,Cxkk,srand(time(NULL));M.V[x]=(rand()%256)&kk;M.PC+=2;)
F3( drw,Dxyn,M.V[0xf]=0;for(int i=0;i<n;++i){
    //if pixel erased set VF=1
    M.SCR[M.V[x]+i][M.V[y]/8]^=M.MEM[M.I+i]>>M.V[y];
    M.SCR[M.V[x]+i][(M.V[y]/8+1)%8]^=M.MEM[M.I+i]<<(8-M.V[y]);}
  M.PC+=2;)
F1( skp,ex9e,M.PC+=2*(M.KB&(1<<M.V[x]));M.PC+=2;)
F1(sknp,exa1,M.PC+=2*(0==M.KB&(1<<M.V[x]));M.PC+=2;)
F1(  ld,fx07,M.V[x]=M.DT;M.PC+=2;)
F1(  ld,fx0a,M.V[x]=MAP[getchar()];M.PC+=2;)
F1(  ld,fx15,M.DT=M.V[x];M.PC+=2;)
F1(  ld,fx18,M.ST=M.V[x];M.PC+=2;)
F1( add,fx1e,M.I+=M.V[x];M.PC+=2;)
F1(  ld,fx29,M.PC+=2;)
F1(  ld,fx33,M.MEM[M.I]=M.V[x]/100;M.MEM[M.I+1]=(M.V[x])%100/10;M.MEM[M.I+2]=M.V[x]%10;M.PC+=2;)
F1(  ld,fx55,for(int i=0;i<M.x;++i)M.MEM[M.I+i]=M.V[i];M.PC+=2;)
F1(  ld,fx65,for(int i=0;i<M.x;++i)M.V[i]=M.MEM[M.I+i];M.PC+=2;)

/*

Fx29 - LD F, Vx
Set I = location of sprite for digit Vx.

The value of I is set to the location for the hexadecimal sprite corresponding to the value of Vx. See section 2.4, Display, for more information on the Chip-8 hexadecimal font.

*/
void main(){}
