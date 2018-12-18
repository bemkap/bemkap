require'regex'

NB. R op V
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
NB. part 1
NB. test=: 2&{:: -:"1 [: Ins`:0&>/ 2&{.
NB. before=: 'Before:\s*\[(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\]'
NB. instruction=: '(\d+)\s*(\d+)\s*(\d+)\s*(\d+)'
NB. after=: 'After:\s*\[(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\]'
NB. Input=: |:776 3$(#~ a:&~:) 3103 {. 'b' fread '~temp/input.txt'
NB. B=: ;/ > ". L: 0 before&(rxmatches }.@:{.@:rxfrom ]) S: 0]0{Input
NB. Oc=: {."1 > ". L: 0 instruction&(rxmatches }.@:{.@:rxfrom ]) S: 0]1{Input
NB. I=: ;/ }."1 > ". L: 0 instruction&(rxmatches }.@:{.@:rxfrom ]) S: 0]1{Input
NB. A=: ;/ > ". L: 0 after&(rxmatches }.@:{.@:rxfrom ]) S: 0]2{Input
NB. Input=: |: B,I,:A
NB. Ops=: 3 : 0
NB.  A=. B=. 0$0
NB.  Ti=. test"1 Input
NB.  for. i.16 do.
NB.   'a b'=. {. ({&Oc ; I.@:{&Ti)"0 (I.@:(1 = +/"1)) Ti
NB.   A=. A,a
NB.   B=. B,b
NB.   Ti=. (0&(b}))"1 Ti
NB.  end.B/:A
NB. )
NB. part 2
NB. Ops=: 1 5 10 6 15 7 12 8 3 9 4 11 13 14 0 2
NB. Input=: >". each 3106 }. 'b' fread '~temp/input.txt'
NB. run=: 3 : 0
NB.  R=. 0 0 0 0
NB.  for_l. y do. R=. R Ins@.(Ops{~{.@]) l end.R
NB. )