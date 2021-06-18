-module(ledger).
-export([get/0,append/1]).
-export([start/1,stop/0,ledgerloop/1,ledgerinit/2]).

start(N)->
    %%arranco un nodo con la función que reenvía el mensaje a un proceso local.
    %%X va a ir llegando a medida que se hagan los node:adeliver, o sea, que
    %%llegarán en el mismo orden para todos los nodos, asumiendo que node funciona bien.
    %%el send de erlang garantiza que cuando se los envíe al handler lleguen en
    %%el orden en que fueron enviados
    node:start(N,fun(X)->handler!X end,fun(X)->handler!X end),
    node:abroadcast({get,node()}),
    register(handler,spawn(?MODULE,ledgerinit,[[],nodes()])).

stop()->
    handler!die,
    node:stop(),
    unregister(handler).

get()->handler!{get,node()}.

append(X)->node:abroadcast({append,X}).

ledgerinit(L,[])->ledgerloop(L);
ledgerinit(L,Responses)->
    receive 
        {ledger,LO,From}->ledgerinit(case length(L)>length(LO) of true->L; false->LO end,lists:delete(From,Responses));
        {nodedown,N}->ledgerinit(L,lists:delete(N,Responses))
    end.

ledgerloop(L)->
    receive
        {get,From}->{handler,From}!{ledger,L,node()},ledgerloop(L);
        {append,X}->ledgerloop([X|L]);
        die->io:format("~p~n",[L])
    end.
