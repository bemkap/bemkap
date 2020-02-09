C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
door=: 1=(_1 0+C i. 'AZ')&I.
kpos=: ($@:]#:((=,)i.1:))"0 _ NB. key position
I=: <27 kpos M=: C i. >cutLF(0 : 0)
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################
)
N=: +/,key M
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(y free@:{~ <)"1)L:0 co +"1&.> dco
)
expl=: ]~.@:,(<"1)@:>@:(,&.>/)@:{~ NB. explore
open=: [*(-.@:e.(,27&+))

TMAPS=: tr"2 MP=: M&open"0 >:i.26 NB. transition maps
TR1=: tr M NB. transitions without open doors
TR0=: ~.@:,&.>/TMAPS NB. transitions with every door open

step=: ([:>[:,&.>/([:<expl1/)"1)
npath=: 4 : '<:#TR0 expl^:(1-y e. ])^:a: x'
aux=: 4 : '(TR0&expl)&.>^:(1-y e. >)^:a: <x'
path=: [:,aux([-.-.)&,&>|.@:aux~
KTKM=: (<:@:#,_27+(#~door))@:(path&</@:kpos{])&M L:0 {;~>:i.N NB. key to key map



expl1=: 4 : 0 NB. explore with key
 mp=. <./M,MP{~<:>x
 tm=. ~.@:,&.>/TR1,TMAPS{~<:>x
 kp=. key ce=. mp{~ex=. tm expl^:_ y
 (kp#ex),.~x,&.>kp#ce
)

solve=: 3 : 0
 min=. _
 while. 0<#y do.
  y=. (step/@:{.,}.)^:(N>0#@:{::{.)^:_ y
  t=. (2 ([:+/ npath/\) I,[: <"1 kpos&M)S:0 {."1 y
  min=. min<.{.t
  y=. (({.>}.)t)#}.y
 end.min
)