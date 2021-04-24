#ifndef BARRERAS_HEADER
#define BARRERAS_HEADER
#include<pthread.h>

typedef struct{
  unsigned count,total;
  pthread_mutex_t m;
  pthread_cond_t c;
}barrier_t;

//creación de una barrera de condición, tomando como argumento la cantidad de hilos que se van a esperar
int barrier_init(barrier_t*barr,unsigned count);
//función *bloqueante* para esperar a los demás hilos
int barrier_wait(barrier_t*barr);
//eliminación de la barrera
void barrier_destroy(barrier_t*barr);

#endif
