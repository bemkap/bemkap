load'~temp/turtle/turtle_sphere.ijs'

branch=: 1 : 0
 'size level'=. m
 if. level>0 do.
  sb=. (((1r2*size),<:level)branch)
  1 sp (-size) av 0 sp sb 90 gd sb 180 gi sb 90 gd size av y
 else. 1 sp (-size) av 0 sp size av y end.
)
chamber=: 1 : 0
 'base s1 s2 a1 a2'=. m
 s1 av a1 gi ({:y),~0 sp s2 av a2 gi base av y
)
growth=: 2 : 0
 if. 500>#y do.
  'base s1 s2 a1 a2'=. m
  'rs1 rs2 ra1 ra2'=. n
  ur=. Txy _5{y=. (m chamber)y
  base1=. |ur-Txy{:y
  y=. (d2r inv ur) sh y
  ((base1,(s1*rs1),(s2*rs2),360|ra1*a1,ra2*a2)growth n)y
 else. y end.
)
eqspi=: 2 : 0
 'size angle factor'=. m
 for_i. i.>:n do. y=. angle gd (size*factor^i) av y end.
)
nested=: 1 : 'if. m>10 do. for. i.3 do. y=. 120 gd (-:m) av (m insert) (-:m) av y end. else. y end.'
insert=: 1 : '120 gd ((-:m)nested) 120 gi y'
c=: 1 : 0
 'size level'=. m
 if. level>0 do. y=. 90 gi ((size,<:level)c) 90 gd ((size,<:level)c)y else. size av y end.
)
dragon=: 1 : 0
 'size level lr'=. m
 if. level>0 do. y=. ((size,(<:level),1)dragon) (90*lr) gd ((size,(<:level),_1)dragon)y else. size av y end.
)
fill=: 1 : 0
 'size level'=. m
 if. level>0 do.
  f=. ((size%3),<:level) fill
  f 90 gd 90 f@:gi^:3 ]90 f@:gd^:3 f 90 gi f y
 else. size av y end.
)
hilbert=: 1 : 0
 'size level p'=. m
 if. level>0 do.
  lh=. (size,(<:level), p)hilbert
  rh=. (size,(<:level),-p)hilbert
  an=. 90*p
  an gi rh size av an gd lh size av lh an gd size av rh an gi y
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
pf=: 2 : 0
 'size level'=. m
 if. level>0 do.
  y=. (180-360%n) gi (1r3*size) av y
  for. i.<:n do. y=. (360%n) gd (((1r3*size),<:level) pf n)y end.
  (1r3*size) av 180 gd y
 else. size av y end.
)
ht=: 1 : 0
 'size level'=. m
 if. level>0 do.
  f=. ((-:size),<:level)ht
  (120 f@:gd size av ])^:2 f 120 gd (-:size) av 60 gi f 60 gd (-:size) av y
 else. y end.
)
square=: 4 : '({:y),~0 sp (90 gd x av ])^:3 y'
glue1=: 2 : 0
 'size level'=. m
 if. level>0 do. (1 sp 90 gd size av 0 sp (((-:size),<:level) glue2 v))^:4 y else. size v y end.
)
glue2=: 2 : 0
 'size level'=. m
 if. level>0 do. 
  sf=. ((-:size),<:level) glue1 v
  y=. (-:size) av 90 gi 0 sp sf 1 sp 90 gd (-:size) av 0 sp y
  y=. 90 gd size av 0 sp sf 1 sp 90 gd y
  y=. (-:size) av 90 gi 0 sp sf 1 sp 90 gd (-:size) av y 
  y=. 90 gd size av 0 sp sf 1 sp 90 gd y
 else. size v y end.
)
poly=: 1 : '(({.m) av (360%{:m) gi ])^:({:m)'
duopoly=: 1 : 0
 for_i. i.(*%+.)&(360&((*%+.)%]))/{:"1 m do. for_j. m do.
  y=. ({.j) av (i*{:j) sh y
 end. end.
)
gospel=: 1 : 0
 'side angle level'=. m
 if. level>0 do. ((side,(360|+:angle),<:level)gospel) side av angle gi y else. y end.
)
scissor=: 1 : 0
 'distance phase'=. m
 phase gd distance av (+:phase) gi distance av phase gd y
)
poly_s=: 1 : 0
 'd a phase'=. m
 (a gi ((d,phase)scissor))^:(sym a)y
)
poly_ds=: 2 : 0
 'd a dphase'=. m
 for_i. dphase*i.n do. y=. ((d,a,i)poly_s) y end.
)
shrinkseg=: 1 : '((cos d2r{:m)*({.m)) av ]'
shrinkpoly=: 2 : 0
 'd a dphase'=. m
 for_i. dphase*i.n do. y=. a gi (d,i) shrinkseg y end.
)
mutate=: 2 : 0
 'd1 d2 a1 a2'=. m
 for_i. (n+1)%~i.n do.
  d=. <.(i*d1)+(1-i)*d2
  a=. <.(i*a1)+(1-i)*a2
  y=. 100 av (a gd d av ])^:(sym a) y
 end.
)
koch=: 1 : 0
 'size level angle'=. m
 if. level>0 do.
  sk=. (<:m)koch
  sk angle gi sk (+:angle) gd sk angle gi sk y
 else. size av y end.
)
koch_t=: 1 : 0
 'size level angle poly'=. m
 ((360%poly) gi ((size,level,angle)koch))^:(|poly)
)