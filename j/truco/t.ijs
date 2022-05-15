D=: ".&.>'b'fread'D'
T=: 1(<"1;(3&{.(,"1 0)3&}.)&.>D)}2 2 13 13$0
M=: 0 1(0 0 9;1 0 9)}1 0(0 0 11;0 0 12)}2 2 13 2$0

ST=: 0 0 0 NB. turno envido truco ultimo

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
nex=: (mod,mov) :: ]

NB. play=: 3 : 0
NB.  'jj jc a b u'=. y
NB.  if. 0=#o=. I.D{~(+14*(3&-))~/(jc{a,b),u do. y return. end.
NB.  if. 3>o=. ({~?@#)o do. (-.jj),(-.jj),(a-jj=0),(b-jj=1),o
NB.  elseif. 10>o do. jj,(-.jc),a,b,o
NB.  elseif. 1 do. jj,jj,a,b,o end.
NB. )
NB. comment=: 3 : 0
NB.  'jj jc a b u'=. y
NB.  (":-.jc),' ',A{::~u
NB. )