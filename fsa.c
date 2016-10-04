#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int*T,r=0;

void A(char*cmd){
  int s=0;
  for(;*cmd;++cmd)
    if(T[s*26+*cmd-'A']>0)s=T[s*26+*cmd-'A'];
    else{T[s*26+*cmd-'A']=++r;T=realloc(T,sizeof(int)*26*(r+1));}
}
  
void main(){
  T=malloc(sizeof(int)*26);
  A("CLS");
  /*A("RET");
    A("JP D");*/
  int i,j;
  for(i=0;i<r;++i){
    for(j=0;j<26;j++)printf("%2d ",T[i*26+j]);
    puts("");
  }
  free(T);
}

/*
CLS         
RET         
JP   addr   
CALL addr   
SE   Vx, add
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

