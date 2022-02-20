#include<unistd.h>
#include<stdio.h>

int main(){
  char buffer[15];
  read(STDIN_FILENO,buffer,sizeof(buffer));
  puts(buffer);
  return 0;
}
