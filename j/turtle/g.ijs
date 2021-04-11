load'~temp/turtle/turtle_3d.ijs'

sphere=: (10 pitch (10 yaw 15 av ])^:36)^:36
poly=: 1 : '((0{m) pitch ((1{m) roll ((2{m) yaw 60 av ])^:(sym 2{m))^:(sym 1{m))^:(sym 0{m)'
h3d=: 1 : 0 NB. hilbert 3d
 's l'=. m
 if. l>0 do. 
  sf=. (s,<:l)h3d
  90 roll _90 yaw sf 90 roll s av _90 yaw sf s av sf 180 roll 90 yaw s av _90 pitch sf s av sf 180 roll 90 pitch s av _90 yaw sf (s av _90 sf@:roll 90 pitch ])^:2 y
 else. y end.
)
