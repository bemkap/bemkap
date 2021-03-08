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
MXY=: R=: 0 0
TR=: =i.4
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. gllines <.,2{."1 (gl_Translate 160 160 0) mp~ T1XY=: T1XY mp TR
 catch. return. end. 
)
win_grph_mmove=: 3 : 0
 if. 4{D=. ".sysdata do. 
  R=: 3**MXY-2{.D
  MXY=: 2{.D
  glpaint TR=: (gl_Rotate (-{:R),1 0 0) mp (gl_Rotate ({.R),0 1 0)
 end.
)
ta=: 1 : 0
 T1PE=: TPE T1=. u T
 T1XY=: 1,.~TP T1
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)