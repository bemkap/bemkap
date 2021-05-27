-module(alloc).
-export([alloc/2,liberar/2,allocar/3,deniro/0,test/0]).

%%en caso de no haber recursos se fija si
%%algun proceso esta muerto y toma el recurso
allocar([],Enuso,Pid)->
    case lists:dropwhile(fun({_,P})->is_process_alive(P)end,Enuso) of
        []->Pid!noHay,{[],Enuso};
        [{_,P}|_]->{[],lists:map(fun({R,P_})->if P==P_->{R,Pid};true->{R,P_}end end,Enuso)}
    end;
allocar([R1|Recursos],Enuso,Pid)->
    Pid!{hay,R1},
    {Recursos,[{R1,Pid}|Enuso]}.
%%libera sin mirar
liberar({P,R},Recursos)->
    lists:delete({R,P},Recursos).
alloc(Libres,Enuso)->
    receive
        {tomar,Pid}->
            {NLibres,NEnuso}=allocar(Libres,Enuso,Pid),
            alloc(NLibres,NEnuso);
        {liberar,Pid,Recurso}->
            NEnuso=liberar({Pid,Recurso},Enuso),
            alloc([Recurso|Libres],NEnuso);
        estado->io:format("~p~p~n",[Libres,Enuso]),
                alloc(Libres,Enuso)
    end.
deniro()->
    receive
        die->exit(adiosmundocruel)
    end.
%%test:3 procesos usan 2 recursos
test()->
    A=spawn(alloc,alloc,[[a,b],[]]),
    D0=spawn(alloc,deniro,[]),
    D1=spawn(alloc,deniro,[]),
    D2=spawn(alloc,deniro,[]),
    A!{tomar,D0},
    A!{tomar,D1},
    A!status,
    D0!die,
    A!{tomar,D2},
    A!status.
