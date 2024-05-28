input=: cutLF(0 : 0)
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
)

input=: 'b'fread'input11'

input=: "."0&>input
check=: 9+/@:<(0 0;0 1;0 2;1 0;1 2;2 0;2 1;2 2)&{
boarden=: __,__,~__,.__,.~]
flash=: 3 : 0
 can=. ($y)$t=. 1
 while. +./0<,t do.
  can=. can*.9>:y=. y*can
  y=. y+t=. ((1 1,:3 3) check;._3 boarden)y
 end.can*y
)
solution1=: +/0=,flash@:>:^:(<101)input

noteveryone=: 0+./@:<,
solution2=: <:#flash@:>:^:noteveryone^:a: input