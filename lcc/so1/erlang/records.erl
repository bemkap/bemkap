-module(records).


%% Persona = {nombre, edad, apellido}.
%%
-record(persona, {nombre, edad = 1, apellido = "Perez"}).

-export([martin/0,setF/1,cumplefeliz/1, personapp/1]).
-export([play/0]).


martin() ->
    #persona{ nombre = "Martín"
            , edad = 31
            , apellido = "Ceresa"}.
    %% {persona, "Martín", 31 , "Ceresa"}.

setF(P) ->
    P#persona{edad = 40}.

cumplefeliz(#persona{edad = Edad} = P) ->
    P#persona{edad = Edad + 1}.

personapp(Persona) ->
    io:format("Nombre: ~p, Edad: ~p, Apellido: ~p ~n"
             ,[ Persona#persona.nombre
              , Persona#persona.edad
              , Persona#persona.apellido]).

play() ->
    personapp(martin()),
    OMartin = cumplefeliz(martin()),
    personapp(OMartin),
    ok.
