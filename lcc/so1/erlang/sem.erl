-module(sem).
-export([sem/2,sem_inc/1,sem_dec/1,darin/1,main/0]).

sem(N,L)->receive 
              {req,P} when length(L)<N->P!ok,sem(N,[P|L]);
              {out,P}->sem(N,lists:delete(P,L))
          end.
sem_dec(S)->S!{req,self()},receive _->ok end.
sem_inc(S)->S!{out,self()}.
darin(S)->sem_dec(S),
          io:format("holi~n"),
          timer:sleep(5000),
          sem_inc(S).
main()->S=spawn(sem,sem,[2,[]]),
        spawn(sem,darin,[S]),
        spawn(sem,darin,[S]),
        spawn(sem,darin,[S]),
        ok.
