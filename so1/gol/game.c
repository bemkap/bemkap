#include<stdio.h>
#include<assert.h>
#include<unistd.h>
#include"game.h"
#include"barreras.h"

typedef struct{
  barrier_t*barr1,*barr2;
  unsigned cyc,from,to;
  board_t*board;
}args_t;

game_t*load_game(const char*filename){
  FILE*fd=fopen(filename,"r");
  game_t*g=malloc(sizeof(game_t));
  int i,n,x;
  size_t m;
  char*line=NULL,*p,c;
  g->board=malloc(sizeof(board_t));
  g->board->c=g->board->r=0;
  fscanf(fd,"%d %d %d\n",&g->cyc,&g->board->c,&g->board->r);
  board_init(g->board,g->board->c,g->board->r);
  for(int y=0;y<g->board->r;y++){
    getline(&line,&m,fd);
    n=i=x=0;
    while('\n'!=line[i]){
      while('0'<=line[i]&&'9'>=line[i]) n=n*10+line[i++]-'0';
      c=line[i++];
      for(;0<n;n--) board_set(g->board,x++,y,c);
    }
  }
  board_swap(g->board);
  free(line);
  fclose(fd);
  return g;
}
void write_board(board_t*board,const char*filename){
  FILE*fd=fopen(filename,"w");
  int n,x;
  fprintf(fd,"%d %d\n",board->c,board->r);
  for(int y=0;y<board->r;y++){
    n=1;
    for(int x=1;x<board->c;x++){
      if(board_get(board,x,y)==board_get(board,x-1,y)) n++;
      else{
        fprintf(fd,"%d%c",n,board_get(board,x-1,y));
        n=1;
      }
    }
    fprintf(fd,"%d%c\n",n,board_get(board,board->c-1,y));
  }
  fclose(fd);
}
void*compute(void*a){
  args_t*args=(args_t*)a;
  for(int c=0;c<args->cyc;c++){
    for(int i=args->from;i<args->to;i++){
      int x=i%args->board->c;
      int y=i/args->board->r;
      int nb=0;
      for(int ox=-1;ox<=1;ox++)
        for(int oy=-1;oy<=1;oy++)
          nb+='O'==board_get_round(args->board,x+ox,y+oy);
      if(board_get(args->board,x,y)=='O')
        board_set(args->board,x,y,nb==3||nb==4?'O':'X');
      else
        board_set(args->board,x,y,nb==3?'O':'X');
    }
    barrier_wait(args->barr1);
    barrier_wait(args->barr2);
  }
  pthread_exit(EXIT_SUCCESS);
}
void*manage(void*a){
  args_t*args=(args_t*)a;
  for(int c=0;c<args->cyc;c++){
    barrier_wait(args->barr1);
    board_swap(args->board);
    barrier_wait(args->barr2);
  }
  pthread_exit(EXIT_SUCCESS);
}
board_t*conway_gol(board_t*board,unsigned int cycles,const int nuproc){
  if(nuproc>board->c*board->r) nuproc=board->c*board->r;
  args_t args[nuproc+1];
  pthread_t tt[nuproc+1];
  barrier_t barr1,barr2;
  barrier_init(&barr1,nuproc+1);
  barrier_init(&barr2,nuproc+1);
  unsigned r=0.5+board->c*board->r/nuproc;
  for(int p=0;p<nuproc;p++){
    args[p].barr1=&barr1;
    args[p].barr2=&barr2;
    args[p].cyc=cycles;
    args[p].from=r*p;
    args[p].to=(p<nuproc-1)?r*(p+1):(board->c*board->r);
    args[p].board=board;
    assert(!pthread_create(&tt[p],NULL,compute,&args[p]));
  }
  args[nuproc].barr1=&barr1;
  args[nuproc].barr2=&barr2;
  args[nuproc].cyc=cycles;
  args[nuproc].board=board;
  assert(!pthread_create(&tt[nuproc],NULL,manage,&args[nuproc]));  
  for(int p=0;p<nuproc+1;p++)
    assert(!pthread_join(tt[p],NULL));
  return board;
}
