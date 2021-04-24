-module(math1).
-export([start/0,loop/0]).

start()->
    spawn(math1,loop,[]).

loop()->
    receive
        {From,Message}->
            From!Message,
            loop()
    end.
