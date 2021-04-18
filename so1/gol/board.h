#ifndef BOARD
#define BOARD

#include <stdlib.h>

/*
board_t: estructura para guardar el tablero
 c  : cantidad de columnas
 r  : cantidad de filas
 b  : los dos buffers que se usaran para guardar las celdas
 act: buffer activo

las funciones get y show actuan sobre el buffer activo.set sobre el buffer secundario.
la idea es que despues de una generacion se intercambien los buffers,
asi se puede actualizar el tablero como si fuera simultaneo
*/

typedef struct{
  size_t c,r,act;
  char*b[2];
}board_t;

//creacion del tablero
int  board_init(board_t*board,size_t col,size_t row);
//creacion del tablero con un elemento inicial
int  board_init_def(board_t*board,size_t col,size_t row,char def);
//leer el tablero en una posición (col,row)
char board_get(board_t*board,unsigned int col,unsigned int row); 
//leer el tablero en una posición asumiendo que el tablero es 'redondo'
char board_get_round(board_t*board,int col,int row); 
//asignarle un valor 'val' a la posición (col,row) del tablero
void board_set(board_t*board,unsigned int col,unsigned int row,char val); 
//leer de una lista de caracteres e interpretarla como un tablero
int  board_load(board_t*board,char*str); 
//la función 'board_show' asume que hay espacio suficiente en 'res' para alojar el tablero
void board_show(board_t*board,char*res);
//swap buffers
void board_swap(board_t*board);
//destroy board
void board_destroy(board_t*board); 

#endif
