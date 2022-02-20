#ifndef FILTRO_HEADER
#define FILTRO_HEADER

typedef struct{
  unsigned n;
  long*nivel;
  long*flags;
  long*victi;
}filtro_t;

filtro_t*filtro(unsigned int n);
void filtro_lock(filtro_t*filtro,int id);
void filtro_unlock(filtro_t*filtro,int id);
void filtro_destroy(filtro_t*filtro);

#endif
