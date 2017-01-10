require'regex'
W=: 3 NB. 35
H=: 3 NB. 30
F=: 'm' fread jpath './input2.txt'
R=: '/dev/grid/node-x\d+-y\d+\s+\d+T\s+(\d+)T\s+(\d+)T'
NB. M=: (W,H,2)$; ". S: 0}."1,/R&(rxmatches rxfrom ])"1]2}.F
M=: 3 3 2$8 2 7 2 6 4 6 5 0 8 8 1 28 4 7 4 6 3

ib=: #~ ((0&<: *. <&H)@[ *. (0&<: *. <&W)@])/"1
N =: 0 _1,0 1,_1 0,:1 0
I =: (H,W) #. inv i. W*H
ft=: (0<{.@[) *. {.@[ <: {:@]

NB. ix=: <1 2$1 1
em=: [: +./ (0 e. $) S: 0@{:
f =: (((ft~&(M{~<)"1 # ])[:ib+"1&N))@{. L: 0
g =: _2&}. , }. L: 0@(_2&{)
h =: (,f@{:)`g@.em

s =: 3 : 0
ix=. <1 2$1 1
M1=. M
for_i. i.3 do.
  ix=. h ix
  M =: M1 ((|.@:;/@[ { ])`(;/@[)`]})~ 0 2,~{. S: 0 ix
end.M;ix
)

NB. (H,W)$,/((M {~ <) ((ft"1 M&({~)) # ]) [: <"1 [: ib +"1&N)"1 ] I NB. map