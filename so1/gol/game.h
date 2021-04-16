#ifndef GAME_TYPES
#define GAME_TYPES

#include"board.h"

enum state {ALIVE,DEAD}; //representamos las células vivas como 'O' y las muertas como 'X'

struct _game{
  board_t*board;
};
typedef struct _game game_t;

game_t* loadGame(const char*filename); //cargamos el juego desde un archivo
void    writeBoard(board_t*board,const char*filename); //guardamos el tablero 'board' en el archivo 'filename'
board_t*congwayGoL(board_t*board,unsigned int cycles,const int nuproc); //simulamos el juego de la vida de conway con tablero 'board' la cantidad de ciclos indicados en 'cycles' en 'nuprocs' unidades de procesamiento

#endif
