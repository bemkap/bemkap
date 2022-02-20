-module(node).
-include("struct.hrl").
-export([start/1,start/0,stop/0,abroadcast/1,adeliver/2]).
-export([serverinit/1,serverloop/5,votebox/3]).

start(H) when is_record(H,handler)->
    case whereis(node_server) of
        undefined->register(node_server,spawn(?MODULE,serverinit,[H]));
        _->{error,already_started}
    end;
start(_)->{error,handler_required}.

start()->start(#handler{}).

stop()->
    node_server!die,
    unregister(node_server).

abroadcast(M)->node_server!{broadcast,M}.

adeliver([{M,_,_,_,deliverable}|Queue],OnDeliver)->OnDeliver(M),adeliver(Queue,OnDeliver);
adeliver(Queue,_)->Queue.

upd(Id,From,SMax,{M,Id,From,_,undeliverable})->{M,Id,From,SMax,deliverable};
upd(_,_,_,X)->X.

serverinit(H) when is_record(H,handler)->
    lists:foreach(fun(X)->{node_server,X}!{im_new,node()},monitor_node(X,true)end,nodes()),
    serverloop(0,0,[],maps:new(),H).

serverloop(S,Counter,Queue,Responses,H) when is_record(H,handler)->
    receive
        {broadcast,M}->?DEBUG("broadcast(~p)~n",[M]),
                       lists:foreach(fun(X)->{node_server,X}!{server_propose,M,Counter,node()}end,[node()|nodes()]),
                       serverloop(S,Counter+1,Queue,maps:put(Counter,spawn(?MODULE,votebox,[{0,0},Counter,[node()|nodes()]]),Responses),H);
        {server_propose,M,Id,From}->?DEBUG("server_propose(~p,~p,~p)~n",[M,Id,From]),
                                    {node_server,From}!{others_propose,Id,{S,node()}},
                                    serverloop(S+1,Counter,[{M,Id,From,S,undeliverable}|Queue],Responses,H);
        {others_propose,Id,{SO,From}}->?DEBUG("others_propose(~p,~p,~p)~n",[Id,SO,From]),
                                       case maps:get(Id,Responses,failed) of Pid->Pid!{check_vote,Id,{SO,From}} end,
                                       serverloop(S,Counter,Queue,Responses,H);
        {agreed,Id,From,SMax}->?DEBUG("agreed(~p,~p,~p)~n",[Id,From,SMax]),
                               S1Queue=lists:reverse(lists:keysort(5,Queue)),
                               S2Queue=lists:keysort(4,lists:map(fun(X)->upd(Id,From,SMax,X)end,S1Queue)),
                               serverloop(max(S,SMax),Counter,adeliver(S2Queue,H#handler.onDeliver),Responses,H);
        {nodedown,N}->?DEBUG("nodedown(~p)~n",[N]),
                      monitor_node(N,false),
                      disconnect_node(N),
                      maps:foreach(fun(Id,Pid)->Pid!{check_vote,Id,{0,N}}end,Responses),
                      (H#handler.onNodedown)({nodedown,N}),
                      serverloop(S,Counter,Queue,Responses,H);
        {voting_finished,Id,{SMax,_}}->?DEBUG("voting_finished(~p,~p)~n",[Id,SMax]),
                                       lists:foreach(fun(X)->{node_server,X}!{agreed,Id,node(),SMax}end,[node()|nodes()]),
                                       serverloop(SMax,Counter,Queue,maps:remove(Id,Responses),H);
        {im_new,N}->?DEBUG("im_new(~p)~n",[N]),
                    monitor_node(N,true),
                    serverloop(S,Counter,Queue,Responses,H);
        die->?DEBUG("die~n",[]),
             maps:foreach(fun(_,Pid)->Pid!die end,Responses),
             lists:foreach(fun(N)->{node_server,N}!{nodedown,node()}end,nodes()),
             exit(normal)
    end.

sendifexists(Target,Msg)->
    case whereis(Target) of
        undefined->{error,non_existing};
        _->Target!Msg
    end.

votebox(S,Id,Responses)->
    receive 
        die->?DEBUG("die~n",[]),
             ok;
        {check_vote,Id,{SO,From}}->?DEBUG("check_vote(~p,~p,~p)~n",[Id,SO,From]),
                                   case lists:delete(From,Responses) of
                                       []->sendifexists(node_server,{voting_finished,Id,max({SO,From},S)});
                                       R->votebox(max({SO,From},S),Id,R)
                                   end
    end.
