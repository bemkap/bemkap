#include<stdlib.h>
#include<string.h>
#include"board.h"

int board_init(board_t*board,size_t col,size_t row){
  if(NULL==(board->b[0]=malloc(col*row))) return 0;
  if(NULL==(board->b[1]=malloc(col*row))){
    free(board->b[0]);
    return 0;
  }
  board->act=0;
  board->c=col;
  board->r=row;
  return col*row;
}
int board_init_def(board_t*board,size_t col,size_t row,char def){
  if(0<board_init(board,col,row)){
    for(int i=0;i<col*row;i++) board->b[0][i]=def;
    return col*row;
  }
  return 0;
}
char board_get(board_t*board,unsigned col,unsigned row){
  if(col<board->c&&row<board->r) return board->b[board->act][row*board->c+col];
  else return '\0';
}
char board_get_round(board_t*board,int col,int row){
  while(col<0) col+=board->c;
  while(row<0) row+=board->r;
  return board_get(board,col%board->c,row%board->r);
}
void board_set(board_t*board,unsigned col,unsigned row,char val){
  while(col<0) col+=board->c;
  while(row<0) row+=board->r;
  board->b[1-board->act][(row%board->r)*board->c+(col%board->c)]=val;
}
int board_load(board_t*board,char*str){
  if(NULL!=board&&NULL!=board->b){
    memcpy(board->b,str,board->c*board->r);
    return 0;
  }
  return -1;
}
void board_show(board_t*board,char*res){
  if(NULL!=board&&NULL!=board->b[board->act])
    for(int y=0;y<board->r;y++){
      for(int x=0;x<board->c;x++)
        *(res++)='O'==board_get(board,x,y)?'@':'.';
      *(res++)='\n';
    }
  *res='\0';
}
void board_swap(board_t*board){
  board->act=1-board->act;
}
void board_destroy(board_t*board){
  free(board->b[0]);
  free(board->b[1]);
  free(board);
}
