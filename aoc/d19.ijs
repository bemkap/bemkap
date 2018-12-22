i=: (&{)(@])
r=: i(`{)(`[)(`:6)
addr=: ((0 r)+(1 r))`(2 i)`[}         }.
addi=: ((0 r)+(1 i))`(2 i)`[}         }.
mulr=: ((0 r)*(1 r))`(2 i)`[}         }.
muli=: ((0 r)*(1 i))`(2 i)`[}         }.
banr=: ((0 r) (17 b.) (1 r))`(2 i)`[} }.
bani=: ((0 r) (17 b.) (1 i))`(2 i)`[} }.
borr=: ((0 r) (23 b.) (1 r))`(2 i)`[} }.
bori=: ((0 r) (23 b.) (1 i))`(2 i)`[} }.
setr=: (0 r)`(2 i)`[}                 }.
seti=: (0 i)`(2 i)`[}                 }.
gtir=: ((0 i)>(1 r))`(2 i)`[}         }.
gtri=: ((0 r)>(1 i))`(2 i)`[}         }.
gtrr=: ((0 r)>(1 r))`(2 i)`[}         }.
eqir=: ((0 i)=(1 r))`(2 i)`[}         }.
eqri=: ((0 r)=(1 i))`(2 i)`[}         }.
eqrr=: ((0 r)=(1 r))`(2 i)`[}         }.

Ins=: addr`addi`mulr`muli`banr`bani`borr`bori`setr`seti`gtir`gtri`gtrr`eqir`eqri`eqrr
SIns=: _4 ]\ 'addraddimulrmulibanrbaniborrborisetrsetigtirgtrigtrreqireqrieqrr'
Prg=: ((SIns i. 4&{."1) ,. ([: ". 4&}."1)) }. I
R=: 1 0 0 0 0 0

I=: 'm' fread '~temp/input19.txt'
NB. part 1
run=: 4 : 0
 while. (#y)>3{x do.
  x=. 0 0 0 1 0 0+x Ins@.({.@]) y{~3{x
 end.x
)
NB. part 2
D=: +/10551343 959213 14201 8173 1 11 743 1291