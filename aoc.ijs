C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
M=: C i. >cutLF(0 : 0)
########################
#f.D.E.e.C.b.A.@.a.B.c.#
######################.#
#d.....................#
########################
)
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(M free@:{~ <)"1)L:0 co +"1&.> dco
)
expl=: ]~.@:,(<"1)@:>@:(,&.>/)@:{~ NB. explore
explwk=: 3 : 0 NB. explore with key
 y=. (*(-.@:e.)&(27+x))y
 (tr y)expl^:_
)