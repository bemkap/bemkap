#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<assert.h>
#include"stack.h"

struct stack_t*st;

void*play(void*a){
  long i=(long)a;
  for(long j=0;j<10;j++) stack_push(st,(void*)(i*10+j));
  for(long j=0;j<10;j++){
    printf("%ld ",(long)stack_top(st));
    stack_pop(st);
  }
  pthread_exit(EXIT_SUCCESS);
}

int main(){
  st=stack_init();
  pthread_t tt[5];
  for(long i=0;i<5;i++) assert(!pthread_create(&tt[i],NULL,play,(void*)i));
  for(long i=0;i<5;i++) assert(!pthread_join(tt[i],NULL));
  stack_destroy(st);
}
