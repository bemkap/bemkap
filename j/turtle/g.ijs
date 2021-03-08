load'~temp/turtle/turtle_v.ijs'

sphere=: (10 pitch (10 yaw 15 av ])^:36)^:36
poly=: 1 : '((0{m) pitch ((1{m) roll ((2{m) yaw 45 av ])^:(sym 2{m))^:(sym 1{m))^:(sym 0{m)'
tree=: 1 : 0
 if. m>0 do.
  y =. m av y
  b1=. ((m-1)tree)  45 pitch y
  b2=. ((m-1)tree) _45 pitch y
  b3=. ((m-1)tree)  45 yaw y
  b4=. ((m-1)tree) _45 yaw y
  (0 sp y),(0 sp b1),(0 sp b2),(0 sp b3),0 sp b4
 else. y end.
)
horn=: 1 : 0
 's0 n'=. m
 for_i. i.n do. 
  r=. 1%>:i
  y=. (s0*r) av 10 roll (360*r) yaw y
 end.
)