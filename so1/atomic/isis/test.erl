-module(test).
-export([test_init/0,test_run/1,test/0]).

test()->
    test_init(),
    test_run(0).

test_init()->node:start('node1@archlinux').

test_run(N)->
    node:abroadcast({node(),N}),
    timer:sleep(1000*rand:uniform(5)),
    test_run(N+1).
