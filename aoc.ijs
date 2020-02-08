C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
M=: C i. >cutLF(0 : 0)
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
)
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(y free@:{~ <)"1)L:0 co +"1&.> dco
)
expl=: ]~.@:,(<"1)@:>@:(,&.>/)@:{~ NB. explore
open=: [*(-.@:e.(,27&+))
expl1=: 4 : 0 NB. explore with key
 mp=. M open >x
 kp=. key ce=. mp{~ex=. (tr mp)expl^:_ y
 (kp#ex),.~x,&.>kp#ce
)
step=: ([:>[:,&.>/([:<expl1/)"1)
kpos=: ($@:]#:((=,)i.1:))"0 _ NB. key position
npath=: 4 : '<:#(tr M open >:i.26) expl^:(1-y e. ])^:a: x'
NB. sol=: <./+/"1]2 npath/\"1 I,.;/@:(kpos&M)"1 >{."1 step^:8 a:,I=. (<27 kpos M)