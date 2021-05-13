#include<stdio.h>
#include"util.h"
int main(){
  char cmd[10],nick[32],msg[1024];
  scanf("%s",cmd);
  int h=hash(cmd,10);
  if(h==hash("/msg",10)){
  }else if(h==hash("/exit
  switch(hash(cmd,100)){
  case hash("/msg",100): break;
  case hash("/exit",100): break;
  case hash("/nickname",100): break;
  }
  return 0;
}
