g=: 2 : 'm&(-@[ |. n&(|.@{. , }.)@|.)'
xor=: 22 b.
k=: 3 : 0
s=. p=. 0
I=. i.256
for_j. i.64 do.
 for_i. 17 31 73 47 23,~a.i.y do.
  I=. (p g i) I
  p=. p+s+i
  s=. >:s
 end.
end.
,'0123456789abcdef' {~ 16 16 #: _16 xor/\ I
)

pi=: 'xlqgujun-'
K=: pi (k@, ":)"_ 0 i.128
B=: ,"2 ] 2 2 2 2 #: '0123456789abcdef' i. K