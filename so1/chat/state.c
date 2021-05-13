#include<stdlib.h>
#include<pthread.h>
#include"state.h"

void state_init(state*st,int N){
  st->N=N;
  st->n=0;
  st->stable=malloc(N*sizeof(int));
  pthread_mutex_init(&st->mut,NULL);
}
void state_dest(state*st){
  free(st->stable);
}
