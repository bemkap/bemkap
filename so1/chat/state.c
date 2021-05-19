#include<stdlib.h>
#include<pthread.h>
#include"state.h"
#include"util.h"

void sstate_init(sstate*sst,int N){
  //la posicion que le corresponde a cada cliente en la tabla se
  //determina aplicando un hash al nombre, despues cuando otro
  //le envie un mensaje se aplica el hash al nickname para saber
  //el socket. mientras la cantidad de usuarios se acerque a N
  //va a ser mas dificil encontrar un nombre que no colisione
  //con los que estan, aunque no haya nadie con el mismo nick
  //por eso se crea la tabla con el doble de valor del parametro
  //porque igual la variable N no se usa para limitar la cantidad
  //de clientes, sino solo para calcular el hash
  sst->stable=malloc(2*N*sizeof(int));
  sst->N=2*N;
  for(int i=0;i<sst->N;i++) sst->stable[i]=-1;
  pthread_mutex_init(&sst->mut,NULL);
}
void sstate_dest(sstate*st){
  free(st->stable);
}
int sstate_sget(sstate*st,const char*key){
  return st->stable[hash(key,st->N)];
}
void sstate_sset(sstate*st,const char*key,int val){
  st->stable[hash(key,st->N)]=val;
}
void tstate_init(tstate*tst,sstate*sst){
  tst->act=0;
  tst->sst=sst;
}
void cstate_init(cstate*cst){
  cst->act=1;
}
