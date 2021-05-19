#ifndef BARRERAS_HEADER
#define BARRERAS_HEADER
#include<pthread.h>

struct cond_barrier {
  unsigned count,total;
  pthread_mutex_t m;
  pthread_cond_t c;
};

typedef struct cond_barrier barrier_t;

/* Creación de una barrera de condición, tomando como argumento la cantidad de hilos que se van a esperar*/
int barrier_init(barrier_t *barr, unsigned int count);

/* Función *bloqueante* para esperar a los demás hilos */
int barrier_wait(barrier_t *barr);

/* Eliminación de la barrera */
int barrier_destroy(barrier_t *barr);

#endif
