load'~temp/turtle/turtle_3d.ijs'

sphere=: (10 pitch (10 yaw 15 av ])^:36)^:36
poly=: 1 : '((0{m) pitch ((1{m) roll ((2{m) yaw 60 av ])^:(sym 2{m))^:(sym 1{m))^:(sym 0{m)'
t3=: 1 : '(120 pitch 100 av _20 roll 20 (120 yaw m av ])^:3@:roll ])^:3'
st=: 1 : 0
 's l'=. m
 if. l>0 do.
 else. (-:s) av 60 pitch 60 yaw (-:s) av 60 yaw (-:s) av 20 roll (s t3) y end.
)