-module(test).
-export([test/0,run/1]).

test()->
    net_adm:ping('node1@archlinux'),
    timer:sleep(1000),
    ledger:start(),
    run(5).

run(0)->
    io:format("listo~n"),
    timer:sleep(1000),
    io:format("~p~n",[ledger:get()]),
    ledger:stop();
run(N)->
    io:format("append ~p~n",[N]),
    ledger:append(N),
    timer:sleep(100*rand:uniform(20)),
    run(N-1).

