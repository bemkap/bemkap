#include"chip8.h"

F(x00e0,memset(M->SCR,0,32*8))
F(x00ee,M->PC=M->STK[M->SP--])
F(x1nnn,M->PC=nnn)
F(x2nnn,M->STK[++M->SP]=M->PC;M->PC=nnn)
F(x3xkk,if(M->V[x]==kk) M->PC+=2)
F(x4xkk,if(M->V[x]!=kk) M->PC+=2)
F(x5xy0,if(M->V[x]==M->V[y]) M->PC+=2)
F(x6xkk,M->V[x]=kk)
F(x7xkk,M->V[x]+=kk)
F(x8xy0,M->V[x]=M->V[y])
F(x8xy1,M->V[x]|=M->V[y])
F(x8xy2,M->V[x]&=M->V[y])
F(x8xy3,M->V[x]^=M->V[y])
F(x8xy4,M->V[x]+=M->V[y];M->V[0xf]=M->V[x]<M->V[y])
F(x8xy5,M->V[0xf]=M->V[x]>M->V[y];M->V[x]-=M->V[y])
F(x8xy6,M->V[0xf]=M->V[x]&1;M->V[x]=M->V[y]>>1)
F(x8xy7,M->V[0xf]=M->V[y]>M->V[x];M->V[x]=M->V[y]-M->V[x])
F(x8xye,M->V[0xf]=M->V[x]>>7&1;M->V[x]=M->V[y]<<1)
F(x9xy0,if(M->V[x]!=M->V[y]) M->PC+=2)
F(xannn,M->I=nnn)
F(xbnnn,M->PC=nnn+M->V[0x0])
F(xcxkk,srand(time(NULL));M->V[x]=(rand()%256)&kk)
F(xdxyn,for(byte i=0;i<n;++i){
    byte l=M->SCR[M->V[y]+i][M->V[x]>>3];
    byte r=M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8];
    M->SCR[M->V[y]+i][M->V[x]>>3]^=M->MEM[M->I+i]>>(M->V[x]%8);
    M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8]^=M->MEM[M->I+i]<<(8-M->V[x]%8);
    M->V[0xf]=(l&M->SCR[M->V[y]+i][M->V[x]>>3])==l;
    M->V[0xf]|=(r&M->SCR[M->V[y]+i][((M->V[x]>>3)+1)%8])==r;
  })
F(xex9e,if(M->KB>>M->V[x]&1) M->PC+=2)
F(xexa1,if(!(M->KB>>M->V[x]&1)) M->PC+=2)
F(xfx07,M->V[x]=M->DT)
F(xfx0a,M->V[x]=MAP[getchar()%256])
F(xfx15,M->DT=M->V[x])
F(xfx18,M->ST=M->V[x])
F(xfx1e,M->I+=M->V[x])
F(xfx29,M->I=M->MEM[M->V[x]*5])
F(xfx33,M->MEM[M->I]=M->V[x]/100;M->MEM[M->I+1]=(M->V[x]%100)/10;M->MEM[M->I+2]=M->V[x]%10)
F(xfx55,for(byte i=0;i<=x;++i) M->MEM[M->I++]=M->V[i])
F(xfx65,for(byte i=0;i<=x;++i) M->V[i]=M->MEM[M->I++])

void f0(struct CHIP8*M,word oc){(inst[]){x00e0,x00ee}[oc>>1&1](M,oc);}
void f8(struct CHIP8*M,word oc){(inst[]){x8xy0,x8xy1,x8xy2,x8xy3,x8xy4,x8xy5,x8xy6,x8xy7,0,0,0,0,0,0,x8xye,0}[oc&0xf](M,oc);}
void fe(struct CHIP8*M,word oc){(inst[]){xex9e,xexa1}[oc&1](M,oc);}
void ff(struct CHIP8*M,word oc){inst H[256];
  H[0x07]=xfx07;H[0x0a]=xfx0a;H[0x15]=xfx15;H[0x18]=xfx18;H[0x1e]=xfx1e;
  H[0x29]=xfx29;H[0x33]=xfx33;H[0x55]=xfx55;H[0x65]=xfx65;
  H[oc&0xff](M,oc);
}

inst OP[16]={f0,x1nnn,x2nnn,x3xkk,x4xkk,x5xy0,x6xkk,x7xkk,f8,x9xy0,xannn,xbnnn,xcxkk,xdxyn,fe,ff};

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
  r=SDL_CreateRenderer(w,-1,SDL_RENDERER_ACCELERATED);
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
    word i=M.MEM[M.PC]<<8|M.MEM[M.PC+1];
    M.PC+=2;
    OP[i>>12&0xf](&M,i);
    //draw
    for(word i=0;i<32*64;++i) pixmap[i]=0xffffff*(M.SCR[i/64][i%64/8]>>(7-i%8)&1);
    SDL_UpdateTexture(t,NULL,pixmap,64*4);
    SDL_RenderCopy(r,t,NULL,NULL);
    SDL_RenderPresent(r);
    SDL_Delay(1000/100);
    //delay,sound
    M.DT=(--M.DT<0)?0:M.DT;
    M.ST=(--M.ST<0)?0:M.ST;
  }
  close_sdl();
  return 0;
}
