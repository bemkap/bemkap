require'gl2 numeric regex'
coinsert'jgl2'

I=: 'm'fread'~temp/input1.txt'
r=: 'position=<(-?\d+),(-?\d+)>velocity=<(-?\d+),(-?\d+)>'
trim=: (' ';'')&stringreplace
n=: > ". L: 0 r&(rxmatches }.@:{.@:rxfrom ])@:trim"1 I
p=: 0.01*2{."1 n
v=: 0.01*_2{."1 n

JULIA=: 0 : 0
 pc win closeok;
 minwh 500 500;cc grph isigraph;
 ptimer 0;
)
win_run=: 3 : 0
 NB. p=: p+10619*v
 p=: p+10619*v
 try.
  wd JULIA
  wd 'pshow'
 catch.
 end.
)
win_grph_paint=: 3 : 0
 q=. 50+400*(%"1 (>./-<./)) (-"1 <./) p
 glclear''
 glcaret@(,&10 50)"1]0 _60+"1<.q
 NB. glpixel"1 <.q
)
win_timer=: 3 : 0
 p=: p+v
 glsel'grph'
 glpaint''
)
win_run''