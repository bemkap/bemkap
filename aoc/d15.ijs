A =: '#.GE'
M =: A i. 'm' fread '~temp/input15e.txt'
G =: 0,.~($M) #: I. 2=,M
E =: 1,.~($M) #: I. 3=,M
P =: /:~ G,E
M =: 1<.M
pl=: 2&{."1
ra=: ([: ,/ +"1/)&(_1 0,0 _1,0 1,:1 0) NB.range
bc=: [: *./ <: NB.bound check
mn=: 0 0&bc NB.min bound check
mx=: bc&(<:$M) NB.max bound check
ne=: (wf # ]) [: (#~ ib) [: ra ,:
wf=: 1 = ({~ <)"_ 1 NB.wall free
ib=: (mn *. mx)"1 NB.in bounds
md=: ([: +/ [: | -)"1 NB.manhattan distance
ap=: 4 : 0 NB. A* path finding
 t=. {:y
 S=. ,<1{.y
 z=. ;~ (x ne [: {. 0&{::) -. ;
 o=. ([: }. 1&{::) ; 2&}.
 s=. 0 >: [: # 0&{::
 e=. (0 >: #) +: t e. 0&{::
 {. S: 0 (z`o@.s)^:e^:_ S
)
ev=: 4 : 0
 RA=. x (] #~ (wf pl)) (#~ ib@:pl) (ra@:pl ,. 4#{:"1) y
 N =. 0 (<"1 pl y)} x
 y (N #@:ap ,:)&pl/ RA
)
NB. ok=: [: (#~ wf) (#~ ib) NB.ok cell
NB. sp=: ([: \:~ [: ~. [: ok (pl P) -.~ (,ra))^:_@:,: NB.span
NB. in=: [ -. -. NB.intersection
NB. fn=: 3 : 0
NB.  RA=. (ra@:pl ,. 4 # {:"1) y NB.player range
NB.  RA=. (#~ wf@:pl) (#~ ib@:pl) RA
NB.  RA=. RA #~ -. RA e.&pl P
NB.  RR=. <@:sp"1 pl RA NB.span of all range cells
NB.  RP=. <@:sp"1 pl y NB.span of each player
NB.  IR=. RP (0 < #@:in)&>/ RR NB.in range table
NB.  EN=. y ~:"0/&gr RA NB.enemy table
NB.  y (i. <./)@:(md"1/&pl #&RA)"1 IR*.EN
NB. )