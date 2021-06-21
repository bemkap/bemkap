-module(ledger).
-include("struct.hrl").
-export([get/0,append/1]).
-export([start/0,stop/0,ledgerloop/1,ledgerinit/2]).

start()->
    %%arranco un nodo con la función que reenvía el mensaje a un proceso local.
    %%X va a ir llegando a medida que se hagan los node:adeliver, o sea, que
    %%llegarán en el mismo orden para todos los nodos, asumiendo que node funciona bien.
    %%el send de erlang garantiza que cuando se los envíe al ledger_sender lleguen en
    %%el orden en que fueron enviados
    case node:start(#handler{onDeliver=fun(X)->ledger_sender!X end,onNodedown=fun(X)->ledger_sender!X end}) of
        {error,already_started}->{error,already_started};
        _->lists:foreach(fun(X)->{ledger_sender,X}!{get_init,node()}end,nodes()),
           register(ledger_sender,spawn(?MODULE,ledgerinit,[[],nodes()]))
    end.

%%die
stop()->
    ledger_sender!die,
    node:stop(),
    unregister(ledger_sender).

%%se pide el estado actual del ledger
get()->
    node:abroadcast({get,self(),node()}),
    receive {ok,L}->L end.

append(X)->node:abroadcast({append,X}).

%%función que usan los nodos recién llegados y recibe el estado actual del ledger
ledgerinit(L,[])->ledgerloop(L);
ledgerinit(L,Responses)->
    receive 
        %%respuesta de un nodo de la red, se compara con la que ya tengo y me quedo con la mayor
        %%como asumo que el atomic broadcast funciona bien la mayor contiene a la menor
        {ledger,LO,From}->?DEBUG("ledger(~p,~p)~n",[LO,From]),
                          ledgerinit(case length(L)>length(LO) of true->L; false->LO end,lists:delete(From,Responses));
        %%por las dudas que se genere un deadlock(explicado mejor en el informe)
        {get_init,From}->?DEBUG("get_init(~p)~n",[From]),
                         {ledger_sender,From}!{ledger,[],node()},
                         ledgerinit(L,lists:delete(From,Responses));
        %%si un nodo se cae durante esta etapa se descarta
        {nodedown,N}->?DEBUG("nodedown(~p)~n",[N]),
                      ledgerinit(L,lists:delete(N,Responses))
    end.

%%loop principal
ledgerloop(L)->
    receive
        %%petición de un recién llegado, se devuelve mi estado actual
        {get_init,From}->?DEBUG("get_init(~p)~n",[From]),
                         {ledger_sender,From}!{ledger,L,node()},ledgerloop(L);
        %%para la función get. si se hizo un get mientras estaba en ledgerinit el mensaje habrá
        %%quedado en el buzón y será respondido ahora
        {get,From,Node}->?DEBUG("get(~p,~p)~n",[From,Node]),
                         if Node==node()->From!{ok,L};
                            true->nop
                         end,
                         ledgerloop(L);
        %%función append
        {append,X}->?DEBUG("append(~p)~n",[X]),
                    ledgerloop([X|L]);
        %%die. ok
        die->?DEBUG("die~n",[]),
             exit(normal)
    end.
