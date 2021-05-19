#include<stdlib.h>
#include<stdio.h>
#include<assert.h>
#include<unistd.h>
#include"semaphore.h"

sem_t sem;

void*func(void*a){
  long b=(long)a;
  printf("%ld esperando..\n",b);
  long i=sem_decr(&sem);
  printf("%ld entro. quedan %i lugares\n",b,i);
  sleep(3);
  sem_incr(&sem);
  printf("%ld salio.\n",b);
  pthread_exit(EXIT_SUCCESS);
}
int main(){
  sem_init(&sem,10);
  pthread_t tt[50];
  for(long i=0;i<50;i++) assert(!pthread_create(&tt[i],NULL,func,(void*)i));
  for(long i=0;i<50;i++) assert(!pthread_join(tt[i],NULL));
  return EXIT_SUCCESS;
}
