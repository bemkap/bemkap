#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>

#define MOLS 100
#define VISITANTES 1000
#define UP 1
#define DOWN 0

long int visitantes;
long int flags[MOLS];
long int vict[MOLS];

void*molinete(void*arg){
  long int id=(long int)arg;
  for(int i=0;i<VISITANTES;i++){
    {
      long int otro=(id+1)%MOLS;
      for(int j=0;j<MOLS;j++){
        vict[j]=id;
        flags[id]=UP;
        while(flags[otro]==UP&&vict[j]==id);
      }
    }
    visitantes++;
    {
      flags[id]=DOWN;
    }
  }
  pthread_exit(EXIT_SUCCESS);
}
int main(){
  pthread_t mols[MOLS];
  visitantes = 0;
  for(int i=0;i<MOLS;i++) flags[i]=DOWN;
  for(int i=0;i<MOLS;i++) assert(!pthread_create(&mols[i],NULL,molinete,(void*)i));
  for(int i=0;i<MOLS;i++) assert(!pthread_join(mols[i],NULL));
  printf("Visitantes que pasaron en el día %ld =?= %d\n",visitantes,MOLS*VISITANTES);
  return EXIT_SUCCESS;
}
