-module(conjunto).
-export([start/0,stop/0,add/1,get/0,loop/1]).

start()->
    register(servset,spawn(?MODULE,loop,[sets:new()])),
    ok.

stop()->
    servset!fin,
    unregister(servset),
    ok.

add(E)->
    servset!{add,E,self()},
    receive 
        ok->ok;
        {error,Reason}->io:format("~p~n",[Reason]),error
    end.

get()->
    servset!{get,self()},
    receive
        {ok,S}->S;
        {error,Reason}->io:format("~p~n",[Reason]),error
    end.

loop(S)->
    receive
        {add,E,Pid}->Pid!ok,loop(sets:add_element(E,S));
        {get,Pid}->Pid!{ok,S},loop(S);
        fin->ok;
        _->loop(S)
    end.
