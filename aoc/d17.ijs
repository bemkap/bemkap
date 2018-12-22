require'viewmat'
I=: \:~"1 ', '&splitstring S: 0 'b' fread '~temp/input2.txt'
I=: > L: 1 ". L: 0 ('..' splitstring 2&}.) L: 0 I
I=: ]`(i.@:>:@:(-~/)+{.) @. (<:@:#) L: 0 I
I=: ;(<@:,@:{"1) I

M  =: 1 (0 _495&+ each I)} 14 14$0
W  =: ,:0 5 NB. starting point
NB. M  =: 1 (0 _429&+ each I)} 1985 256$0 NB. map
NB. W  =: ,:0 71 NB. starting point
NB. C  =: 1 0,0 _1,:0 1 NB. neighbour coordinates
NB. wa =: 0 = ({~ <)"_ 1 NB. is not wall
NB. in =: ((0 0 <: [) *./@:*. (< $))~"_ 1 NB. is inside map
NB. ne =: (C +"1 {:@]) -. ] NB. neighbourhood
NB. mv =: ] , [: {. [ (wa # ]) ((in # ]) ne) NB. move
NB. lst=: 0 0 -.@:-: {:@] NB. last
NB. flw=: _2 { mv^:lst^:_ NB. flow
NB. run=: 3 : 0
NB.  while. 1 do.
NB.   c=. y flw W
NB.   if. 0=<:|{.c-$y do. break. end.
NB.   y=. 2 (<c)} y
NB.  end.y
NB. )

wa=: 0 = ({~ <@:{:) NB. is wall
cn=: 0 ~: ({~ 1 0<@:+{:) NB. is contained

dw=: ] , 1  0+{:@:] NB. down
lf=: ] , 0 _1+{:@:] NB. left
rg=: ] , 0  1+{:@:] NB. right

fd=: dw^:wa^:_ NB. fill down
fl=: [: }: lf^:(wa *. cn)^:_ NB. fill left
fr=: [: }: rg^:(wa *. cn)^:_ NB. fill right
fb=: fl , fr NB. fill both
flw=: [ fb _2 ,:@:{ fd NB. flow