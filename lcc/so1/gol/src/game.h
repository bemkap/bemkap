#ifndef GAME_TYPES
#define GAME_TYPES

#include"board.h"

typedef struct{
  board_t*board;
  int cyc;
}game_t;

//cargamos el juego desde un archivo
game_t* load_game(const char*filename); 
//guardamos el tablero 'board' en el archivo 'filename'
void    write_board(board_t*board,const char*filename); 
//simulamos el juego de la vida de conway con tablero 'board' la cantidad de ciclos indicados en 'cycles' en 'nuprocs' unidades de procesamiento
board_t*conway_gol(board_t*board,unsigned int cycles,const int nuproc); 

#endif
