dijkstra=: 4 : 0
 'G C'=. y
 D=. 0(x})_#~#G
 V=. 1#~#G
 while. +./V do.
  a=. (#~{&V)x{::G
  D=. D<.D(a})~(x{D)+a{C
  V=. 0 x} V
  x=. (i.<./)V}_,:D
 end.D
)

NB. G=: (i.80 80)+&.>(<_80 1 80),.(<_80 _1 80),.~(80 78$<_80 _1 1 80)
NB. G=: ,(#~(0&<:*.<&6400))L:0 G
NB. C=: ,"."1 'm'fread'~temp/matrix.txt'