#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<unistd.h>
#include<assert.h>
#include"barreras.h"

barrier_t barr;
void*func(void*a){ //ninguno puede escribir mientras no esten todos
  long n=(long)a;
  for(int i=0;i<3;i++){
    barrier_wait(&barr);
    printf("%d:%d\n",i,n);
  }
  pthread_exit(EXIT_SUCCESS);
}
int main(){
  pthread_t tt[5];
  barrier_init(&barr,5);
  for(long i=0;i<5;i++) assert(!pthread_create(&tt[i],NULL,func,(void*)i));
  for(long i=0;i<5;i++) assert(!pthread_join(tt[i],NULL));
  return EXIT_SUCCESS;
}
