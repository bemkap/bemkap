M =: '#.GE' i. 'm' fread '~temp/input15e.txt'
G =: 0,.~($M) #: I. 2=,M
E =: 1,.~($M) #: I. 3=,M
P =: 200 ,. /:~ G,E
M =: 1<.M
li=: 0&{"1
pl=: 1 2&{"1
gr=: 3&{"1
ra=: ([: ,/ +"1/)&(_1 0,0 _1,0 1,:1 0) NB.range
bc=: [: *./ <: NB.bound check
mn=: 0 0&bc NB.min bound check
mx=: bc&(<:$M) NB.max bound check
ib=: (mn *. mx)"1 NB.in bounds
wf=: 1 = ({~ <)"_ 1 NB.wall free
ne=: (wf # ]) [: (#~ ib) [: ra ,:
md=: ([: +/ [: | -)"1 NB.manhattan distance
ap=: 4 : 0 NB. A* path finding
 t=. {:y
 S=. ,<1{.y
 z=. ;~ (t (] /: (md,.])) x ne [: {. 0&{::) -. ;
 o=. ([: }.&.> 1&{) 0} }.
 s=. 0 >: [: # 0&{::
 e=. -:&(,<0 2$0) +: t e. 0&{::
 r=. (z`o@.s)^:e^:_ S
 if. r -: ,<0 2$0 do. 0 2$0 else. t,_2 ]\,> {.L:0 }.r end.
)
ev=: 4 : 0
 AT=. (1 = ([: md/~ pl) * [: ~:/~ gr) y NB.attack table
 AI=. I. +./"1 AT NB.attacker indices
 DI=. AI { ([: {. I. /: #&y)"1 AT NB.defender indices
 for_i. DI do. y=. (_3 0 0 0 + i{y) i} y end. NB.attack
 PL=. (i.#y) -. AI NB.players left
 N =. 0 (<"1 pl y)} x
 RA=. N (] #~ (wf pl)) (#~ ib@:pl) ((4#li) ,. ra@:pl ,. 4#gr) y NB.ranges
 EN=. (PL{y) ~:&gr/ RA
 D =. _ | <: EN *. (PL{y) (N #@:ap ,:)&pl/ RA NB.distances table
 MI=. (i. <./)"1 D
 if. 0<#PL do.
  PA=. N <@:ap"_ 2 (PL{y) ,:"1&pl MI{RA
  I =. (<0 2$0)&~: PA 
  y =. y  (<(I#PL);1 2)}~ _2 { S: 0 I#PA
  AT=. ((1 = md/&:pl~ * ~:/&:gr~) PL&{) y
  AI=. I. +./"1 AT NB.attacker indices
  DI=. AI { ([: {. I. /: #&y)"1 AT NB.defender indices
  for_i. DI do. y=. (_3 0 0 0 + i{y) i} y end. NB.attack
 end.(#~ 0<li)y
)
sh=: 4 : 0
 x=. '#.GE' {~ (2+gr y) (;/pl y)} x
 y=. (/: pl) y
 a=. ([: ;/ 1&{"1 ":/. li) y
 b=. ([: ~. 1&{"1) y
 x,.' ',.>a b} 7#a:
)