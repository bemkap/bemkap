load'plot gl2 trig'
coinsert'jgl2'

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
ap=: 1 : '],(u{:)'
av=: (TV,((*TH)+TP),TPE)ap
ju=: (TV,((*TL)+TP),TPE)ap
jr=: (TV,((*TU)+TP),TPE)ap
sp=: (TV,TP,[)ap
pitch=: (([ rot TH,:TU),TL,([ rot TU,:-@:TH),TP,TPE)ap
roll =: (TH,([ rot TL,:TU),([ rot TU,:-@:TL),TP,TPE)ap
yaw  =: (([ rot TH,:TL),([ rot TL,:-@:TH),TU,TP,TPE)ap
E =: (=i.3),0 0 _1
pp=: ((}:@:]+/ .*"1(-{:))~)"_ 1
pr=: (2&{.*1%{:)"1@:pp
MXY=: 0 0
win_grph_paint=: 3 : 0
 try.
  glrect 0 0 320 320
  glclip 0 0 320 320
  gllines&>([:,[:(160 160+}:)"1[:<.E&pp)&.> (1(_1})-.T1PE) <;._2 T1XY
 catch. return. end. 
)
win_grph_mbldown=: 3 : 'MXY=: 2{.".sysdata'
win_grph_mmove=: 3 : 0
 if. 4{D=. ".sysdata do. 
  'dx dy'=. *MXY-2{.D
  MXY=: 2{.D
  E=: 4 3${:(_1r360p1*+/&.:*:dx,dy) av dy roll dx pitch,:1,~,E
  glpaint''
 end.
)
ta=: 1 : 0
 T1PE=: TPE T1=. u T
 T1XY=: 320*(%"1(>./-<./))TP T1
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)