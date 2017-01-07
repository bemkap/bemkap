require'regex'
W=: 3 NB. 35
H=: 3 NB. 30
F=: 'm' fread jpath './input2.txt'
R=: '/dev/grid/node-x\d+-y\d+\s+\d+T\s+(\d+)T\s+(\d+)T'
M=: (W,H,2)$; ". S: 0}."1,/R&(rxmatches rxfrom ])"1]2}.F

ib=: #~ ((0&<: *. <&H)@[ *. (0&<: *. <&W)@])/"1
N =: 0 _1,0 1,_1 0,:1 0
I =: (H,W) #. inv i. W*H
ft=: (0<{.@[) *. {.@[ < {:@]

NB. (H,W)$,/((M {~ <) ((ft"1 M&({~)) # ]) [: <"1 [: ib +"1&N)"1 ] I NB. map