#include <sys/socket.h>
#include <sys/un.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main(int argc,char*argv[]){
  int sock_cli;
  struct sockaddr_un srv_nombre;
  socklen_t size;
  ssize_t nbytes;
  char buff[101];

  if(argc>1){
    if(0>(sock_cli=socket(AF_UNIX,SOCK_STREAM,0))){
      perror("socket: perdon");
      exit(EXIT_FAILURE);
    }
    srv_nombre.sun_family=AF_UNIX;
    strncpy(srv_nombre.sun_path,argv[1],sizeof(srv_nombre.sun_path));
    size=sizeof(struct sockaddr_un);
    if(0>connect(sock_cli,(struct sockaddr*)&srv_nombre,size)){
      perror("connect: chino no entiende");
      exit(EXIT_FAILURE);
    }
    printf("descripcion: "); fflush(NULL);
    read(STDIN_FILENO,buff,sizeof(buff));
    if(0>(nbytes=send(sock_cli,buff,strlen(buff)+1,0))){
      perror("send: send: send: send: ...");
      exit(EXIT_FAILURE);
    }
    printf("mensaje enviado. esperando respuesta...\n");
    if(0>(nbytes=recv(sock_cli,buff,101,0))){
      perror("recv: no me jodas, estoy durmiendo");
      exit(EXIT_FAILURE);
    }
    buff[nbytes]='\0';
    printf("windows: %s\n",buff);
    close(sock_cli);
    exit(EXIT_SUCCESS);
  }
  printf("uso: %s <servidor>\n");
  exit(EXIT_FAILURE);
}
