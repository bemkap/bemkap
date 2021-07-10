-module(ledger).
-include("struct.hrl").
-export([get/0,append/1]).
-export([start/0,stop/0,ledgerinit/2,ledgerloop/1]).

start()->
    case node:start(#handler{onDeliver=fun(X)->ledger_server!X end,onNodedown=fun(X)->ledger_server!X end}) of
        {error,already_started}->{error,already_started};
        _->%node:abroadcast({get_init,node()}),
           register(ledger_server,spawn(?MODULE,ledgerinit,[[],nodes()]))
    end.

stop()->
    ledger_server!die,
    node:stop(),
    unregister(ledger_server).

get()->
    node:abroadcast({get,self(),node()}),
    receive {ok,L}->L end.

append(X)->
    node:abroadcast({append,X}).

ledgerinit(L,[])->ledgerloop(L);
ledgerinit(L,Responses)->
    receive        
        {get_init,From}->?DEBUG("get_init(~p)~n",[From]),
                         {ledger_server,From}!{ledger,[],node()},
                         ledgerinit(L,Responses);
        {ledger,LO,From}->?DEBUG("ledger(~p,~p)~n",[LO,From]),
                          ledgerinit(if length(L)>length(LO)->L;true->LO end,lists:delete(From,Responses));
        {nodedown,N}->?DEBUG("nodedown(~p)~n",[N]),
                      ledgerinit(L,lists:delete(N,Responses))
    end.

ledgerloop(L)->
    receive
        {get_init,From}->?DEBUG("get_init(~p)~n",[From]),
                         {ledger_server,From}!{ledger,L,node()},ledgerloop(L);
        {get,From,Node}->?DEBUG("get(~p,~p)~n",[From,Node]),
                         if Node==node()->From!{ok,L};true->nop end,
                         ledgerloop(L);
        {append,X}->?DEBUG("append(~p)~n",[X]),
                    ledgerloop([X|L]);
        {nodedown,N}->?DEBUG("nodedown(~p)~n",[N]),
                      ledgerloop(L);
        die->?DEBUG("die~n",[]),
             exit(normal)
    end.
