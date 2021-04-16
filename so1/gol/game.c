#include<stdio.h>
#include<unistd.h>
#include"game.h"

game_t*loadGame(const char*filename){
  FILE*fd=fopen(filename,"r");
  game_t*g=malloc(sizeof(game_t));
  int cyc,col,row,n,x;
  size_t sz;
  char*line=NULL,c;
  g->board=malloc(sizeof(board_t));  
  fscanf(fd,"%d %d %d\n",&cyc,&col,&row);
  board_init(g->board,col,row);
  for(int y=0;y<row;y++){
    getline(&line,&sz,fd);
    x=0;
    while(EOF!=sscanf(line,"%d%c",&n,&c))
      while(0<n--) board_set(g->board,x++,y,c);
  }
  fclose(fd);
  return g;
}

void writeBoard(board_t*board,const char*filename);

board_t*conwayGol(board_t*board,unsigned int cycles,const int nuproc);
