-module(test).
-export([test_init/0,test_run/1,test/0]).

test()->    
    test_init(),
    timer:sleep(3000),
    test_run(5).

test_init()->ledger:start('node1@archlinux').

test_run(0)->timer:sleep(5000),ledger:stop();
test_run(N)->
    ledger:append(N),
    timer:sleep(100*rand:uniform(10)),
    test_run(N-1).
