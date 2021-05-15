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
  int sock;
  nick=strtok(NULL," ");
  msg=strtok(NULL,"\n");
  //busca el nombre en la tabla y si existe le manda
  //el mensaje al socket y "ok" al usuario, sino "err"
  if(0<(sock=sstate_sget(tst->sst,nick))){
    send(sock,msg,MSGMAX,0);
    send(tst->sock,"ok",2,0);
  }else send(tst->sock,"err",3,0);
}
int quit(tstate*tst){
  //elimina el socket de la tabla
  //pone en 0 la bandera de activo
  tst->sst->stable[tst->id]=-1;
  tst->act=0;
  if(0>send(tst->sock,"ok",2,0)) terr("send fallo");
  return 0;
}
void nickname(tstate*tst){
  char*nick;
  nick=strtok(NULL,"\n");
  pthread_mutex_lock(&tst->sst->mut);
  //busca el nuevo nombre en la tabla y si no existe
  //cambia de lugar el numero de socket
  if(0>sstate_sget(tst->sst,nick)){
    tst->sst->stable[tst->id]=-1;
    tst->id=hash(nick,tst->sst->N);
    sstate_sset(tst->sst,nick,tst->sock);
    if(0>send(tst->sock,"ok",2,0)) terr("send fallo");
  }else send(tst->sock,"err",3,0);
  pthread_mutex_unlock(&tst->sst->mut);
}
//main de cada thread
void*tmain(void*a){
  char buffer[BUFMAX],*cmd;
  tstate*tst=(tstate*)a;
  int test=1;
  ssize_t nbytes;
  //lo primero que hace es tomar el nombre de usuario
  //si no esta usado envia 'ok' y sigue, sino envia 'err' y vuelve a quedarse esperando
  while(0<test){
    if(0>(nbytes=recv(tst->sock,buffer,NAMMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    pthread_mutex_lock(&tst->sst->mut);
    if(0>(test=sstate_sget(tst->sst,buffer))){
      sstate_sset(tst->sst,buffer,tst->sock);
      tst->id=hash(buffer,tst->sst->N);
      send(tst->sock,"ok",2,0);
    }else send(tst->sock,"err",3,0);
    pthread_mutex_unlock(&tst->sst->mut);
  }
  printf("%s ha ingresado a la sala\n",buffer);
  //una vez que entra queda esperando mensajes del usuario
  while(test){
    if(0>(nbytes=recv(tst->sock,buffer,BUFMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    cmd=strtok(buffer," ");
    printf("[%d]:%s\n",tst->sock,cmd);
    if     (0==strncmp(cmd,"/msg",4)) msg(tst);
    else if(0==strncmp(cmd,"/exit",5)) test=quit(tst);
    else if(0==strncmp(cmd,"/nickname",9)) nickname(tst);
    else send(tst->sock,"err",3,0);
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
  //estado global. tiene a todos los usuarios
  sstate sst;
  //estado para cada thread. tiene el socket de cada usuario y un puntero al estado global
  tstate tst[CLIMAX];
  if(argc>1){
    //inicio de conexion
    if(0>(sserv=socket(AF_INET,SOCK_STREAM,0))) err("sock fallo");
    aserv.sin_family=AF_INET;
    aserv.sin_addr.s_addr=INADDR_ANY;
    aserv.sin_port=htons(atoi(argv[1]));
    if(bind(sserv,(struct sockaddr*)&aserv,sizeof(aserv))) err("bind fallo");
    if(0>listen(sserv,CLIMAX)) err("listen fallo");
    lcli=sizeof(acli);
    //configuracion de pthreads
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
    //inicio de estados
    sstate_init(&sst,CLIMAX);
    for(i=0;i<CLIMAX;i++) tstate_init(&tst[i],&sst);
    //el servidor empieza a aceptar usuarios y crea un pthread para la sesion de cada uno
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
