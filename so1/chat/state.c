#include<stdlib.h>
#include<pthread.h>
#include"state.h"

void sstate_init(sstate*sst,int N){
  sst->stable=malloc(N*sizeof(int));
  for(int i=0;i<N;i++) sst->stable[i]=-1;
  pthread_mutex_init(&sst->mut,NULL);
}
void sstate_dest(sstate*st){
  free(st->stable);
}
void tstate_init(tstate*tst,sstate*sst){
  tst->act=0;
  tst->sst=sst;
}
void cstate_init(cstate*cst){
  pthread_mutex_init(&cst->mut,NULL);
}
