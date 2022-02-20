#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include"filtro.h"

#define MOLS 100
#define VISITANTES 100

long visitantes;
filtro_t*f;

void*molinete(void*arg){
  long id=(long)arg;
  filtro_lock(f,id);
  visitantes++;
  filtro_unlock(f,id);
  pthread_exit(EXIT_SUCCESS);
}
int main(){
  pthread_t mols[MOLS];
  f=filtro(MOLS);
  visitantes=0;
  for(long i=0;i<MOLS;i++) assert(!pthread_create(&mols[i],NULL,molinete,(void*)i));
  for(long i=0;i<MOLS;i++) assert(!pthread_join(mols[i],NULL));
  filtro_destroy(f);
  printf("%ld =?= %d\n",visitantes,MOLS*VISITANTES);
  return EXIT_SUCCESS;
}
