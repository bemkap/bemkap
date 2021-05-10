#include <stdlib.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <pthread.h>
#include "crear_socket_nombrado.h"

#define NTHREAD 10

typedef struct{
  int sock;
  struct sockaddr*cli;
  char*desc;
}arg;

void*fthread(void*a){
  static char rta[]="disculpe. no se pudo encontrar solucion al problema\n";
  arg*b=(arg*)a;
  printf("gracias por comunicarse. bucando soluciones para: %s",b->desc);
  sleep(5);
  if(0>sendto(b->sock,rta,sizeof(rta),0,b->cli,sizeof(*b->cli))){
    perror("sendto: le pifié");
    pthread_exit((void*)EXIT_FAILURE);
  }
  pthread_exit(EXIT_SUCCESS);
}  

int main(int argc,char*argv[]){
  int sock_srv,i=0;
  ssize_t nbytes;
  char buff[NTHREAD][101];
  struct sockaddr_un cliente[NTHREAD];
  pthread_t tt[NTHREAD]; arg a[NTHREAD];
  socklen_t size=sizeof(cliente[0]);
  
  if(argc>1){
    sock_srv=crear_socket_nombrado(argv[1]);
    printf("hola soy el solucionador de problemas de windows\n");
    printf("por favor enviar la descripcion del problema a %s\n",argv[1]);
    printf("como no soy tan eficiente puedo tomar hasta %d peticiones a la vez\n",NTHREAD);
    for(;;){
      if(0>(nbytes=recvfrom(sock_srv,buff[i],100,0,(struct sockaddr*)&cliente[i],&size))){
        perror("recvfrom: no pude");
        exit(EXIT_FAILURE);
      }
      buff[i][nbytes]='\0';
      a[i].sock=sock_srv;
      a[i].cli=(struct sockaddr*)&cliente[i];
      a[i].desc=buff[i];
      if(0!=pthread_create(&tt[i],NULL,fthread,(void*)&a[i])){
        perror("pthread_create: fallé");
        exit(EXIT_FAILURE);
      }
      i=(i+1)%NTHREAD;
    }
    rm_socket_nombrado(argv[1],sock_srv);
    return EXIT_SUCCESS;
  }
  printf("uso: %s <servidor>\n",argv[0]);
  return EXIT_FAILURE;
}
