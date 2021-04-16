#include<stdlib.h>
#include<string.h>
#include"board.h"

int board_init(board_t*board,size_t col,size_t row){
  board->b=malloc(col*row);
  board->c=col;
  board->r=row;
  return (NULL==board->b)?0:col*row;
}
int board_init_def(board_t*board,size_t col,size_t row,char def){
  if(0<board_init(board,col,row)){
    for(int i=0;i<col*row;i++) board->b[i]=def;
    return col*row;
  }
  return 0;
}
char board_get(board_t*board,unsigned int col,unsigned int row){
  return (col<board->c&&row<board->r)?board->b[row*board->c+col]:-1;
}
char board_get_round(board_t*board,int col,int row){
  return board->b[(row%board->r)*board->c+(col%board->c)];
}
int board_set(board_t*board,unsigned int col,unsigned int row,char val){
  if(col<board->c&&row<board->r){
    board->b[row*board->c+col]=val;
    return 0;
  }
  return -1;
}
int board_load(board_t*board,char*str){
  if(NULL!=board&&NULL!=board->b){
    memcpy(board->b,str,board->c*board->r);
    return 0;
  }
  return -1;
}
void board_show(board_t*board,char*res){
  if(NULL!=board&&NULL!=board->b)
    memcpy(res,board->b,board->c*board->r);
}
void board_destroy(board_t*board){
  free(board->b);
  free(board);
}
