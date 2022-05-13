D =: ".'m'fread'D'
ST=: 0 0 3 3 0 NB. jugador cartas1 cartas2 ultimo

A =: cutLF(0 : 0)
tira carta 1
tira carta 2
tira carta 3
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

play=: 3 : 0
 'jj jc a b u'=. y
 if. 0=#o=. I.D{~(+14*(3&-))~/(jc{a,b),u do. y return. end.
 if. 3>o=. ({~?@#)o do. (-.jj),(-.jj),(a-jj=0),(b-jj=1),o
 elseif. 10>o do. jj,(-.jc),a,b,o
 elseif. 1 do. jj,jj,a,b,o end.
)