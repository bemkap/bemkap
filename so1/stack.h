#ifndef HEADER_STACK
#define HEADER_STACK

struct stack_t;

struct stack_t*stack_init();
void stack_destroy(struct stack_t*);
void stack_push(struct stack_t*,void*);
void*stack_top(struct stack_t*);
void stack_pop(struct stack_t*);

#endif
