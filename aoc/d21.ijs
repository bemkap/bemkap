i=: (&{)(@])
r=: i(`{)(`[)(`:6)
addr=: ((0 r)+(1 r))`(2 i)`[}         }.
addi=: ((0 r)+(1 i))`(2 i)`[}         }.
mulr=: ((0 r)*(1 r))`(2 i)`[}         }.
muli=: ((0 r)*(1 i))`(2 i)`[}         }.
banr=: ((0 r) eand (1 r))`(2 i)`[}    }.
bani=: ((0 r) eand (1 i))`(2 i)`[}    }.
borr=: ((0 r) eor (1 r))`(2 i)`[}     }.
bori=: ((0 r) eor (1 i))`(2 i)`[}     }.
setr=: (0 r)`(2 i)`[}                 }.
seti=: (0 i)`(2 i)`[}                 }.
gtir=: ((0 i)>(1 r))`(2 i)`[}         }.
gtri=: ((0 r)>(1 i))`(2 i)`[}         }.
gtrr=: ((0 r)>(1 r))`(2 i)`[}         }.
eqir=: ((0 i)=(1 r))`(2 i)`[}         }.
eqri=: ((0 r)=(1 i))`(2 i)`[}         }.
eqrr=: ((0 r)=(1 r))`(2 i)`[}         }.

eand=: *.&.((50$2)&#:)
eor =: +.&.((50$2)&#:)

I=: 'm' fread '~temp/input21.txt'
Ins=: setr`seti`gtir`gtri`gtrr`eqir`eqri`eqrr
Ins=: addr`addi`mulr`muli`banr`bani`borr`bori`Ins
SIns=: _4 ]\ 'addraddimulrmulibanrbaniborrborisetrsetigtirgtrigtrreqireqrieqrr'
Prg=: x: ((SIns i. 4&{."1) ,. ([: ". 4&}."1)) }. I
R=: 0 0 0 0 0 0
step=: 0 0 0 0 1 0 + (] Ins@.({.@]) ([ {~ 4{]))
run=: step^:(#@[ > 4{])^:_