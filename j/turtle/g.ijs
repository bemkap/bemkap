load'/turtle_3d.ijs',~1!:43''

sphere=: (10 pitch (10 yaw 15 av ])^:36)^:36
poly=: 1 : '((0{m) pitch ((1{m) roll ((2{m) yaw 60 av ])^:(sym 2{m))^:(sym 1{m))^:(sym 0{m)'
h3d=: 1 : 0 NB. hilbert 3d
 's l'=. m
 if. l>0 do. 
  sf=. (s,<:l)h3d
  90 roll _90 yaw sf 90 roll s av _90 yaw sf s av sf 180 roll 90 yaw s av _90 pitch sf s av sf 180 roll 90 pitch s av _90 yaw sf (s av _90 sf@:roll 90 pitch ])^:2 y
 else. y end.
)
tree=: 1 : 0 NB. 3d tree
 's l a'=. m
 if. l>0 do.
  st=. ((-:s),(<:l),a)tree
  y=. s av y
  b0=. st a yaw ,:{:y
  b1=. st (-a) yaw ,:{:y
  b2=. st a pitch ,:{:y
  b3=. st (-a) pitch ,:{:y
  b3,~0 sp b2,~0 sp b1,~0 sp b0,~y
 else. y end.
)


NB. ω:A
NB. p1:A→[&FL!A]/////’[&FL!A]///////’[&FL!A]
NB. p2:F→S ///// F
NB. p3:S→FL
NB. p4:L→[’’’∧∧{-f+f+f-|-f+f+f}]