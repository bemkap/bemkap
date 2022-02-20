#include<stdio.h>
#include<unistd.h>
#include<sys/wait.h>
int main(){
  char*words[30],line[200],*c;
  pid_t p;
  int wstatus,i,amp;
  while(1){
    printf("$ ");
    for(i=0;i<30;i++) words[i]=NULL;
    fgets(line,sizeof(line),stdin);
    if('\n'!=*line){
      i=0;
      words[i]=line;
      for(c=line  ;'\n'!=*c;c++) if(' '==*c) *c='\0';
      for(c=line+1;'\n'!=*c;c++) if(('\0'==*(c-1))&&('\0'!=*c)) words[++i]=c;
      *c='\0';
      amp=(('&'==words[i][0])&&('\0'==words[i][1]));
      if(amp) words[i-1]=NULL;
      if(0>(p=fork())){
        perror("fork fallo");
        _exit(1);
      }else if(p==0){
        execv(words[0],words);
        _exit(1);
      }else if(!amp){
        while(p!=wait(&wstatus));
        printf("exit status: %d\n",WEXITSTATUS(wstatus));
      }
    }
  }
  return 0;
}
