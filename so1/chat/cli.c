#include<sys/types.h>
#include<sys/socket.h>
#include<netdb.h>
#include<pthread.h>
#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include"util.h"
#include"const.h"

void*tsend(void*a){
  char buffer[MSGMAX];
  int sock=*(int*)a;
  
  for(;;){
    printf("> "); fflush(NULL);
    scanf("%s",buffer);
    send(sock,buffer,strlen(buffer),0);
  }  
}
void*trecv(void*a){
  ssize_t nbytes;
  char buffer[MSGMAX];
  int sock=*(int*)a;

  for(;;){
    nbytes=recv(sock,buffer,MSGMAX,0);
    buffer[nbytes]='\0';
    printf("%s\n",buffer);
  }
}
int main(int argc,char*argv[]){
  int sock;
  struct addrinfo*serv;
  pthread_t ts,tr;
  char msg[MSGMAX];
  ssize_t nbytes;
  
  if(argc>2){
    if(0>(sock=socket(AF_INET,SOCK_STREAM,0))) err("socket fallo");
    if(getaddrinfo(argv[1],argv[2],NULL,&serv)) err("getaddrinfo fallo");
    if(0>connect(sock,(struct sockaddr*)serv->ai_addr,serv->ai_addrlen)) err("connect fallo");
    //primero recibe el mensaje de login y envia el nickname
    nbytes=recv(sock,msg,sizeof(msg),0);
    printf("%s",msg); fflush(NULL);
    scanf("%s",msg);
    send(sock,msg,strlen(msg),0);
    if(0<pthread_create(&ts,NULL,tsend,(void*)&sock)) err("pthread_create fallo");
    if(0<pthread_create(&tr,NULL,trecv,(void*)&sock)) err("pthread_create fallo");
    pthread_join(ts,NULL);
    pthread_join(tr,NULL);
    return 0;
  }
  printf("uso: %s <ip servidor> <puerto servidor>\n",argv[0]);
  return 1;
}
