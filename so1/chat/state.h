#ifndef STATE_H
#define STATE_H

#include<pthread.h>

typedef struct{
  int n,N,*stable,sock;
  pthread_mutex_t mut;
}state;

void state_init(state*,int);
void state_dest(state*);

#endif
