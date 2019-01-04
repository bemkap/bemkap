X=: 20183|510+*

m=: 4 : 0
 M=. (0,16807 X i.&.<: x) 0} 0$~y,x
 M=. (0,48271 X i.&.<: y) (<a:;0)} M
 for_i. ,{ y ;&(i.&.<:) x do.
  'xc yc'=. >i
  a=. M{~<yc,~<:xc
  b=. M{~<xc, <:yc
  M=. (a X b) i} M
 end.0 (<_1 _1)} 3|M
)

c=: ,:0 0 0 _ 0 NB. . -> . neither : _
c=: c,0 0 1 1 1 NB. . -> . torch   : torch
c=: c,0 0 2 1 2 NB. . -> . gear    : gear
c=: c,0 1 0 _ 0 NB. . -> = neither : _
c=: c,0 1 1 8 2 NB. . -> = torch   : gear
c=: c,0 1 2 1 2 NB. . -> = gear    : gear
c=: c,0 2 0 _ 0 NB. . -> | neither : _
c=: c,0 2 1 1 1 NB. . -> | torch   : torch
c=: c,0 2 2 8 1 NB. . -> | gear    : torch
c=: c,1 0 0 8 2 NB. = -> . neither : gear
c=: c,1 0 1 _ 1 NB. = -> . torch   : _
c=: c,1 0 2 1 2 NB. = -> . gear    : gear
c=: c,1 1 0 1 0 NB. = -> = neither : neither
c=: c,1 1 1 _ 1 NB. = -> = torch   : _
c=: c,1 1 2 1 2 NB. = -> = gear    : gear
c=: c,1 2 0 1 0 NB. = -> | neither : neither
c=: c,1 2 1 _ 1 NB. = -> | torch   : _
c=: c,1 2 2 8 0 NB. = -> | gear    : neither
c=: c,2 0 0 8 1 NB. | -> . neither : torch
c=: c,2 0 1 1 1 NB. | -> . torch   : torch
c=: c,2 0 2 _ 2 NB. | -> . gear    : _
c=: c,2 1 0 1 0 NB. | -> = neither : neither
c=: c,2 1 1 8 0 NB. | -> = torch   : neither
c=: c,2 1 2 _ 2 NB. | -> = gear    : _
c=: c,2 2 0 1 0 NB. | -> | neither : neither
c=: c,2 2 1 1 1 NB. | -> | torch   : torch
c=: c,2 2 2 _ 0 NB. | -> | gear    : _

T=: (_2{."1 c) (;/3{."1 c)} 3 3 3 2$0
A=: 0 1 (<0 0)} 20 20 2$_
M=: 0 (<10 10)} m~ 20
run=: 4 : 0
 while. 1 do.
  N =. ,/ 0j_1 _1j0 0j1 1j0 (] , +)"0/ y
  N =. (#~ (y -.@e.~ {:)"1) N NB. discard visited
  N =. (#~ ( 0  0 (*./ .<:)"1 +.@:{:"1)) N NB. discard lower indices
  N =. (#~ (($M) (*./ .>)"1 +.@:{:"1)) N NB. discard greater indices
  if. 0=#N do. break. end. NB. no neighbours left
  'CC CE'=. |: x {~ <"1 +.{."1 N NB. from costs/equips
  I =. CE,.~M {~ <"1 +. N NB. indices
  P =. T {~ <"1 I NB. to costs/equips
  P =. (CC+{."1 P),.{:"1 P NB. current costs + P
  Mi=. /:P
  B =. ({. Mi{P) (<+.{. Mi{{:"1 N)} x NB. new possible x
  x =. >(x <&{:"1 B)} <"1 B,:x
  y =. y,({. Mi{{:"1 N)
 end.x
)