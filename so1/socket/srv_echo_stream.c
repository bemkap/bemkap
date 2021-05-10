#include<sys/socket.h>
#include<sys/un.h>
#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>
#include<string.h>
#include<pthread.h>

#define BLOG 10
#define NTHREAD 10

typedef struct{
  int sock;
  struct sockaddr_un*cli;
}arg;

void*fthread(void*a){
  arg*b=(arg*)a;
  char buff[101],rta[]="disculpe. no se ha encontrado ninguna solucion\n";
  ssize_t nbytes;
  nbytes=recv(b->sock,buff,100,0);
  buff[nbytes]='\0';
  printf("buscando solucion a: %s",buff);
  sleep(5);
  if(0>send(b->sock,rta,sizeof(rta),0)){
    perror("send: es la primera vez que me pasa");
    exit(EXIT_FAILURE);
  }
  close(b->sock);
}

int main(int argc,char*argv[]){
  int sock_srv,sock_cli[BLOG],i=0;
  struct sockaddr_un srv_nombre,cli_nombre[BLOG];
  socklen_t size;
  pthread_t tt[BLOG]; arg a[BLOG];

  if(argc>1){
    if(0>(sock_srv=socket(AF_UNIX,SOCK_STREAM,0))){
      perror("socket: lo intenté");
      exit(EXIT_FAILURE);
    }
    printf("bienvenido al nuevo y mejorado solucionador de problemas de windows(version 2.0)\n");
    printf("por favor envieme la descripcion de su problema a %s\n",argv[1]);
    srv_nombre.sun_family=AF_UNIX;
    strncpy(srv_nombre.sun_path,argv[1],sizeof(srv_nombre.sun_path));
    size=sizeof(struct sockaddr_un);
    if(0>bind(sock_srv,(struct sockaddr*)&srv_nombre,size)){
      perror("bind: te pido mildis");
      exit(EXIT_FAILURE);
    }
    if(0>listen(sock_srv,BLOG)){
      perror("listen: ay");
      exit(EXIT_FAILURE);
    }
    for(;;){
      if(0>(sock_cli[i]=accept(sock_srv,(struct sockaddr*)&cli_nombre[i],&size))){
        perror("accept: estee..");
        exit(EXIT_FAILURE);
      }
      a[i].sock=sock_cli[i];
      a[i].cli=&cli_nombre[i];
      if(0>pthread_create(&tt[i],NULL,fthread,(void*)&a[i])){
        perror("pthread_create: fallé");
        exit(EXIT_FAILURE);
      }
      i=(i+1)%BLOG;
    }    
    close(sock_srv);
    remove(argv[1]);
  }
  printf("uso: %s <servidor>\n",argv[0]);
  exit(EXIT_FAILURE);
}
