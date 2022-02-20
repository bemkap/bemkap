#include<unistd.h>

int main(){
  write(STDOUT_FILENO,"123 456 6789",12);
  return 0;
}
