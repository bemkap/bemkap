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
A=: 0 1 (<0 0)} 11 11 2$_
M=: 11 m 11
run=: 4 : 0
 N =. ~. | (4 2$0 _1 _1 0 0 1 1 0) +"1 y 
 N =. N ([ #~ *./@:(< }:@$)"1 _) x NB. neighbours
 F =. M {~ <"1 N NB. fields type
 CO=. M {~ < y NB. current coordinate
 CC=. x {~ < y NB. current cost/equip
 P =. T {~ <"1 ({: CC) ,.~ CO ,. F NB. costs
 if. 0<#N do.
  B =. (P +"1 ] 0,~{.CC) (<"1 N)} x NB. new A?
  +."0 (B <&({."1) x)} j./"1 x,:B NB. select from B if costs less
 else. x end.
)
runrun=: 3 : 'for_i. ,{<@i."0 }:$y do. y=. y run >i end.'