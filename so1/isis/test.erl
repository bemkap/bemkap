-module(test).
-export([test_init/0,test_run/1,test/0]).

test()->    
    test_init(),
    timer:sleep(3000),
    test_run(5).

test_init()->
    net_adm:ping('node1@archlinux'),
    timer:sleep(500),
    ledger:start().

test_run(0)->
    io:format("listo~n"),
    timer:sleep(5000),
    L=ledger:get(),
    io:format("~p~n",[L]),
    ledger:stop();
test_run(N)->
    io:format("append ~p~n",[N]),
    ledger:append(N),
    timer:sleep(100*rand:uniform(10)),
    test_run(N-1).
