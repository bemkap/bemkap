#ifndef SEM_HEADER
#define SEM_HEADER

#include<pthread.h>

typedef struct{
  pthread_mutex_t mut;
  int c;
}sem_t;

int sem_init(sem_t*sem,int init);
int sem_incr(sem_t*sem);
int sem_decr(sem_t*sem);
int sem_destroy(sem_t*sem);

#endif
