#include<stdio.h>
#include<string.h>
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
  FILE*fd;
  game_t*g;
  size_t sz;
  char*line=NULL,*str;
  if(g=malloc(sizeof(game_t))){
    if(fd=fopen(filename,"r")){
      if(g->board=malloc(sizeof(board_t))){
        g->board->c=g->board->r=0;
        fseek(fd,0L,SEEK_END);
        sz=ftell(fd);
        fseek(fd,0L,SEEK_SET);
        if(NULL!=(str=malloc(sz))){
          fread(str,1,sz,fd);
          line=strtok(str,"\n");
          sscanf(line,"%d %d %d",&g->cyc,&g->board->c,&g->board->r);
          board_init(g->board,g->board->c,g->board->r);
          board_load(g->board,NULL);
          free(str);
          fclose(fd);
          return g;
        }
        board_destroy(g->board);
      }
      fclose(fd);
    }
    free(g);
  }
  return NULL;
}
void write_board(board_t*board,const char*filename){
  FILE*fd;
  int n;
  if(fd=fopen(filename,"w")){
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
  }else printf("(write_board)error al abrir al archivo %s\n",filename);
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
  args_t args[nuproc+1];
  pthread_t tt[nuproc+1];
  barrier_t barr1,barr2;
  if(nuproc<=board->c*board->r){
    barrier_init(&barr1,nuproc+1);
    barrier_init(&barr2,nuproc+1);
    unsigned r=0.5+board->c*board->r/nuproc;
    for(int p=0;p<nuproc+1;p++){
      args[p].barr1=&barr1;
      args[p].barr2=&barr2;
      args[p].cyc=cycles;
      args[p].from=r*p;
      args[p].to=(p<nuproc-1)?r*(p+1):(board->c*board->r);
      args[p].board=board;
      if(p<nuproc) assert(!pthread_create(&tt[p],NULL,compute,&args[p]));
      else assert(!pthread_create(&tt[nuproc],NULL,manage,&args[nuproc]));
    }  
    for(int p=0;p<nuproc+1;p++)
      assert(!pthread_join(tt[p],NULL));
  }else printf("no se pudo ejecutar, nuproc debe ser menor a %d\n",board->c*board->r);
  return board;
}
