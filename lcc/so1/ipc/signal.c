#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>
#include<signal.h>

void handler(int a){
  static int i=0;
  if(i<2){
    puts("ouch");
    i++;
  }else{
    puts("ya basta freezer");
    exit(0);
  }
}
int main(){
  signal(SIGINT,handler);
  for(;;){
    puts("haciendo cositas");
    sleep(1);
  }
  return 0;
}
