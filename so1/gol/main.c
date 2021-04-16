#include<stdio.h>
#include"game.h"
#include"board.h"

int main(){
  game_t*g=loadGame("./g1.game");
  for(int i=0;i<g->board->c*g->board->r;i++)
    putchar(g->board->b[i]);
  board_destroy(g->board);
  free(g);
}
