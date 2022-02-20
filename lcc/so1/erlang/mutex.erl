-module(mutex).
-export([francella/1,main/0,mutex/0,mutex_lock/1,mutex_unlock/1]).

mutex()->receive
             {req,P}->P!ok,
                      receive
                          {out,Q} when P==Q->mutex()
                      end
         end.
mutex_lock(M)->M!{req,self()},receive _->ok end.
mutex_unlock(M)->M!{out,self()}.
francella(M)->mutex_lock(M),
              io:format("~p~n",[self()]),
              timer:sleep(1000),
              mutex_unlock(M).
main()->M=spawn(mutex,mutex,[]),
        spawn(mutex,francella,[M]),
        spawn(mutex,francella,[M]),
        timer:sleep(2000),
        mutex_lock(M),
        mutex_unlock(M),
        ok.
