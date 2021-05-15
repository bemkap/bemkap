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

void msg(tstate*tst){
  char*nick,*msg;
  nick=strtok(NULL," ");
  msg=strtok(NULL,"\n");
  if(tst->sst->stable[hash(nick,CLIMAX)]>0){
    send(tst->sst->stable[hash(nick,CLIMAX)],msg,MSGMAX,0);
    send(tst->sock,"ok",2,0);
  }else send(tst->sock,"err",3,0);
}
int quit(tstate*tst){
  for(int i=0;i<CLIMAX;i++)
    if(tst->sst->stable[i]==tst->sock){
      tst->sst->stable[i]=-1;
      break;
    }
  if(0>send(tst->sock,"ok",2,0)) terr("send fallo");
  return 0;
}
void nickname(tstate*tst){
  char*nick;
  nick=strtok(NULL,"\n");
  if(tst->sst->stable[hash(nick,CLIMAX)]<0){
    pthread_mutex_lock(&tst->sst->mut);
    for(int i=0;i<CLIMAX;i++)
      if(tst->sst->stable[i]==tst->sock){
        tst->sst->stable[i]=-1;
        tst->act=0;
        break;
      }
    tst->sst->stable[hash(nick,CLIMAX)]=tst->sock;
    pthread_mutex_unlock(&tst->sst->mut);
    send(tst->sock,"ok",2,0);
  }else send(tst->sock,"err",3,0);
}
void*tmain(void*a){
  char buffer[BUFMAX],*cmd;
  tstate*tst=(tstate*)a;
  int test=0;
  ssize_t nbytes;

  while(!test){
    if(0>(nbytes=recv(tst->sock,buffer,NAMMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    pthread_mutex_lock(&tst->sst->mut);
    if((test=(tst->sst->stable[hash(buffer,CLIMAX)]<0))){
      tst->sst->stable[hash(buffer,CLIMAX)]=tst->sock;
      send(tst->sock,"ok",2,0);
    }else send(tst->sock,"err",3,0);
    pthread_mutex_unlock(&tst->sst->mut);
  }
  printf("%s ha ingresado a la sala\n",buffer);
  while(test){
    if(0>(nbytes=recv(tst->sock,buffer,BUFMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    cmd=strtok(buffer," ");
    printf("[%d]:%s\n",tst->sock,cmd);
    if     (0==strncmp(cmd,"/msg",4)) msg(tst);
    else if(0==strncmp(cmd,"/exit",5)) test=quit(tst);
    else if(0==strncmp(cmd,"/nickname",9)) nickname(tst);
  }
  close(tst->sock);
  pthread_exit(0);
}
int main(int argc,char*argv[]){
  struct sockaddr_in aserv,acli;
  pthread_attr_t attr;
  int sserv,scli,i;
  socklen_t lcli;
  pthread_t tt;
  tstate tst[CLIMAX];
  sstate sst;

  if(argc>1){
    sstate_init(&sst,CLIMAX);
    if(0>(sserv=socket(AF_INET,SOCK_STREAM,0))) err("sock fallo");
    aserv.sin_family=AF_INET;
    aserv.sin_addr.s_addr=INADDR_ANY;
    aserv.sin_port=htons(atoi(argv[1]));
    if(bind(sserv,(struct sockaddr*)&aserv,sizeof(aserv))) err("bind fallo");
    if(0>listen(sserv,CLIMAX)) err("listen fallo");
    lcli=sizeof(acli);
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
    for(i=0;i<CLIMAX;i++) tstate_init(&tst[i],&sst);
    for(;;){
      if(0>(scli=accept(sserv,(struct sockaddr*)&acli,&lcli))) err("accept fallo");
      for(i=0;i<CLIMAX;i++)
        if(!tst[i].act){
          tst[i].sock=scli;
          tst[i].act=1;
          break;
        }
      if(i<CLIMAX)if(0<pthread_create(&tt,&attr,tmain,(void*)&tst[i])) err("pthread_create fallo");
    }
    return 0;
  }
  printf("uso: %s <puerto>\n",argv[0]);
  return 1;
}
