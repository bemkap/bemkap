load'~temp/turtle/turtle_c.ijs gles'
coinsert'jgl2 jgles'

S=: 80
Tfa=: 3{"1]
Txy1=: +.@:Txy

N=: 0 5 3 2 1,1 0 2 4 5,2 0 3 4 1,3 0 5 4 2,4 2 3 5 1,:5 0 1 4 3
C3=: (1 A. 40,Txy1)`(_40,Txy1)`(_40,~Txy1)`(40,Txy1)`(1 A. _40,Txy1)`(40,~Txy1)@.{:

T=: T,.0
av0=: Tan,((r.{.)+Txy),Tpe,Tfa
av1=: (3})~N{~Tfa<@:,3 2 5 4 1 i. (_1,S)#.@:I.Txy1
av2=: Tan,(S j./@:| Txy1),Tpe,Tfa
av=: av2@:av1@:av0 ap

MXY=: R=: 0 0
TR=: =i.4
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. 
  gllines"1<.,"2]2{."1 (gl_Translate 160 160 0) mp~ C=: C mp TR
  gllines <.,2{."1 (gl_Translate 160 160 0) mp~ T1XY=: T1XY mp TR
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
 C=: (1 0 0,1 1 0,1 1 1,:1 0 1),(0 0 0,0 0 1,1 0 1,:1 0 0),:(0 1 0,0 1 1,1 1 1,:1 1 0)
 C=: (,{.)"2]1,."2~S*_0.5+(0 0 0,0 1 0,1 1 0,:1 0 0),(0 0 1,0 1 1,1 1 1,:1 0 1),(0 0 0,0 1 0,0 1 1,:0 0 1),C
 T1XY=: 1,.~C3"1 ;u&.><T
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)