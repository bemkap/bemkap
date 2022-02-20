#ifndef STATE_H
#define STATE_H

#include<pthread.h>

//estructuras de estados para los threads cliente y servidor
//estado del servidor 
typedef struct{
  int*stable,N; //tabla de todos los clientes y tamaño total
  pthread_mutex_t mut;
}sstate;
//estado del thread
typedef struct{
  int sock,act,id; //socket del cliente, actividad e id
  sstate*sst; //puntero al estado global
}tstate;
//estado del cliente
typedef struct{
  int sock,act; //socket del servidor y actividad
  /* pthread_mutex_t mut; */
}cstate;

void sstate_init(sstate*,int);
void sstate_dest(sstate*);
int  sstate_sget(sstate*,const char*);
void sstate_sset(sstate*,const char*,int);
void tstate_init(tstate*,sstate*);
void cstate_init(cstate*);

#endif
