#include<stdio.h>
#include<stdlib.h>
#include<sys/socket.h>
#include<pthread.h>
#include"util.h"

int hash(const char*str,unsigned m){
  unsigned long h=5381;
  int c;
  while(c=*str++) h=(((h<<5)+h)+c)%m;
  return h;
}
void err(const char*msg){
  perror(msg);
  exit(EXIT_FAILURE);
}
void terr(const char*msg){
  perror(msg);
  pthread_exit(NULL);
}
