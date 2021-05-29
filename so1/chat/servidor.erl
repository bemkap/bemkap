-module(servidor).
-export([dict/1,close/1,room/1,door/2,inside/3]).
-include("servidor.hrl").

%%actor que funciona de diccionario. cada elemento es {nickname,socket}
dict(M)->
    receive
        {add,Nick,Socket,Pid}->case maps:is_key(Nick,M) of
                                   true ->Pid!err,dict(M);
                                   false->Pid!ok ,dict(maps:put(Nick,Socket,M))
                               end;
        {get,Nick,Pid}->Pid!maps:get(Nick,M,err),dict(M);
        {rm,Nick}->dict(maps:remove(Nick,M));
        {update,Socket,Old,New,Pid}->case maps:is_key(New,M) of
                                         true ->Pid!err,dict(M);
                                         false->Pid!ok ,dict(maps:put(New,Socket,maps:remove(Old,M)))
                                     end;
        {getall,Pid}->Pid!{ok,maps:values(M)},dict(M)
    end.

%%cierra el servidor
close(Socket)->gen_tcp:close(Socket),ok.

%%inicio del servidor
room(Port)->
    %%abre el socket y empieza a escuchar
    {ok,Socket}=gen_tcp:listen(Port,[list,{active,false}]),
    %%inicia el proceso para recibir clientes
    spawn(?MODULE,door,[Socket,spawn(?MODULE,dict,[maps:new()])]),
    Socket.

door(Socket,Dict)->
    case gen_tcp:accept(Socket) of
        {ok,CSocket}->
            %%lo primero que envia el cliente es el nickname
            case gen_tcp:recv(CSocket,0) of
                {ok,Nick}->Dict!{add,string:trim(Nick),CSocket,self()},
                           receive
                               %%el nombre ya existe
                               err->gen_tcp:send(CSocket,?SRVERR),
                                    door(Socket,Dict);
                               %%entra a la sala, inicia el inside que administra cada cliente
                               ok ->gen_tcp:send(CSocket,?SRVOK),
                                    io:format("~p ha ingresado~n",[string:trim(Nick)]),
                                    spawn(?MODULE,inside,[CSocket,string:trim(Nick),Dict])
                           end
            end;
        {error,closed}->io:format("cliente no responde~n"),exit(normal);
        {error,Reason}->io:format("fallo accept: ~p~n",[Reason])
    end,
    %%espera nuevos clientes
    door(Socket,Dict).

inside(Socket,Nick,Dict)->
   case gen_tcp:recv(Socket,0) of
       {ok,Buffer}->
           case string:tokens(string:trim(Buffer)," ") of
               %%mensaje privado
               ["/msg",User|Msg]->Dict!{get,User,self()},
                                  receive 
                                      %%el usuario no existe
                                      err->gen_tcp:send(Socket,?SRVERR);
                                      %%envia el mensaje al otro usuario
                                      USocket->
                                          gen_tcp:send(USocket,Nick++":"++string:join(Msg," ")),
                                          gen_tcp:send(Socket,?SRVOK)
                                  end;
               %%cambio de nickname
               ["/nickname",NewNick]->Dict!{update,Socket,Nick,NewNick,self()},
                                      receive
                                          %%ya existe
                                          err->gen_tcp:send(Socket,?SRVERR);
                                          ok ->gen_tcp:send(Socket,?SRVOK)
                                      end;
               %%sale de la sala, borra el nombre del diccionario
               ["/exit"]->Dict!{rm,Nick},
                          gen_tcp:send(Socket,?SRVBYE),
                          exit(normal);
               %%mensaje general
               Msg->Dict!{getall,self()},
                    receive
                        {ok,All}->lists:foreach(fun(USocket)->gen_tcp:send(USocket,Nick++":"++string:join(Msg," "))end,All),
                                  gen_tcp:send(Socket,?SRVOK)
                    end
           end,
           inside(Socket,Nick,Dict);
       %%se cierra el cliente por alguna otra razon, se borra del diccionario y sale
       {error,closed}->Dict!{rm,Nick},
                       io:format("cliente no responde~n")
   end.
