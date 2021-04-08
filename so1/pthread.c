#include<stdio.h>
#include<pthread.h>
#include<stdlib.h>

#define N 1000
#define M 100

void*fn(void*a){
  *((int*)a)=0;
  for(int i=0;i<M;i++){
    float x=drand48()-0.5,y=drand48()-0.5;
    *((int*)a)+=0.25>x*x+y*y;
  }
  pthread_exit(EXIT_SUCCESS);
}
int main(){
  pthread_t tt[N];
  int a[N],s=0;
  srand48(time(NULL));
  for(int i=0;i<N;i++) pthread_create(&tt[i],NULL,fn,(void*)&a[i]);
  for(int i=0;i<N;i++){pthread_join(tt[i],NULL);s+=a[i];}
  printf("%f\n",4.0*s/(float)(M*N));
  return 0;
}
