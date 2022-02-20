#ifndef HEADER_STACK
#define HEADER_STACK

struct elem_t {
  void*e;
  struct elem_t*next;
};
struct stack_t {
  struct elem_t*fst;
  pthread_mutex_t lock;
};
struct stack_t*stack_init();
void stack_destroy(struct stack_t*);
void stack_push(struct stack_t*,void*);
void*stack_top(struct stack_t*);
void stack_pop(struct stack_t*);

#endif
