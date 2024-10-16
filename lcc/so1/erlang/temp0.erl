-module(temp0).
-export([convertir/1,perimetro/1,cronometro/3,crtick/3,start/2,darin/1]).

f2c(F)->(F-32)*5/9.
c2f(C)->C*9/5+32.
convertir({c,C})->c2f(C);
convertir({f,F})->f2c(F).
perimetro({square,S})->S*4;
perimetro({circle,R})->2*math:pi()*R;
perimetro({triangle,A,B,C})->A+B+C.
crtick(_,Desde,_) when Desde=<0->ok;
crtick(F,Desde,Periodo)->F(),timer:sleep(Periodo),crtick(F,Desde-Periodo,Periodo).
cronometro(F,Desde,Periodo)->spawn(temp,crtick,[F,Desde,Periodo]).
darin(Msg)->receive
                ok->ok;
                {Pid,0}->Pid!ok,ok;
                {Pid,M}->io:format("~p~n",[Msg]),
                         Pid!{self(),M-1},
                         darin(Msg)
            end.
start(Msg,M)->
    spawn(temp,darin,[Msg])!{self(),M},
    darin(Msg).
