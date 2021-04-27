load'~temp/turtle/turtle_2d.ijs'

branch=: 1 : 0 NB. tree
 'size level an'=. m
 if. level>0 do.
  sb=. ((1r2*size),(<:level),an)branch
  1 sp (-size) av 0 sp sb an gd sb (+:an) gi sb an gd size av y
 else. 1 sp (-size) av 0 sp size av y end.
)
eqspi=: 2 : 0 NB. spiral
 'size angle factor'=. m
 for_i. i.>:n do. y=. angle gd (size*factor^i) av y end.
)
st1=: 1 : 'if. m>10 do. for. i.3 do. y=. 120 gd (-:m) av (m insert) (-:m) av y end. else. y end.' NB. sierpinski triangle 1
sah=: 1 : 0 NB. sierpinski triangle 2 (arrowhead)
 's l p'=. m
 if. l>0 do.
  sah1=. (s,(<:l), p)sah
  sah2=. (s,(<:l),-p)sah
  sah2 (p*60) gd sah1 (p*60) gd sah2 y
 else. s av y end.
)
insert=: 1 : '120 gd ((-:m)st1) 120 gi y'
c=: 1 : 0
 if. m>0 do. 
  sc=. (<:m)c
  90 gi sc 90 gd sc y 
 else. 10 av y end.
)
dragon=: 1 : 0
 'level p'=. m
 if. level>0 do. 
  sd0=. ((<:level), 1)dragon
  sd1=. ((<:level),_1)dragon
  sd0 (p*90) gd sd1 y
 else. 10 av y end.
)
sfill=: 1 : 0 NB. square fill
 if. m>0 do.
  sf=. (<:m)sfill
  sf 90 gd 90 sf@:gi^:3 ]90 sf@:gd^:3 sf 90 gi sf y
 else. 10 av y end.
)
tfill=: 1 : 0 NB. triangle fill
 's l'=. m
 if. l>0 do.
  sf=. ((-:s),<:l)tfill
  (120 sf@:gd s av ])^:2 sf 120 gd (-:s) av 60 gi sf 60 gd (-:s) av y
 else. y end.
)
hilbert=: 1 : 0 NB. hilbert fill
 'level p'=. m
 if. level>0 do.
  lh=. ((<:level), p)hilbert
  rh=. ((<:level),-p)hilbert
  (p*90) gi rh 10 av (p*90) gd lh 10 av lh (p*90) gd 10 av rh (p*90) gi y
 else. y end.
)
nest=: 2 : 0
 'size level'=. m
 an=. 360%n
 if. level>0 do.
  an gd (size av an gd ])^:(<:n) (-:size) av (m subnest n) (-:size) av y
 else. y end.
)
subnest=: 2 : 0
 'size level'=. m
 an=. -:360%n
 ai=. 1p1*(n-2)%n
 size1=. ((-:size)*sin ai)%sin -:1p1-ai
 an gi ((size1,(<:level)) nest n) an gd y
)
poly=: 1 : '(10 av (360%m) gi ])^:m'
duopoly=: 1 : 0
 for_i. i.(*%+.)&(360&((*%+.)%]))/ m do. for_j. m do.
  y=. 10 av (i*j) sh y
 end. end.
)
pf=: 1 : 0 NB. koch variations 1
 's l n'=. m
 if. l>0 do.
  y=. (180-360%n) gi (1r3*s) av y
  y=. ((360%n) gd (((1r3*s),(<:l),n)pf))^:(<:n)y
  (1r3*s) av 180 gd y
 else. s av y end.
)
koch=: 1 : 0 NB. koch variations 2
 'l an'=. m
 if. l>0 do.
  sk=. ((<:l),an)koch
  sk an gi sk (+:an) gd sk an gi sk y
 else. 10 av y end.
)
koch_t=: 1 : 0 NB. koch variations 2 closed
 'size level angle poly'=. m
 ((360%poly) gi ((size,level,angle)koch))^:(|poly)
)
sqr=: 1 : '[:u(90 gi u)^:3' NB. square fractals
sqr1=: 1 : 0 NB. square fractal pattern 1
 if. m>0 do.
  sf=. (<:m)sqr1
  sf^:2 (90 gi sf)^:4 sf y
 else. 10 av y end.
)
brush1=: 1 : 0
 if. m>0 do.
  sb=. (<:m)brush1
  sb ({:y),~0 sp sb _25.7 gd y=. sb ({:y),~0 sp sb 25.7 gd y=. sb y
 else. 10 av y end.
)
brush2=: 1 : 0
 if. m>0 do.
  sb=. (<:m)brush2
  ({:y),~0 sp (22.5 sb@:gi ])^:2 sb 22.5 gd y=. 22.5 gd ({:y),~0 sp (22.5 sb@:gd ])^:2 sb 22.5 gi y=. 22.5 gi sb^:2 y
 else. 10 av y end.
)
NB. penrose tiling
pf=: 1 : 'if. m>0 do. y else. 10 av y end.'
pp=: 1 : 'if. m>0 do. ((<:m)pf) ((<:m)pn) 72 gi ({:y) ,~ 0 sp ((<:m)pf) ((<:m)pn) 144 gd ((<:m)pf) ((<:m)pp) 36 gd y=. ((<:m)pf) ((<:m)pm) 144 gd ((<:m)pf) ((<:m)po) 72 gi y else. y end.'
po=: 1 : 'if. m>0 do. 36 gi ({:y) ,~ 0 sp ((<:m)pf) ((<:m)pp) 72 gd ((<:m)pf) ((<:m)po) 108 gd y=. ((<:m)pf) ((<:m)pn) 72 gd ((<:m)pf) ((<:m)pm) 36 gi y else. y end.'
pn=: 1 : 'if. m>0 do. 36 gd ({:y) ,~ 0 sp ((<:m)pf) ((<:m)pn) 72 gi ((<:m)pf) ((<:m)pm) 108 gi y=. ((<:m)pf) ((<:m)pp) 72 gi ((<:m)pf) ((<:m)po) 36 gd y else. y end.'
pm=: 1 : 'if. m>0 do. 72 gd ({:y) ,~ 0 sp ((<:m)pf) ((<:m)pm) 144 gi ((<:m)pf) ((<:m)po) 36 gi y=. ((<:m)pf) ((<:m)pn) 144 gi ((<:m)pf) ((<:m)pp) 72 gd ((<:m)pf) ((<:m)po) y else. y end.'
penrose=: 1 : '(72 gd {: ,~ 0 sp (m pn))^:5'