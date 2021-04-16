#ifndef BOARD
#define BOARD

#include <stdlib.h>

struct _board{
  size_t c,r;
  char*b;
};
typedef struct _board board_t;

int  board_init(board_t*board,size_t col,size_t row); //creacion del tablero
int  board_init_def(board_t*board,size_t col,size_t row,char def); //creacion del tablero con un elemento inicial
char board_get(board_t*board,unsigned int col,unsigned int row); //leer el tablero en una posición (col,row)
char board_get_round(board_t*board,int col,int row); //leer el tablero en una posición asumiendo que el tablero es 'redondo'
int  board_set(board_t*board,unsigned int col,unsigned int row,char val); //asignarle un valor 'val' a la posición (col,row) del tablero
int  board_load(board_t*board,char*str); //leer de una lista de caracteres e interpretarla como un tablero
void board_show(board_t*board,char*res); //la función 'board_show' asume que hay espacio suficiente en 'res' para alojar el tablero
void board_destroy(board_t*board); //destroy board

#endif
