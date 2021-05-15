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

void*tmain(void*a){
  char buffer[NAMMAX+10+MSGMAX],*cmd,*nick,*msg;
  tstate*st=(tstate*)a;
  int test=0; //booleano usado para probar si esta usado el nickname y bucle principal
  ssize_t nbytes;

  //se pide un nickname para entrar
  //queda en el bucle mientras el nick este usado, o haya colision en la tabla stable
  while(!test){
    send(st->sock,MSGNICK,sizeof(MSGNICK),0);
    if(0>(nbytes=recv(st->sock,buffer,NAMMAX,0))) terr("recv fallo");
    buffer[nbytes]='\0';
    pthread_mutex_lock(&st->glst->mut);
    if((test=(st->glst->stable[hash(buffer,CLIMAX)]<0))) st->glst->stable[hash(buffer,CLIMAX)]=st->sock;
    else send(st->sock,MSGOCUP,sizeof(MSGOCUP),0);
    pthread_mutex_unlock(&st->glst->mut);
  }
  //el usuario pudo entrar
  send(st->sock,MSGBIEN,sizeof(MSGBIEN),0);
  printf("bienvenido %s\n",buffer);
  //se reciben los mensajes del usuario
  while(test){
    if(0>(nbytes=recv(st->sock,buffer,10+NAMMAX+MSGMAX,0))) terr("recv fallo");
    cmd=strtok(buffer," ");
    printf("%s de %d\n",cmd,st->sock);
    //comando mensaje. se envia el mensaje si el usuario existe,
    //respondiendo al usuario que lo envio en caso de exito
    if(0==strncmp(cmd,"/msg",4)){
      nick=strtok(NULL," ");
      msg=strtok(NULL,"\n");
      if(st->glst->stable[hash(nick,CLIMAX)]>0){
        send(st->glst->stable[hash(nick,CLIMAX)],msg,MSGMAX,0);
        send(st->sock,MSGENVI,sizeof(MSGENVI),0);
      }
    //comando exit. se borra el socket de la tabla y sale con mensaje de despedida
    }else if(0==strncmp(cmd,"/exit",5)){
      for(int i=0;i<CLIMAX;i++)
        if(st->glst->stable[i]==st->sock){
          st->glst->stable[i]=-1;
          break;
        }
      send(st->sock,MSGCHAU,sizeof(MSGCHAU),0);
      test=0;
    //comando cambio de nombre. igual al principio, pero si ya existe no queda intentando de nuevo
    }else if(0==strncmp(cmd,"/nickname",9)){
      nick=strtok(NULL,"\n");
      if(st->glst->stable[hash(nick,CLIMAX)]<0){
        pthread_mutex_lock(&st->glst->mut);
        for(int i=0;i<CLIMAX;i++)
          if(st->glst->stable[i]==st->sock){
            st->glst->stable[i]=-1;
            st->act=0;
            break;
          }
        st->glst->stable[hash(nick,CLIMAX)]=st->sock;
        pthread_mutex_unlock(&st->glst->mut);
        send(st->sock,MSGCAMB,sizeof(MSGCAMB),0);
      }else send(st->sock,MSGOCUP,sizeof(MSGOCUP),0);
    }
  }
  //cierre de conexion
  close(st->sock);
  pthread_exit(0);
}
int main(int argc,char*argv[]){
  struct sockaddr_in aserv,acli;
  pthread_attr_t attr;
  int sserv,scli,i;
  socklen_t lcli;
  pthread_t tt;
  int tcli[CLIMAX];

  if(argc>1){
    state_init(&st,CLIMAX);
    if(0>(sserv=socket(AF_INET,SOCK_STREAM,0))) err("sock fallo");
    aserv.sin_family=AF_INET;
    aserv.sin_addr.s_addr=INADDR_ANY;
    aserv.sin_port=htons(atoi(argv[1]));
    if(bind(sserv,(struct sockaddr*)&aserv,sizeof(aserv))) err("bind fallo");
    if(0>listen(sserv,CLIMAX)) err("listen fallo");
    lcli=sizeof(acli);
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
    for(i=0;i<CLIMAX;i++) tstate_init(&tst[i],&st);
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
