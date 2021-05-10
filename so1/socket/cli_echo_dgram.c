#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include "crear_socket_nombrado.h"

int main(int argc,char*argv[]){
  int sock_cli;
  ssize_t nbytes;
  char buff[1025];
  struct sockaddr_un srv;
  socklen_t size=sizeof(srv);

  if(argc>2){
    sock_cli=crear_socket_nombrado(argv[2]);
    srv.sun_family=AF_UNIX;
    strncpy(srv.sun_path,argv[1],sizeof(srv.sun_path));
    printf("descripcion: "); fflush(NULL);
    read(STDIN_FILENO,buff,sizeof(buff));
    nbytes=sendto(sock_cli,buff,strlen(buff)+1,0,(struct sockaddr*)&srv,size);
    if(nbytes<0){
      perror("Falló el sendto");
      exit(EXIT_FAILURE);
    }
    printf("mensaje enviado. esperando respuesta...\n");

    nbytes=recvfrom(sock_cli,buff,1024,0,(struct sockaddr*)&srv,&size);
    if(nbytes<0){
      perror("Falló el recvfrom");
      exit(EXIT_FAILURE);
    }
    buff[nbytes]='\0';
    printf("windows: %s",buff);
    rm_socket_nombrado(argv[2],sock_cli);

    return EXIT_SUCCESS;
  }
  printf("uso: %s <servidor> <cliente>\n",argv[0]);
  return EXIT_FAILURE;
}
