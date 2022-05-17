D=: ".&.>'b'fread'D'
T=: 1(<"1;(3&{.(,"1 0)3&}.)&.>D)}2 2 13 13$0
M=: 0 1(0 0 9;1 0 9)}1 0(0 0 11;0 0 12)}2 2 13 2$0

ST=: 0 0 3 3 0 0 0 NB. turno_canta turno_tira n1 n2 envido truco ultimo

A =: cutLF(0 : 0)
-
tira carta
canta envido
canta envido envido
canta real envido
canta falta envido
canta truco
canta re truco
canta vale 4
quiere el truco
no quiere el truco
quiere el envido
no quiere el envido
)

mov=: T({~?@:#)@:I.@:({~<)]
mod=: 2&{.+M&({~<)
nex=: (3 : 0) :: ]
 assert. +./0<2 3{y
 r=. (mod,mov)4}.y
 c=. (2 3{y)-(1={:r)({.y)}0 0
 (-.0{y),(-.^:(1={:r)1{y),c,r
)
com=: 3 : '''jugador '',(":y{~0 1{~1={:y),'' '',A{::~{:y'