#include<sys/sysinfo.h>
#include<string.h>
#include<stdio.h>
#include"game.h"
#include"board.h"

int main(int argc,char**argv){
  if(argc>1){
    game_t*g;
    if(g=load_game(argv[1])){
      size_t len=strlen(argv[1]);
      char out[len+1];
      strcpy(out,argv[1]);
      strcpy(out+len-5,".final");
      g->board=conway_gol(g->board,g->cyc,get_nprocs());
      write_board(g->board,out);
      board_destroy(g->board);
      free(g);
    }else printf("(main)error al abrir el archivo %s\n",argv[1]);
  }
}
