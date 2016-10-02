#include<time.h>
#include<stdlib.h>

struct CHIP8 {
  unsigned char MEM[4096],SCR[32][8],V[16];
  unsigned char DT,ST,SP;
  unsigned short STK[16];
  unsigned short I,PC,KB;  
} M;

char MAP[256];
void*HDL[0xffff]={0};

#define F0(id,body) void F##id(unsigned opcode){HDL[id]=F##id;do{body}while(0);}
#define F1(id,body) void F##id(unsigned opcode){HDL[id]=F##id;unsigned x=opcode&0x0f00>>8;do{body}while(0);}
#define F2(id,body) void F##id(unsigned opcode){HDL[id]=F##id;unsigned x=opcode&0x0f00>>8,y=opcode&0x00f0>>4;do{body}while(0);}
#define F3(id,body) void F##id(unsigned opcode){HDL[id]=F##id;unsigned x=opcode&0x0f00>>8,y=opcode&0x00f0>>4,n=opcode&0x000f;do{body}while(0);}
#define FK(id,body) void F##id(unsigned opcode){HDL[id]=F##id;unsigned x=opcode&0x0f00>>8,kk=opcode&0x00ff;do{body}while(0);}
#define FN(id,body) void F##id(unsigned opcode){HDL[id]=F##id;unsigned nnn=opcode&0x0fff;do{body}while(0);}

F0(0x00e0,int i;for(i=0;i<256;++i)M.SCR[i/8][i%8]=0;M.PC+=2;)					//CLS
F0(0x00ee,M.PC=M.STK[M.ST--];)									//RET
FN(0x1000,M.PC=nnn;)										//JP   addr
FN(0x2000,M.STK[++M.SP]=M.PC;M.PC=nnn;)								//CALL addr
FK(0x3000,if(M.V[x]==kk)M.PC+=2;)								//SE   Vx, addr
FK(0x4000,if(M.V[x]!=kk)M.PC+=2;)								//SNE  Vx, byte
F2(0x5000,if(M.V[x]==M.V[y])M.PC+=2;)								//SE   Vx, Vy
FK(0x6000,M.V[x]=kk;M.PC+=2;)									//LD   Vx, byte
FK(0x7000,M.V[x]+=kk;M.PC+=2;)									//ADD  Vx, byte
F2(0x8000,M.V[y]=M.V[x];M.PC+=2;)								//LD   Vx, Vy
F2(0x8001,M.V[x]|=M.V[y];M.PC+=2;)								//OR   Vx, Vy
F2(0x8002,M.V[x]&=M.V[y];M.PC+=2;)								//AND  Vx, Vy
F2(0x8003,M.V[x]^=M.V[y];M.PC+=2;)								//XOR  Vx, Vy
F2(0x8004,unsigned short S=M.V[x]+M.V[y];M.V[x]=S&0xf;M.V[0xf]=(0x10&S)>>8;M.PC+=2;)		//ADD  Vx, Vy
F2(0x8005,M.V[0xf]=M.V[x]>M.V[y];M.V[x]-=M.V[y];M.PC+=2;)					//SUB  Vx, Vy
F2(0x8006,M.V[0xf]=M.V[x]&1;M.V[x]>>=1;M.PC+=2;)						//SHR  Vx{, Vy}
F2(0x8007,M.V[0xf]=M.V[y]>M.V[x];M.V[x]=M.V[y]-M.V[x];M.PC+=2;)					//SUBN Vx, Vy
F2(0x800e,M.V[0xf]=M.V[x]&0x80;M.V[x]<<=1;M.PC+=2;)						//SHL  Vx{, Vy}
F2(0x9000,M.PC+=2*(M.V[x]!=M.V[y]);M.PC+=2;)							//SNE  Vx, Vy
FN(0xa000,M.I=nnn;M.PC+=2;)									//LD   I, addr
FN(0xb000,M.PC=nnn+M.V[0];)									//JP   V0, addr
FK(0xc000,srand(time(NULL));M.V[x]=(rand()%256)&kk;M.PC+=2;)					//RND  Vx, byte
F3(0xd000,M.V[0xf]=0;int i;for(i=0;i<n;++i){							//DRW  Vx, Vy, nibble
    //if pixel erased set VF=1
    M.SCR[M.V[x]+i][M.V[y]/8]^=M.MEM[M.I+i]>>M.V[y];
    M.SCR[M.V[x]+i][(M.V[y]/8+1)%8]^=M.MEM[M.I+i]<<(8-M.V[y]);}
  M.PC+=2;)
F1(0xe09e,M.PC+=2*(M.KB&(1<<M.V[x]));M.PC+=2;)							//SKP  Vx
F1(0xe0a1,M.PC+=2*(0==M.KB&(1<<M.V[x]));M.PC+=2;)						//SKPN Vx
F1(0xf007,M.V[x]=M.DT;M.PC+=2;)									//LD   Vx, DT
F1(0xf00a,M.V[x]=MAP[getchar()];M.PC+=2;)						        //LD   Vx, K
F1(0xf015,M.DT=M.V[x];M.PC+=2;)									//LD   DT, Vx
F1(0xf018,M.ST=M.V[x];M.PC+=2;)									//LD   ST, Vx
F1(0xf01e,M.I+=M.V[x];M.PC+=2;)									//ADD  I, Vx
F1(0xf029,M.PC+=2;)										//LD   F, Vx
F1(0xf033,M.MEM[M.I]=M.V[x]/100;M.MEM[M.I+1]=(M.V[x])%100/10;M.MEM[M.I+2]=M.V[x]%10;M.PC+=2;)	//LD   B, Vx
F1(0xf055,int i;for(i=0;i<M.V[x];++i)M.MEM[M.I+i]=M.V[i];M.PC+=2;)				//LD   [I], Vx
F1(0xf065,int i;for(i=0;i<M.V[x];++i)M.V[i]=M.MEM[M.I+i];M.PC+=2;)				//LD   Vx, [I]

/*
Fx29 - LD F, Vx
Set I = location of sprite for digit Vx.

The value of I is set to the location for the hexadecimal sprite corresponding to the value of Vx. See section 2.4, Display, for more information on the Chip-8 hexadecimal font.
*/
void main(){}
