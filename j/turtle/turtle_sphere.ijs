load'gl2 gles trig'
coinsert'jgl2 jgles'

S=: 100
mp=: +/ .*
d2r=: *&1r180p1
T=: ,:0 0 1 1 0 0 0 1 0
P=: 0 1 2{"1]
H=: 3 4 5{"1]
L=: 6 7 8{"1]
ap=: 1 : '],(u{:)'
av1=: (((cos,sin)@:d2r@:[(mp,(mp 1 _1*|.))P,:H),L)ap
av=: (4 : '(10|x) av1 (10 av1 ])^:(x<.@%10) ,:y')ap
gi=: (P,((cos,sin)@:d2r@:[(mp,(mp 1 _1*|.))H,:L))ap
gd=: -@:[gi]
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. 
  glrgba 0 0 0 32
  glpen 1
  gllines <.,2(160 160+{.)"1 S*SP mp TR
  glrgb 0 0 255
  glpen 2
  gllines <.,2(160 160+{.)"1 S*(TICS{.T1XY) mp TR
 catch. return. end. 
)
MXY=: RO=: 0 0
win_grph_mmove=: 3 : 0
 if. 4{D=. ".sysdata do. 
  RO=: 2**MXY-2{.D
  MXY=: 2{.D
  glpaint TR=: TR mp (gl_Rotate (-{:RO),1 0 0) mp (gl_Rotate ({.RO),0 1 0)
 end.
)
win_timer=: 3 : 'if. TICS<#T1XY do. glpaint TICS=: >:TICS else. wd''ptimer 0'' end.'
ta=: 1 : 0
 TICS=: 0
 TR=: =i.4
 SP=: 1,.~P;((10 gi (10 av ])^:36)^:18)&.><T
 T1XY=: (#~-.@:(0,}.-:"1}:))1,.~P;u&.><T
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;ptimer ',(":y),';pshow;'
)