-module(node).
-export([start/0,start/1,stop/0,senderinit/0,senderloop/4,abroadcast/1,adeliver/1]).
%% -define(DEBUG(STR),io:format(STR)).
-define(DEBUG(STR),nop).

%%inicio del servicio(soy el primero)
start()->
    register(sender,spawn(?MODULE,senderinit,[])).

%%inicio del servcio(conozco un nodo de la red)
start(N)->%%N es un nodo cualquiera que pertenezca a la red
    case net_adm:ping(N) of
        pong->register(sender,spawn(?MODULE,senderinit,[]));
        pang->red_no_alcanzada
    end.

%%die
stop()->
    sender!die,
    unregister(sender).

abroadcast(M)->sender!{broadcast,M}.

%%imprimo mensajes mientras tenga deliverables a la cabeza del Queue
adeliver([{M,_,_,_,deliverable}|Queue])->io:format("~p~n",[M]),adeliver(Queue);
adeliver(Queue)->Queue.

%%función update para mensajes que se pueden enviar
upd(Id,From,SMax,{M,Id,From,_,undeliverable})->{M,Id,From,SMax,deliverable};
upd(_,_,_,X)->X.

%%función para comprobar si un nodo es el último en mi lista de espera
lst(_,_,_,[])->false;
lst(N,S,Id,[N])->lists:foreach(fun(X)->{sender,X}!{agreed,Id,node(),S}end,nodes()),false;
lst(N,_,_,X)->{true,lists:delete(N,X)}.

%%inicio. mando el aviso de que soy nuevo y arranco y loop principal
senderinit()->
    lists:foreach(fun(X)->{sender,X}!{im_new,node()},monitor_node(X,true)end,nodes()),
    senderloop(0,0,[],maps:new()).

%%loop principal
senderloop(S,Counter,Queue,Responses)->
    receive
        %%intento de broadcast, se envía a nodes() la notificación con identificador de mensaje {M,Counter,node()} único para cada mensaje
        {broadcast,M}->lists:foreach(fun(X)->{sender,X}!{sender_propose,M,Counter,node()}end,nodes()),
                       senderloop(S,Counter+1,Queue,maps:put(Counter,nodes(),Responses));
        %%se recibe la primer notificación de que un nodo quiere hacer broadcast. se envía la propuesta S para el mensaje Id(con eso el que hizo
        %%broadcast ya identificará de que mensaje se trata), y quién propone el S(node()).
        %%también se agrega a mi Queue de mensajes para envíar con el átomo undeliverable, porque todavía no se acordó el número de secuencia
        {sender_propose,M,Id,From}->{sender,From}!{others_propose,Id,S,node()},
                                    senderloop(S+1,Counter,[{M,Id,From,S,undeliverable}|Queue],Responses);
        %%el que hizo el broadcast recibe la propuesta de otro nodo, lo elimina de su lista de espera para el mensaje Id, y va tomando el máximo de
        %%todos los números recibidos. si es el último le avisa a todos el número de secuencia acordado
        {others_propose,Id,SO,From}->case lst(From,max(S,SO),Id,maps:get(Id,Responses,[])) of
                                         false->senderloop(max(S,SO),Counter,Queue,maps:remove(Id,Responses));
                                         {true,R}->senderloop(max(S,SO),Counter,Queue,maps:put(Id,R,Responses))
                                     end;
        %%se recibe el mensaje de acuerdo para mensaje Id de From con número de secuencia SMax. se ordena mi Queue(por S de menor a mayor, y en caso
        %%de empate primero los undeliverable) y se hace adeliver mientras tenga mensajes con el átomo deliverable en la cabeza del Queue
        {agreed,Id,From,SMax}->S1Queue=lists:reverse(lists:keysort(5,Queue)),%%sort primero undeliverable despues deliverable
                               %%sort por S de menor a mayor. como el keysort es estable quedan los undeliverable del sort anterior primeros
                               S2Queue=lists:keysort(4,lists:map(fun(X)->upd(Id,From,SMax,X)end,S1Queue)),
                               senderloop(max(S,SMax),Counter,adeliver(S2Queue),Responses);
        %%un nodo de cae. se deja de monitorear y se verifica que no sea el único en mi lista de espera para algún mensaje. en caso que lo sea se hace
        %%lo mismo que su hubiera recibido una propuesta pero sin SO
        {nodedown,N}->monitor_node(N,false),
                      senderloop(S,Counter,Queue,maps:filtermap(fun(Id,X)->lst(N,Id,S,X)end,Responses));
        %%mensaje de nuevo nodo en la red. empieza a monitorearse el nodo.
        {im_new,N}->monitor_node(N,true),senderloop(S,Counter,Queue,Responses);
        %%fin. ok
        die->ok
    end.
