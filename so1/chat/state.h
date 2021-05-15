#ifndef STATE_H
#define STATE_H

#include<pthread.h>

typedef struct{
  int*stable;
  pthread_mutex_t mut;
}state;

typedef struct{
  int sock,act;
  state*glst;
}tstate;

void state_init(state*,int);
void state_dest(state*);

void tstate_init(tstate*,state*);

#endif
