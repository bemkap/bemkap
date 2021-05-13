#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<string.h>
#include"const.h"
#include"util.h"
#include"state.h"

void err(const char*msg){
  perror(msg);
  exit(EXIT_FAILURE);
}
void*fthread(void*a){
  char nick[NAMMAX],cmd[10],msg[LENMAX];
  state*st=(state*)a;
  int h,test=0; //booleano usado para probar si esta usado el nickname y bucle principal

  pthread_mutex_lock(&st->mut);
  if(st->n>=st->N){
    printf("sala llena. intente luego\n");
    pthread_exit(EXIT_SUCCESS);
  }else st->n++;
  while(!test){
    printf("nickname(<32 caracteres): ");
    read(STDIN_FILENO,nick,sizeof(nick));
    if((test=(st->stable[hash(nick,NAMMAX)]<0))) st->stable[hash(nick,NAMMAX)]=st->sock;
    else printf("nombre ocupado. ingrese otro\n");
  }
  pthread_mutex_unlock(&st->mut);
  printf("bienvenido\n");
  while(test){
    printf("> ");
    scanf("%10s",cmd);
    if(0==strncmp(cmd,"/msg",4)){
      scanf("%32s %1024s",nick,msg);
      printf("mensaje enviado");
    }else if(0==strncmp(cmd,"/exit",5)){
      test=0;
    }else if(0==strncmp(cmd,"/nickname",9)){
      scanf("%32s",nick);
      printf("nick cambiado");
    }
  }
}
int main(int argc,char*argv[]){
  int sserv,scli;
  struct sockaddr_in aserv,acli;
  socklen_t lcli;
  state st;
  pthread_t tt;

  if(argc>1){
    state_init(&st,CLIMAX);
    if(0>(sserv=socket(AF_INET,SOCK_STREAM,0))) err("sock fallo");
    aserv.sin_family=AF_INET;
    aserv.sin_addr.s_addr=INADDR_ANY;
    aserv.sin_port=htons(atoi(argv[1]));
    if(bind(sserv,(struct sockaddr*)&aserv,sizeof(aserv))) err("bind fallo");
    if(0>listen(sserv,CLIMAX)) err("listen fallo");
    lcli=sizeof(acli);
    for(;;){
      if(0>(scli=accept(sserv,(struct sockaddr*)&acli,&lcli))) err("accept fallo");
      if(0<pthread_create(&tt,NULL,fthread,(void*)&st)) err("pthread_create fallo");
    }
  }
  printf("uso: %s <puerto>\n");
  exit(EXIT_SUCCESS);
}
