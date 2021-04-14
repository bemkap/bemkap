#include<stdlib.h>
#include"filtro.h"

filtro_t*filtro(unsigned n){
  filtro_t*f=malloc(sizeof(filtro_t));
  f->n=n;
  f->nivel=malloc(n*sizeof(long));
  f->flags=malloc(n*sizeof(long));
  f->victi=malloc(n*sizeof(long));
  for(int i=0;i<n;i++){
    f->nivel[i]=0;
    f->flags[i]=0;
    f->victi[i]=0;
  }
  return f;
}
void filtro_destroy(filtro_t*f){
  free(f->nivel);
  free(f->flags);
  free(f->victi);
  free(f);
}
void filtro_lock(filtro_t*f,int id){
  for(nivel[id]=0;nivel[id]<f->n-1;nivel[id]++){
    f->victi[nivel[id]]=id;
    f->flags[nivel[id]]=1;
    while(f->flags[nivel[id]]==1&&f->victi[nivel[id]]==id);
    f->flags[nivel[id]]=0;
  }
}
void filtro_unlock(filtro_t*f,int id){
  
}
