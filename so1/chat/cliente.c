#include<sys/types.h>
#include<sys/socket.h>
#include<netdb.h>
#include<pthread.h>
#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include"util.h"
#include"const.h"
#include"state.h"

//thread que envia mensajes
void*tsend(void*a){
  char buffer[BUFMAX];
  cstate*st=(cstate*)a;
  //mientras el usuario este activo
  while(st->act){
    //lee por entrada estandar y lo envia al servidor
    printf("> "); fflush(NULL);
    read(STDIN_FILENO,buffer,BUFMAX);
    pthread_mutex_lock(&st->mut);
    if(0>send(st->sock,buffer,strlen(buffer),0)) terr("send fallo");
    pthread_mutex_unlock(&st->mut);
  }
  pthread_exit(0);
}
//thread que recibe mensajes
void*trecv(void*a){
  ssize_t nbytes;
  char buffer[BUFMAX];
  cstate*st=(cstate*)a;
  //mientras el usuario este activo
  while(st->act){
    if(0>(nbytes=recv(st->sock,buffer,BUFMAX,0))) terr("recv fallo");    
    buffer[nbytes]='\0';
    pthread_mutex_lock(&st->mut);
    printf("\n%s\n> ",buffer); fflush(NULL);
    pthread_mutex_unlock(&st->mut);
    //la condicion para salir es que el server envie "bye"
    if(0==strncmp(buffer,"bye",3)) st->act=0;
  }
  pthread_exit(0);
}
int main(int argc,char*argv[]){
  struct addrinfo*serv;
  pthread_t ts,tr;
  char buffer[BUFMAX],nick[NAMMAX];
  ssize_t nbytes;
  //estado de cliente. tiene el socket del servidor y un mutex
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
      printf("nickname: ");
      scanf("%s",nick);
      if(0>send(st.sock,nick,strlen(nick),0)) err("send fallo");
      if(0>(nbytes=recv(st.sock,buffer,BUFMAX,0))) err("recv fallo");
      buffer[nbytes]='\0';
      //si el servidor devuelve "ok" sale
      if(0==strncmp("ok",buffer,2)) break;
      else printf("%s\n",buffer);
    }
    //se crean dos threads, uno que envia mensajes y otro que recibe
    if(0<pthread_create(&ts,NULL,tsend,(void*)&st)) err("pthread_create fallo");
    if(0<pthread_create(&tr,NULL,trecv,(void*)&st)) err("pthread_create fallo");
    pthread_join(ts,NULL);
    pthread_join(tr,NULL);
    return 0;
  }
  printf("uso: %s <ip servidor> <puerto servidor>\n",argv[0]);
  return 1;
}
