#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>

int main(int argc,char*argv[]){
  char buffer[5];
  /* dup2(STDIN_FILENO,STDOUT_FILENO); */
  int fd_v[2]={STDOUT_FILENO,STDIN_FILENO};
  pipe(fd_v);
  switch(fork()){
  case 0:
    execv(argv[1],NULL);
    exit(EXIT_SUCCESS);
  default:
    sleep(1);
    execv(argv[2],NULL);
    exit(EXIT_SUCCESS);
  }
}
