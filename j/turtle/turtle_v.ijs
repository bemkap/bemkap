load'plot gl2 trig gles'
coinsert'jgl2 jgles'

T  =: ,:1 0 0 0 1 0 0 0 1 0 0 0 1
TV =: 9{."1]
TH =: 0  1  2{"1]
TL =: 3  4  5{"1]
TU =: 6  7  8{"1]
TP =: 9 10 11{"1]
TPE=:      12{"1] 
d2r=: *&1r180p1
rot=: (cos@d2r@[*0{])+(sin@d2r@[*1{])
sym=: 360&((*%+.)%])
mp=: +/ .*
ap=: 1 : '],(u{:)'
av=: (TV,((*TH)+TP),TPE)ap
ju=: (TV,((*TL)+TP),TPE)ap
jr=: (TV,((*TU)+TP),TPE)ap
sp=: (TV,TP,[)ap
pitch=: (([ rot TH,:TU),TL,([ rot TU,:-@:TH),TP,TPE)ap
roll =: (TH,([ rot TL,:TU),([ rot TU,:-@:TL),TP,TPE)ap
yaw  =: (([ rot TH,:TL),([ rot TL,:-@:TH),TU,TP,TPE)ap
NB. E =: (=i.3),0 0 _1
E =: 1 0 0 1
pp=: ((}:@:]+/ .*"1(-{:))~)"_ 1
pr=: (2&{.*1%{:)"1@:pp
MXY=: 0 0
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. gllines <.,2{."1((gl_Translate 0 64 64)mp(glu_LookAt (}:E),0 0 0 0 0 1)mp(gl_Perspective 30 1 1 10))mp~T1XY,.1 NB. 320*(%"1>./)(-<./^:2)
 catch. return. end. 
)
win_grph_mbldown=: 3 : 'MXY=: 2{.".sysdata'
win_grph_mmove=: 3 : 0
 if. 4{D=. ".sysdata do. 
  'dx dy'=. *MXY-2{.D
  MXY=: 2{.D
  E=: (gl_Rotate dx,0 0 1) mp E
  NB. E=: 4 3${:(_1r360p1*+/&.:*:dx,dy) av dy roll dx pitch,:1,~,E
  glpaint''
 end.
)
ta=: 1 : 0
 T1PE=: TPE T1=. u T
 T1XY=: TP T1
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)