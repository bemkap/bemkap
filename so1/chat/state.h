#ifndef STATE_H
#define STATE_H

#include<pthread.h>

typedef struct{
  int*stable;
  pthread_mutex_t mut;
}sstate;

typedef struct{
  int sock,act;
  sstate*sst;
}tstate;

typedef struct{
  int sock;
  pthread_mutex_t mut;
}cstate;

void sstate_init(sstate*,int);
void sstate_dest(sstate*);
void tstate_init(tstate*,sstate*);
void cstate_init(cstate*);

#endif
