#include<stdlib.h>
#include<pthread.h>
#include"stack.h"

struct stack_t*stack_init(){
  struct stack_t*st=malloc(sizeof(struct stack_t));
  st->fst=NULL;
  return st;
}
void stack_destroy(struct stack_t*st){
  while(st->fst!=NULL){
    struct elem_t*p=st->fst;
    st->fst=st->fst->next;
    free(p);
  }
  free(st);
}
void stack_push(struct stack_t*st,void*e){
  pthread_mutex_lock(&(st->lock));
  struct elem_t*new=malloc(sizeof(struct elem_t));
  new->e=e;
  new->next=st->fst;
  st->fst=new;
  pthread_mutex_unlock(&(st->lock));
}
void*stack_top(struct stack_t*st){
  return st->fst->e;
}
void stack_pop(struct stack_t*st){
  pthread_mutex_lock(&(st->lock));
  if(st->fst!=NULL){
    struct elem_t*p=st->fst->next;
    free(st->fst);
    st->fst=p;
  }
  pthread_mutex_unlock(&(st->lock));
}
