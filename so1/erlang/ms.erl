-module(ms).
-export([start/1,to_service/1,pacino/0]).

start(N)->spawn(ms,to_service,[lists:map(fun(_)->spawn(ms,pacino,[])end,lists:duplicate(N,0))]).
pacino()->receive
              die->exit(die);
              {Msg,P}->io:format("mensaje recibido:~p~n",[Msg]),P!ok,pacino()
          end.
to_service(L)->receive
                   {Msg,N}->lists:nth(N,L)!{Msg,self()},
                            receive
                                ok->to_service(L)
                            after 
                                0->to_service(lists:sublist(L,N-1)++[spawn(ms,pacino,[])]++lists:nthtail(N,L))
                            end
               end.
