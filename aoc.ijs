C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
door=: 1=(_1 0+C i. 'AZ')&I.
opos=: ($@:]#:((=,)i.1:))"0 _
I=: <27 opos M=: C i. >cutLF(0 : 0)
########################
#@..............ac.GI.b#
###d#e#f################
###A#B#C################
###g#h#i################
########################
)
N=: +/,key M
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(y free@:{~ <)"1)L:0 co +"1&.> dco
)
expl=: ]~.@:,(<"1)@:>@:(,&.>/)@:{~
open=: [*(-.@:e.(,27&+))
TR0=: ~.@:,&.>/tr"2 M&open"0 >:i.26
aux=: 4 : '(TR0&expl)&.>^:(1-y e. >)^:a:<x'
path=: [:,aux([-.-.)&,&>|.@:aux~
KTKM=: (<:@:#,_27+(#~door))@:(path&</@:opos{])&M L:0 {;~27,>:i.N
expl1=: 3 : 'y ,"_ 0 y-.~I.(y*./@:e.~}.)S:0 KTKM{~{:y'
step=: 3 : '<"1 > ,&.>/ expl1&.>"0 y'
solve=: 3 : 0
 min=. _
 PLEN=. {.&>KTKM
 while. #y do.
  y=. (step@:{.,}.)^:(N><:@:#@:>@:{.)^:_ y
  t=. ([:+/2(PLEN{~<)\])&> y
  y=. y#~t<min=. min<.{.t
 end.min
)