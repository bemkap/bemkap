#include<sys/sysinfo.h>
#include<unistd.h>
#include<stdlib.h>
#include<stdio.h>
#include"game.h"
#include"board.h"

int main(int argc,char**argv){
  if(argc>2){
    game_t*g=load_game(argv[1]);
    char screen[1+(g->board->c+1)*g->board->r];
    g->board=conway_gol(g->board,g->cyc,get_nprocs());
    write_board(g->board,argv[2]);
    board_destroy(g->board);
    free(g);
  }
}
