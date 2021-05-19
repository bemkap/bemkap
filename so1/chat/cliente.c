#include<sys/types.h>
#include<sys/socket.h>
#include<netdb.h>
#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include"util.h"
#include"const.h"
#include"state.h"

//thread que envia mensajes
void*tsend(void*a){
  char buffer[BUFMAX];
  cstate*st=(cstate*)a;
  ssize_t nbytes;
  //mientras el cliente este activo
  while(st->act){
    //lee por entrada estandar y lo envia al servidor
    printf(PROMPT); fflush(NULL);
    nbytes=0;
    memset(buffer,0,BUFMAX);
    if(0<(nbytes=read(STDIN_FILENO,buffer,BUFMAX)))
      if(0>send(st->sock,buffer,strlen(buffer),0)) terr("send fallo");
  }
  pthread_exit(0);
}
int main(int argc,char*argv[]){
  struct addrinfo*serv;
  pthread_t ts;
  char buffer[BUFMAX],nick[NAMMAX];
  ssize_t nbytes;
  //estado de cliente. tiene el socket del servidor y si esta activo
  cstate st;
  if(argc>2){
    //conexion con el servidor
    if(0>(st.sock=socket(AF_INET,SOCK_STREAM,0))) err("socket fallo");
    if(getaddrinfo(argv[1],argv[2],NULL,&serv)) err("getaddrinfo fallo");
    if(0>connect(st.sock,(struct sockaddr*)serv->ai_addr,serv->ai_addrlen)) err("connect fallo");
    //configura el estado
    cstate_init(&st);
    for(;;){
      //despues de establecer conexion se envia el nickname
      printf("nickname: "); fflush(NULL);
      read(STDIN_FILENO,nick,NAMMAX);
      if(0>send(st.sock,nick,strlen(nick),0)) err("send fallo");
      switch(nbytes=recv(st.sock,buffer,BUFMAX,0)){
      case  0: err("servidor no responde");
      case -1: err("recv fallo");
      }
      buffer[nbytes]='\0';
      //si el servidor devuelve "ok" sale
      if     (0==strncmp(MSGOK,buffer,sizeof(MSGOK))) break;
      else if(0==strncmp(MSGBYE,buffer,sizeof(MSGBYE))){st.act=0; break;}
      else printf("%s\n",buffer);
    }
    if(st.act){
      //se crea un thread que manda mensajes
      if(0<pthread_create(&ts,NULL,tsend,(void*)&st)) err("pthread_create fallo");
      //este sigue recibiendo mensajes
      //mientras el cliente este activo
      while(st.act){
        switch(nbytes=recv(st.sock,buffer,BUFMAX,0)){
        case  0: st.act=0; break;
        case -1: err("recv fallo");
        default:
          buffer[nbytes]='\0';
          printf("\n%s\n%s",buffer,PROMPT); fflush(NULL);
          st.act=strncmp(buffer,MSGBYE,sizeof(MSGBYE));
        }
      }
      //termina el otro thread y cierra la conexion
      pthread_cancel(ts);
      pthread_join(ts,NULL);
    }
    close(st.sock);
    return 0;
  }
  printf("uso: %s <ip servidor> <puerto servidor>\n",argv[0]);
  return 1;
}
