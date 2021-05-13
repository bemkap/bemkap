#include"util.h"

int hash(const char*str,unsigned m){
  unsigned long h=5381;
  int c;
  while(c=*str++) h=(((h<<5)+h)+c)%m;
  return h;
}
