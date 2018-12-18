I=: \:~"1 ', '&splitstring S: 0 'b' fread '~temp/input.txt'
I=: > L: 1 ". L: 0 ('..' splitstring 2&}.) L: 0 I
I=: ]`(i.@:>:@:(-~/)+{.) @. (<:@:#) L: 0 I
I=: ;(<@:,@:{"1) I

M=: 1 (0 _429&+ each I)} 1985 256$0
W=: ,:0 71
C=: 1 0,0 _1,:0 1
wa=: 0 = ({~ <)"_ 1
in=: ((0 0 < [) *./@:*. <)"_ 1~
ne=: (C +"1 {:@]) -. ]
mv=: ] , [: {. [ (wa # ]) ((in # ]) ne)
lst=: 0 0 -.@:-: {:@]
flw=: _2 { mv^:lst^:_
run=: 3 : 0
 NB. M=. 1 (0 _429&+ each I)} 1985 256$0
 for. i.y do. M=: 2 (<M flw W)} M end.M
)
 