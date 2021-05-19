#include<stdio.h>
#include<unistd.h>
#include<assert.h>
#include<stdlib.h>

#define BUFFER 1024

int main(){
  int fd[2],p;
  char buffer[BUFFER]="hola que tal";
  ssize_t rd;
  char buffP[BUFFER];

  assert(!pipe(fd));
  switch(fork()){
  case 0:
    /* close(fd[1]); */
    /* rd=read(fd[0],buffer,BUFFER); */
    /* buffer[rd]='\0'; */
    /* printf("Llegó: >%s<\n",buffer); */
    /* close(fd[0]); */
    write(fd[0],"soy 1",5);
    rd=read(fd[1],buffer,BUFFER);
    buffer[rd]='\0';
    printf("1: %s\n",buffer);
    exit(EXIT_SUCCESS);
  default:
    /* close(fd[0]); */
    /* read(STDIN_FILENO,buffP,BUFFER); */
    /* write(fd[1],buffP,BUFFER); */
    /* close(fd[1]); */
    write(fd[1],"soy 2",5);
    rd=read(fd[0],buffer,BUFFER);
    buffer[rd]='\0';
    printf("2: %s\n",buffer);
    exit(EXIT_SUCCESS);
  }
  exit(EXIT_SUCCESS);
}
