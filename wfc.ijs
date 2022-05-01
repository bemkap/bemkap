load'graphics/png'

IMG=: '~temp/img.png'
TILE=: 2 2
SIZE=: 10

SYM=: 1
tail=: }.`(1&|.)@.SYM
liat=: }:`]@.SYM

or =: 23 b.
and=: 17 b.

Pi=: ($P)$(i.~~.),P=: (,:~TILE) <;._3 readpng jpath IMG
UP=: 2&(+/@:^)&>~.&.>(~.@:,@:tail/:~(tail</.&,liat))Pi
DO=: 2&(+/@:^)&>~.&.>(~.@:,@:liat/:~(liat</.&,tail))Pi
LE=: 2&(+/@:^)&>~.&.>(~.@:,@:(tail"1)/:~(tail"1</.&,liat"1))Pi
RI=: 2&(+/@:^)&>~.&.>(~.@:,@:(liat"1)/:~(liat"1</.&,tail"1))Pi

M=: (2^?.l)(?.*:SIZE)}(*:SIZE)$<:2^l=. #~.,Pi
r=: (,~SIZE)(],.[#.[|"1(0 1,0 _1,_1 0,:1 0)+"1/~#:)i.*:SIZE
discard=: 3 : 0
 i=. ,({.,}.and(RI,LE,UP,:DO)or/@:#~"1 _(7#2)|.@:#:{.)"1 r{y
 (~./:~i and//.~ ]),r
)
collapse=: 2^?@:>.@:%:
  