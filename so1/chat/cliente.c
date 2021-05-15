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

void*tsend(void*a){
  ssize_t nbytes;
  char buffer[BUFMAX];
  cstate*st=(cstate*)a;
  for(;;){
    printf("> "); fflush(NULL);
    read(STDIN_FILENO,buffer,MSGMAX);
    pthread_mutex_lock(&st->mut);
    if(0>send(st->sock,buffer,strlen(buffer),0)) terr("send fallo");
    if(0>(nbytes=recv(st->sock,buffer,BUFMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    printf("%s\n",buffer);
    pthread_mutex_unlock(&st->mut);
  }
}
void*trecv(void*a){
  ssize_t nbytes;
  char buffer[BUFMAX];
  cstate*st=(cstate*)a;
  for(;;){
    if(0>(nbytes=recv(st->sock,buffer,MSGMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    pthread_mutex_lock(&st->mut);
    printf("\n%s\n> ",buffer); fflush(NULL);
    pthread_mutex_unlock(&st->mut);
  }
}
int main(int argc,char*argv[]){
  struct addrinfo*serv;
  pthread_t ts,tr;
  char buffer[BUFMAX],nick[NAMMAX];
  ssize_t nbytes;
  cstate st;
  if(argc>2){
    pthread_mutex_init(&st.mut,NULL);
    if(0>(st.sock=socket(AF_INET,SOCK_STREAM,0))) err("socket fallo");
    if(getaddrinfo(argv[1],argv[2],NULL,&serv)) err("getaddrinfo fallo");
    if(0>connect(st.sock,(struct sockaddr*)serv->ai_addr,serv->ai_addrlen)) err("connect fallo");
    for(;;){
      printf("nickname: ");
      scanf("%s",nick);
      if(0>send(st.sock,nick,strlen(nick),0)) err("send fallo");
      if(0>(nbytes=recv(st.sock,buffer,BUFMAX,0))) err("recv fallo");
      buffer[nbytes]='\0';
      if(0==strncmp("ok",buffer,2)) break;
      else printf("%s\n",buffer);
    }
    if(0<pthread_create(&ts,NULL,tsend,(void*)&st)) err("pthread_create fallo");
    if(0<pthread_create(&tr,NULL,trecv,(void*)&st)) err("pthread_create fallo");
    pthread_join(ts,NULL);
    pthread_join(tr,NULL);
    return 0;
  }
  printf("uso: %s <ip servidor> <puerto servidor>\n",argv[0]);
  return 1;
}
