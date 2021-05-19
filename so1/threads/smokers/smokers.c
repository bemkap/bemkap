#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

struct _argument {
  sem_t tabaco;
  sem_t papel;
  sem_t fosforos;
  sem_t otra_vez;
};

typedef struct _argument args_t;

void agente(void *_args){
  args_t *args = (args_t *) _args;
  for (;;) {
    int caso = random() % 3;
    sem_wait(&args->otra_vez);
    switch (caso) {
    case 0:
      sem_post(&args->tabaco);
      sem_post(&args->papel);
      break;
    case 1:
      sem_post(&args->fosforos);
      sem_post(&args->tabaco);
      break;
    case 2:
      sem_post(&args->papel);
      sem_post(&args->fosforos);
      break;
    }
  }
  return;
}

int fumar(int fumador){
  printf("Fumador %d: Puf! Puf! Puf!\n", fumador);
  sleep(1);
  return 0;
}

void *fumador1(void *_arg){
  args_t *args = (args_t *) _arg;
  printf("Fumador 1: Hola!\n");
  for (;;)
    sem_trywait(&args->tabaco)||(sem_trywait(&args->papel)&&!sem_post(&args->tabaco))||fumar(1)||sem_post(&args->otra_vez);
  pthread_exit(0);
}

void *fumador2(void *_arg){
  args_t *args = (args_t *) _arg;
  printf("Fumador 2: Hola!\n");
  for (;;)
    sem_trywait(&args->fosforos)||(sem_trywait(&args->tabaco)&&!sem_post(&args->fosforos))||fumar(2)||sem_post(&args->otra_vez);
  pthread_exit(0);
}

void *fumador3(void *_arg){
  args_t *args = (args_t *) _arg;
  printf("Fumador 3: Hola!\n");
  for (;;)
    sem_trywait(&args->papel)||(sem_trywait(&args->fosforos)&&!sem_post(&args->papel))||fumar(3)||sem_post(&args->otra_vez);
  pthread_exit(0);
}

int main(){
  pthread_t s1, s2, s3;
  args_t *args = malloc(sizeof(args_t));

  sem_init(&args->tabaco, 0, 0);
  sem_init(&args->papel, 0, 0);
  sem_init(&args->fosforos, 0, 0);
  sem_init(&args->otra_vez, 0, 1);

  pthread_create(&s1, NULL, fumador1, (void*)args);
  pthread_create(&s2, NULL, fumador2, (void*)args);
  pthread_create(&s3, NULL, fumador3, (void*)args);

  agente((void *)args);

  return 0;
}
