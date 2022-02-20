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

void msg(char*buffer,tstate*tst){
  char*nick,*msg,msg1[MSGMAX+4];
  int sock;
  strtok(buffer," \n");
  nick=strtok(NULL," ");
  msg=strtok(NULL,"\n");
  //busca el nombre en la tabla y si existe le manda
  //el mensaje al socket y "ok" al cliente, sino "err"
  if(0<(sock=sstate_sget(tst->sst,nick))){
    strcpy(msg1,"usr:");
    strcpy(msg1+4,msg);
    if(0>send(sock,msg1,strlen(msg1),0)) terr("send fallo");
    if(0>send(tst->sock,MSGOK,sizeof(MSGOK),0)) terr("send fallo");
  }else send(tst->sock,MSGERR,sizeof(MSGERR),0);
}
int quit(char*buffer,tstate*tst){
  strtok(buffer," \n");
  //elimina el socket de la tabla
  //pone en 0 la bandera de activo
  pthread_mutex_lock(&tst->sst->mut);
  tst->sst->stable[tst->id]=-1;
  pthread_mutex_unlock(&tst->sst->mut);
  tst->act=0;
  if(0>send(tst->sock,MSGBYE,sizeof(MSGBYE),0)) terr("send fallo");
  return 0;
}
void nickname(char*buffer,tstate*tst){
  char*nick;
  strtok(buffer," \n");
  nick=strtok(NULL,"\n");
  pthread_mutex_lock(&tst->sst->mut);
  //busca el nuevo nombre en la tabla y si no existe
  //cambia de lugar el numero de socket
  if(0>sstate_sget(tst->sst,nick)){
    tst->sst->stable[tst->id]=-1;
    tst->id=hash(nick,tst->sst->N);
    sstate_sset(tst->sst,nick,tst->sock);
    if(0>send(tst->sock,MSGOK,sizeof(MSGOK),0)) terr("send fallo");
  }else send(tst->sock,MSGERR,sizeof(MSGERR),0);
  pthread_mutex_unlock(&tst->sst->mut);
}
void msg_all(char*buffer,tstate*tst){
  char msg1[MSGMAX+4];
  strcpy(msg1,"all:");
  strcpy(msg1+4,buffer);
  //busca los clientes en la tabla que no sean uno mismo
  //y manda el mensaje
  for(int i=0;i<tst->sst->N;i++)
    if(tst->sst->stable[i]>=0&&tst->sst->stable[i]!=tst->sock)
      if(0>send(tst->sst->stable[i],msg1,MSGMAX,0)) terr("send fallo");
  send(tst->sock,MSGOK,sizeof(MSGOK),0);
}  
//main de cada thread
void*tmain(void*a){
  char buffer[BUFMAX];
  tstate*tst=(tstate*)a;
  int test=1;
  ssize_t nbytes;
  //lo primero que hace es tomar el nombre de cliente
  //si no esta usado envia 'ok' y sigue, sino envia 'err' y vuelve a quedarse esperando
  while(0<test){
    switch(nbytes=recv(tst->sock,buffer,NAMMAX,0)){
    case  0: test=0; break;
    case -1: terr("recv fallo");
    default:
      buffer[nbytes-1]='\0';
      pthread_mutex_lock(&tst->sst->mut);
      if(0>(test=sstate_sget(tst->sst,buffer))){
        sstate_sset(tst->sst,buffer,tst->sock);
        tst->id=hash(buffer,tst->sst->N);
        send(tst->sock,MSGOK,sizeof(MSGOK),0);
      }else send(tst->sock,MSGERR,sizeof(MSGERR),0);
      pthread_mutex_unlock(&tst->sst->mut);
    }
    printf("%s[%d] ha ingresado\n",buffer,tst->sock);
  }
  //una vez que entra queda esperando mensajes del cliente
  while(test){
    switch(nbytes=recv(tst->sock,buffer,BUFMAX,0)){
    case  0:
      printf("[%d]:/exit\n",tst->sock);
      test=quit(buffer,tst);
      break;
    case -1: terr("recv fallo");
    default:
      buffer[nbytes]='\0';
      printf("[%d]:%s",tst->sock,buffer);
      if     (0==strncmp(buffer,"/msg",4)) msg(buffer,tst);
      else if(0==strncmp(buffer,"/exit",5)) test=quit(buffer,tst);
      else if(0==strncmp(buffer,"/nickname",9)) nickname(buffer,tst);
      else msg_all(buffer,tst);//si no encuentra el comando envia el mensaje a todos
    }
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
  //estado global. tiene a todos los clientes
  sstate sst;
  //estado para cada thread. tiene el socket de cada cliente y un puntero al estado global
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
    //el servidor empieza a aceptar clientes y crea un pthread para la sesion de cada uno
    for(;;){
      if(0>(scli=accept(sserv,(struct sockaddr*)&acli,&lcli))) err("accept fallo");
      for(i=0;i<CLIMAX;i++)
        if(!tst[i].act){
          tst[i].sock=scli;
          tst[i].act=1;
          break;
        }
      if(i<CLIMAX){
        if(0<pthread_create(&tt,&attr,tmain,(void*)&tst[i])) err("pthread_create fallo");
      }else{
        if(0>send(scli,MSGBYE,sizeof(MSGBYE),0)) err("send fallo");
      }
    }
    return 0;
  }
  printf("uso: %s <puerto>\n",argv[0]);
  return 1;
}
