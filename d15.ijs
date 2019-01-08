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
ap=: 4 : 0 NB. a path
 t=. {:y   
 S=. ,<1{.y
 n=. (;~ (x ([: ~. [: ; <@:ne"_ 1) 0&{::) -. ;)
 e=. (((<0 2$0) -: {.) +: t e. 0&{::)
 p=. n^:e^:_ S
 if. ((<0 2$0) -: {.) p do. 0 2$0 else.
  p=. (<1 2$t) 0} p
  o=. ([ #~ 1 +./@:= md/~)&.>/\.&.|. p
  ([: {. /:~) S: 0 o
 end.
)
ev1=: 4 : 0 NB.evolve one
 if. 0<li x{y do.
  if. 0<#AT=. I. 1 = (x{y) (md&pl * ~:&gr * 0<li@:]) y do. 
   y=. y+_3 (<0,~{.(/: {&y) AT)} 0$~$y NB.attack if its in range
  else.
   N =. 0 (<"1 pl y)} M
   RA=. N (] #~ (wf pl)) (#~ ib@:pl) ((4#li),.ra@:pl,.4#gr) y NB.pl range
   EN=. RA #~ (x{y) ~:&gr RA NB.is enemy table
   PA=. N <@:ap"_ 2 (x{y) ,:&pl EN NB.paths
   NC=. (#~ (<0 2$0)&~:) (/: #S:0)^:(0<#) PA NB.sorted non empty paths
   if. 0<#NC do. y =. y (<x;1 2)}~ _2{0{::NC end. NB.move to new cell
   AT=. I. 1 = (x{y) (md&pl * ~:&gr * 0<li@:]) y NB.test again if can attack
   if. 0<#AT do. y=. y+_3 (<0,~{.(/: {&y) AT)} 0$~$y end.
  end.
 end.y
)
ev=: 3 : 'for_i. i.#y do. y=. i ev1 y end.(/: pl)(#~ 0<li) y'
sh=: 3 : 0
 x=. '#.GE' {~ (2+gr y) (;/pl y)} M
 y=. (/: pl) y
 a=. ([: ;/ 1&{"1 ":/. li) y
 b=. ([: ~. 1&{"1) y
 x,.' ',.>a b} a:#~#M
)