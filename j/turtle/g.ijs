load'~temp/turtle/turtle_3d.ijs'

sphere=: (10 pitch (10 yaw 15 av ])^:36)^:36
poly=: 1 : '((0{m) pitch ((1{m) roll ((2{m) yaw 60 av ])^:(sym 2{m))^:(sym 1{m))^:(sym 0{m)'
t3=: 1 : '(120 pitch 100 av _20 roll 20 (120 yaw m av ])^:3@:roll ])^:3'
st=: 1 : 0
 's l a'=. m
 if. l>0 do. f1=. ((-:s),(<:l),-a)st else. f1=. (-:s) av ] end.
 f1 (a*_60) yaw f1 (a*40) yaw _30 roll (a*110) pitch f1 (a*60) yaw f1 20 roll y
)
h3d=: 1 : 0
 's l'=. m
 if. l>0 do. sf=. ((-:s),<:l)h3d else. sf=. s av ] end.
 (90 sf@:pitch ])^:2 (90 sf@:yaw ])^:2 (90 sf@:pitch ])^:2 sf y
)