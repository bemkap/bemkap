-module(node).
-include("struct.hrl").
-export([start/1,start/0,stop/0,abroadcast/1,adeliver/2]).
-export([senderinit/1,senderloop/5,votebox/3]).

%%start con handler para mensajes
start(H) when is_record(H,handler)->
    case whereis(node_sender) of %%por las dudas que ya exista
        undefined->register(node_sender,spawn(?MODULE,senderinit,[H]));
        _->{error,already_started}
    end;
start(_)->{error,handler_required}.

%start con handler por defecto
start()->start(#handler{}).

%%die
stop()->
    node_sender!die,
    unregister(node_sender).

abroadcast(M)->node_sender!{broadcast,M}.

%%saco los mensajes mientras tenga deliverables a la cabeza del Queue
adeliver([{M,_,_,_,deliverable}|Queue],OnDeliver)->OnDeliver(M),adeliver(Queue,OnDeliver);
adeliver(Queue,_)->Queue.

%%función para actualizar mensajes que se pueden enviar
upd(Id,From,SMax,{M,Id,From,_,undeliverable})->{M,Id,From,SMax,deliverable};
upd(_,_,_,X)->X.

%%inicio. mando el aviso de que soy nuevo y arranco el loop principal
senderinit(H) when is_record(H,handler)->
    lists:foreach(fun(X)->{node_sender,X}!{im_new,node()},monitor_node(X,true)end,nodes()),
    senderloop(0,0,[],maps:new(),H).

%%loop principal
senderloop(S,Counter,Queue,Responses,H) when is_record(H,handler)->
    receive
        %%intento de broadcast, se envía a nodes() la notificación con identificador de mensaje {M,Counter,node()} único para cada mensaje
        {broadcast,M}->?DEBUG("broadcast(~p)~n",[M]),
                       timer:sleep(?SLEEP),
                       lists:foreach(fun(X)->{node_sender,X}!{sender_propose,M,Counter,node()}end,[node()|nodes()]),
                       senderloop(S,Counter+1,Queue,maps:put(Counter,spawn(?MODULE,votebox,[S,Counter,nodes()]),Responses),H);
        %%se recibe la primer notificación de que un nodo quiere hacer broadcast. se envía la propuesta S para el mensaje Id(con eso el que hizo
        %%broadcast ya identificará de que mensaje se trata), y quién propone el S(node()).
        %%también se agrega a mi Queue de mensajes para envíar con el átomo undeliverable, porque todavía no se acordó el número de secuencia
        {sender_propose,M,Id,From}->?DEBUG("sender_propose(~p,~p,~p)~n",[M,Id,From]),
                                    timer:sleep(?SLEEP),
                                    {node_sender,From}!{others_propose,Id,S,node()},
                                    senderloop(S+1,Counter,[{M,Id,From,S,undeliverable}|Queue],Responses,H);
        %%el que hizo el broadcast recibe la propuesta de otro nodo, lo elimina de su lista de espera para el mensaje Id, y va tomando el máximo de
        %%todos los números recibidos. si es el último le avisa a todos el número de secuencia acordado
        {others_propose,Id,SO,From}->?DEBUG("others_propose(~p,~p,~p)~n",[Id,SO,From]),
                                     timer:sleep(?SLEEP),
                                     case maps:get(Id,Responses,failed) of Pid->Pid!{check_vote,Id,SO,From} end,
                                     senderloop(S,Counter,Queue,Responses,H);
        %%se recibe el mensaje de acuerdo para mensaje Id de From con número de secuencia SMax. se ordena mi Queue(por S de menor a mayor, y en caso
        %%de empate primero los undeliverable) y se hace adeliver mientras tenga mensajes con el átomo deliverable en la cabeza del Queue
        {agreed,Id,From,SMax}->?DEBUG("agreed(~p,~p,~p)~n",[Id,From,SMax]),
                               timer:sleep(?SLEEP),
                               S1Queue=lists:reverse(lists:keysort(5,Queue)),%%sort primero undeliverable despues deliverable
                               %%sort por S de menor a mayor. como el keysort es estable quedan los undeliverable del sort anterior primeros
                               S2Queue=lists:keysort(4,lists:map(fun(X)->upd(Id,From,SMax,X)end,S1Queue)),
                               senderloop(max(S,SMax),Counter,adeliver(S2Queue,H#handler.onDeliver),Responses,H);
        %%un nodo de cae. se deja de monitorear y se verifica que no sea el único en mi lista de espera para algún mensaje. en caso que lo sea se hace
        %%lo mismo que su hubiera recibido una propuesta pero con SO=0
        {nodedown,N}->?DEBUG("nodedown(~p)~n",[N]),
                      timer:sleep(?SLEEP),
                      monitor_node(N,false),
                      disconnect_node(N),
                      maps:foreach(fun(Id,Pid)->Pid!{check_vote,Id,0,N}end,Responses),
                      (H#handler.onNodedown)({nodedown,N}),
                      senderloop(S,Counter,Queue,Responses,H);
        %%la votación ha terminado
        {voting_finished,Id,SMax}->?DEBUG("voting_finished(~p,~p)~n",[Id,SMax]),
                                   timer:sleep(?SLEEP),
                                   lists:foreach(fun(X)->{node_sender,X}!{agreed,Id,node(),SMax}end,[node()|nodes()]),
                                   senderloop(SMax,Counter,Queue,maps:remove(Id,Responses),H);
        %%mensaje de nuevo nodo en la red. empieza a monitorearse el nodo.
        {im_new,N}->?DEBUG("im_new(~p)~n",[N]),
                    timer:sleep(?SLEEP),
                    monitor_node(N,true),
                    senderloop(S,Counter,Queue,Responses,H);
        %%die. ok
        die->?DEBUG("die~n",[]),
             timer:sleep(?SLEEP),
             maps:foreach(fun(_,Pid)->Pid!die end,Responses),
             lists:foreach(fun(N)->{node_sender,N}!{nodedown,node()}end,nodes()),
             exit(normal)
    end.

%%hace un send sólo si Target existe, porque a veces node_sender falla y algún votevox sigue corriendo
sendifexists(Target,Msg)->
    case whereis(Target) of
        undefined->{error,non_existing};
        _->Target!Msg
    end.

%%loop que recibe votos
votebox(S,Id,Responses)->
    receive 
        die->?DEBUG("die~n",[]),
             ok;
        {check_vote,Id,SO,From}->?DEBUG("check_vote(~p,~p,~p)~n",[Id,SO,From]),
                                 case lists:delete(From,Responses) of
                                     []->sendifexists(node_sender,{voting_finished,Id,max(SO,S)});
                                     R->votebox(max(SO,S),Id,R)
                                 end
    end.
