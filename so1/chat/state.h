#ifndef STATE_H
#define STATE_H

#include<pthread.h>

typedef struct{
  int*stable,N;
  pthread_mutex_t mut;
}sstate;

typedef struct{
  int sock,act,id;
  sstate*sst;
}tstate;

typedef struct{
  int sock;
  pthread_mutex_t mut;
}cstate;

void sstate_init(sstate*,int);
void sstate_dest(sstate*);
int  sstate_sget(sstate*,const char*);
void sstate_sset(sstate*,const char*,int);
void tstate_init(tstate*,sstate*);
void cstate_init(cstate*);

#endif
