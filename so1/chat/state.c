#include<stdlib.h>
#include<pthread.h>
#include"state.h"

void state_init(state*st,int N){
  st->stable=malloc(N*sizeof(int));
  for(int i=0;i<N;i++) st->stable[i]=-1;
  pthread_mutex_init(&st->mut,NULL);
}
void state_dest(state*st){
  free(st->stable);
}

void tstate_init(tstate*tst,state*glst){
  tst->act=0;
  tst->glst=glst;
}
