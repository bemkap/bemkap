load '~temp/turtle/turtle.ijs'

branch=: 1 : 0
 'l s'=. m
 if. l>0 do.
  y=. s av y
  lb=. (((<:l),4r5*s)branch)45 gi y
  rb=. (((<:l),3r5*s)branch)45 gd y
  (0 sp y),(0 sp lb),(0 sp rb)
 else.
  y
 end.
)
face=: 4 : '({:*.y -&Txy x)(0})x'
chamber=: 1 : 0
 'base s1 s2 a1 a2'=. m
 s1 av a1 gi ({:y),~0 sp s2 av a2 gi base av y
)
growth=: 2 : 0
 if. 500>#y do.
  'base s1 s2 a1 a2'=. m
  'rs1 rs2 ra1 ra2'=. n
  ur=. _5{y=. (m chamber)y
  base1=. ur|@-&Txy({:y)
  y=. y,({:y) face ur
  ((base1,(s1*rs1),(s2*rs2),360|ra1*a1,360|ra2*a2)growth n)y
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
sc=: 1 : 0
 'size level'=. m
 if. level>0 do. (45 gi 45 (((1r3*size),<:level)sc)@:gi size av ])^:3 y
 else. y end.
)