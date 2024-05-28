input=: cutLF(0 : 0)
NNCB
CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
)

input=: 'b'fread'input14'

init=: {.input
input=: ' -> '&splitstring&>}.input

from=: {."1 input
to=: (0 2 1{,)&.>/"1 input
step=: ((,}.)&.>/@:(2(to{~from i.<)\]))&>
solution1=: (>./-<./) #/.~ > step^:10 init

matrix=: 1(;(,.~&.>i.@#)(from i. 2<\])&.>to)}0$~2##from
letters=: ~.;from
mp=: +/ .*
mult=: 1((,.~i.@#)letters i. 1&{&>to)}0$~from,&#letters
pairs0=: (0#~#from)(#/.~@:])`(~.@:])`[}2(from i. <)\>init
letters0=: (0#~#letters)(#/.~@:])`(letters i.~.@:])`[}>init
next=: 3 : 0
 'p l'=. y
 l=. l+p mp mult
 p=. p mp matrix
 p;l
)
solution2=: (>./-<./)1{::next^:40 pairs0;letters0