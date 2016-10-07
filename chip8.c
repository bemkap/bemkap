#include"chip8.h"

F(x00e0,for(word i=0;i<32*64;++i) SCR[i]=0;PC+=2)        		//CLS
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
      if(SCR[Vx+i*64+(Vy+j)%64]+(MEM[I+i]>>j)&1==2) VF=1;
      SCR[(Vx+i)*64+(Vy+j)%64]^=(MEM[I+i]>>j)&1;
    }
  PC+=2)
F(xex9e,PC+=2*(KB&(1<<Vx));PC+=2)					//SKP  Vx
F(xexa1,PC+=2*(0==KB&(1<<Vx));PC+=2)					//SKPN Vx
F(xfx07,Vx=DT;PC+=2)							//LD   Vx, DT
F(xfx0a,Vx=getchar();PC+=2)            					//LD   Vx, K
F(xfx15,DT=Vx;PC+=2)							//LD   DT, Vx
F(xfx18,ST=Vx;PC+=2)							//LD   ST, Vx
F(xfx1e,I+=Vx;PC+=2)							//ADD  I, Vx
F(xfx29,I=MEM[Vx];PC+=2)						//LD   F, Vx
F(xfx33,MEM[I]=Vx/100;MEM[I+1]=(Vx)%100/10;MEM[I+2]=Vx%10;PC+=2)	//LD   B, Vx
F(xfx55,for(byte i=0;i<Vx;++i) MEM[I+i]=V[i];PC+=2)			//LD   [I], Vx
F(xfx65,for(byte i=0;i<Vx;++i) V[i]=MEM[I+i];PC+=2)			//LD   Vx, [I]

void f0(struct CHIP8*M,word oc){(inst[]){x00e0,x00ee}[oc>>1&1](M,oc);}
void f8(struct CHIP8*M,word oc){(inst[]){x8xy0,x8xy1,x8xy2,x8xy3,x8xy4,x8xy5,x8xy6,x8xy7,0,0,0,0,0,0,x8xye,0}[oc&0xf](M,oc);}
void fe(struct CHIP8*M,word oc){(inst[]){xex9e,xexa1}[oc&1](M,oc);}
void ff(struct CHIP8*M,word oc){inst H[256];
  H[0x07]=xfx07;H[0x0a]=xfx0a;H[0x15]=xfx15;H[0x18]=xfx18;H[0x1e]=xfx1e;
  H[0x29]=xfx29;H[0x33]=xfx33;H[0x55]=xfx55;H[0x65]=xfx65;
  H[oc&0xff](M,oc);
}

byte charset[5*16]={
  0xf0,0x90,0x90,0x90,0xf0,  0x20,0x60,0x20,0x20,0x70,  0xf0,0x10,0xf0,0x80,0xf0,  0xf0,0x10,0xf0,0x10,0xf0,
  0x90,0x90,0xf0,0x10,0x10,  0xf0,0x80,0xf0,0x10,0xf0,  0xf0,0x80,0xf0,0x90,0xf0,  0xf0,0x10,0x20,0x40,0x40,
  0xf0,0x90,0xf0,0x90,0xf0,  0xf0,0x90,0xf0,0x10,0xf0,  0xf0,0x90,0xf0,0x90,0x90,  0xe0,0x90,0xe0,0x90,0xe0,
  0xf0,0x80,0x80,0x80,0xf0,  0xe0,0x90,0x90,0x90,0xe0,  0xf0,0x80,0xf0,0x80,0xf0,  0xf0,0x80,0xf0,0x80,0x80
};

void init(struct CHIP8*M,char*fp){
  FILE*in=fopen(fp,"rb");
  fread(M->MEM+0x200,1,4096-0x200,in);
  fclose(in);
  memcpy(M->MEM,charset,5*16);
  M->PC=0x200;
  M->I=M->SP=0;
}

SDL_Window*w;
SDL_Surface*s;

void init_sdl(){
  SDL_Init(SDL_INIT_VIDEO);
  w=SDL_CreateWindow("",SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,640,320,SDL_WINDOW_SHOWN);
  s=SDL_GetWindowSurface(w);
}

void close_sdl(){
  SDL_FreeSurface(s);
  SDL_DestroyWindow(w);
  SDL_Quit();
}

int main(int argc,char*argv[]){
  inst OP[16]={f0,x1nnn,x2nnn,x3xkk,x4xkk,x5xy0,x6xkk,x7xkk,f8,x9xy0,xannn,xbnnn,xcxkk,xdxyn,fe};
  struct CHIP8 M;
  init(&M,argv[1]);
  init_sdl();
  for(;;){
    //exec
    word i=*(word*)(M.MEM+0x200+M.PC);
    OP[i>>12&0xf](&M,i);
    //draw
    for(word i=0;i<32*64;++i) SDL_FillRect(s,&(SDL_Rect){10*i/64,10*i%64,10,10},M.SCR[i]?WHITE:BLACK);
    SDL_UpdateWindowSurface(w);
    //update
    M.DT=(--M.DT<0)?0:M.DT;
    M.ST=(--M.ST<0)?0:M.ST;
  }
  close_sdl();
  return 0;
}
