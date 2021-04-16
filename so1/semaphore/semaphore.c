#include<stdlib.h>
#include<pthread.h>
#include"semaphore.h"

int sem_init(sem_t*sem,int init){
  return sem->c=init;
}
int sem_incr(sem_t*sem){
  pthread_mutex_lock(&sem->mut);
  sem->c++;
  pthread_mutex_unlock(&sem->mut);
  return sem->c;
}
int sem_decr(sem_t*sem){
  int flag=0;
  while(!flag){
    pthread_mutex_lock(&sem->mut);
    flag=sem->c>0;
    if(flag) sem->c--;
    pthread_mutex_unlock(&sem->mut);
  }
  return sem->c;
}
int sem_destroy(sem_t*sem){
  free(sem);
}
