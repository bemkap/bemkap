#include<stdlib.h>
#include<pthread.h>
#include"barreras.h"

int barrier_init(barrier_t*barr,unsigned count){
  pthread_mutex_init(&barr->m,NULL);
  pthread_cond_init(&barr->c,NULL);
  barr->count=barr->total=count;
  return 0;
}
int barrier_wait(barrier_t*barr){
  pthread_mutex_lock(&barr->m);
  if(barr->count>1){
    barr->count--;
    pthread_cond_wait(&barr->c,&barr->m);
  }else{
    barr->count=barr->total;
    pthread_cond_broadcast(&barr->c);
  }
  pthread_mutex_unlock(&barr->m);
  return 0;
}
void barrier_destroy(barrier_t*barr){
  free(barr);
}
