#include"chip8.h"

F(f00 ,memset(M->SCR,0,32*8);M->DF=1)
F(f0e ,M->PC=M->STK[M->SP--])
G(f0  ){(inst[]){f00,f0e}[oc>>1&1](M,oc);}
F(f1  ,M->PC=nnn)
F(f2  ,M->STK[++M->SP]=M->PC;M->PC=nnn)
F(f3  ,if(M->V[x]==kk) M->PC+=2)
F(f4  ,if(M->V[x]!=kk) M->PC+=2)
F(f5  ,if(M->V[x]==M->V[y]) M->PC+=2)
F(f6  ,M->V[x]=kk)
F(f7  ,M->V[x]+=kk)
F(f80 ,M->V[x]=M->V[y])
F(f81 ,M->V[x]|=M->V[y])
F(f82 ,M->V[x]&=M->V[y])
F(f83 ,M->V[x]^=M->V[y])
F(f84 ,M->V[x]+=M->V[y];M->V[0xf]=M->V[x]<M->V[y])
F(f85 ,M->V[0xf]=M->V[x]>M->V[y];M->V[x]-=M->V[y])
F(f86 ,M->V[0xf]=M->V[x]&1;M->V[x]=M->V[y]>>1)
F(f87 ,M->V[0xf]=M->V[y]>M->V[x];M->V[x]=M->V[y]-M->V[x])
F(f8e ,M->V[0xf]=M->V[x]>>7&1;M->V[x]=M->V[y]<<1)
G(f8  ){(inst[]){f80,f81,f82,f83,f84,f85,f86,f87,0,0,0,0,0,0,f8e,0}[oc&0xf](M,oc);}
F(f9  ,if(M->V[x]!=M->V[y]) M->PC+=2)
F(fa  ,M->I=nnn)
F(fb  ,M->PC=nnn+M->V[0x0])
F(fc  ,srand(time(NULL));M->V[x]=(rand()%256)&kk)
F(fd  ,for(byte i=0;i<n;++i){
    byte l=M->SCR[M->V[y]+i][M->V[x]>>3];
    byte r=M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8];
    M->SCR[M->V[y]+i][M->V[x]>>3]^=M->MEM[M->I+i]>>(M->V[x]%8);
    M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8]^=M->MEM[M->I+i]<<(8-M->V[x]%8);
    M->V[0xf]=(l&M->SCR[M->V[y]+i][M->V[x]>>3])==l;
    M->V[0xf]|=(r&M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8])==r;
    M->DF=1;
  })
F(fee ,if(M->KB>>M->V[x]&1) M->PC+=2)
F(fe1 ,if(!(M->KB>>M->V[x]&1)) M->PC+=2)
G(fe  ){(inst[]){fee,fe1}[oc&1](M,oc);}
F(ff7 ,M->V[x]=M->DT)
F(ffa ,M->V[x]=MAP[getchar()%256])
F(ff15,M->DT=M->V[x])
F(ff8 ,M->ST=M->V[x])
F(ffe ,M->I+=M->V[x])
F(ff9 ,M->I=M->MEM[M->V[x]*5])
F(ff3 ,M->MEM[M->I]=M->V[x]/100;M->MEM[M->I+1]=(M->V[x]%100)/10;M->MEM[M->I+2]=M->V[x]%10)
F(ff55,for(byte i=0;i<=x;++i) M->MEM[M->I++]=M->V[i])
F(ff65,for(byte i=0;i<=x;++i) M->V[i]=M->MEM[M->I++])
G(ff5 ){(inst[]){0,ff15,0,0,0,ff55,ff65,0,0,0,0,0,0,0,0,0}[oc>>4&0xf](M,oc);}
G(ff  ){(inst[]){0,0,0,ff3,0,ff5,0,ff7,ff8,ff9,ffa,0,0,0,ffe,0}[oc&0xf](M,oc);}

inst OP[16]={f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe,ff};

void init(struct CHIP8*M,char*fp){
  FILE*in=fopen(fp,"rb");
  fread(M->MEM+0x200,1,4096-0x200,in);
  fclose(in);
  memcpy(M->MEM,charset,5*16);
  memset(M->SCR,0,32*8);
  M->PC=0x200;
  M->I=M->SP=0;
}

SDL_Window*w;
SDL_Renderer*r;
SDL_Texture*t;

void init_sdl(){
  SDL_Init(SDL_INIT_VIDEO);
  w=SDL_CreateWindow("",SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,640,320,SDL_WINDOW_SHOWN);
  r=SDL_CreateRenderer(w,-1,0);
  t=SDL_CreateTexture(r,SDL_PIXELFORMAT_ARGB8888,SDL_TEXTUREACCESS_STREAMING,64,32);
}

void close_sdl(){
  SDL_DestroyTexture(t);
  SDL_DestroyRenderer(r);
  SDL_DestroyWindow(w);
  SDL_Quit();
}

int main(int argc,char*argv[]){
  Uint32 pixmap[32*64];
  struct CHIP8 M;
  SDL_Event e;
  init(&M,argv[1]);
  init_sdl();
  for(int R=1;R;){
    while(SDL_PollEvent(&e))
      switch(e.type){
      case SDL_QUIT: R=0;break;
      case SDL_KEYDOWN: M.KB|=1<<MAP[e.key.keysym.sym%256];break;
      case SDL_KEYUP: M.KB&=~(1<<MAP[e.key.keysym.sym%256]);break;
      }
    //exec
    M.DF=0;
    for(word i=0;i<50000;++i){
      word oc=M.MEM[M.PC]<<8|M.MEM[M.PC+1];
      M.PC+=2;
      OP[oc>>12&0xf](&M,oc);
    }
    //draw
    for(word i=0;i<32*64;++i) pixmap[i]=0xffffff*(M.SCR[i/64][i%64/8]>>(7-i%8)&1);
    if(M.DF){
      SDL_UpdateTexture(t,NULL,pixmap,64*4);
      SDL_RenderCopy(r,t,NULL,NULL);
      SDL_RenderPresent(r);
    }
    //delay,sound
    M.DT=(--M.DT<0)?0:M.DT;
    M.ST=(--M.ST<0)?0:M.ST;
    SDL_Delay(1000/60);
  }
  close_sdl();
  return 0;
}
