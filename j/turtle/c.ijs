load'~temp/turtle/turtle_c.ijs gles'
coinsert'jgl2 jgles'

S=: 80
Tfa=: 3 4 5 6 7 8 9 10{"1]
Txy1=: +.@:Txy
mp=: +/ .*
perp=: _1 1*|.
VC=: S*0 0,0 1,1 1,:1 0
I=: 0 1 2 3 4 5 6 7
U=: 1 5 6 2 0 4 7 3
D=: 4 0 3 7 5 1 2 6
R=: 3 2 6 7 0 1 5 4
L=: 4 5 1 0 7 6 2 3
chk=: 4 : 0
 e=. ({:x)-a=. {.x
 t=. ({:y)-p=. {.y
 mu=. ((perp e) mp a-p)%(perp e) mp t
 la=. ((perp t) mp p-a)%(perp t) mp e
 if. *./(0&<:*.1&>:)mu,la do. p+t*mu else. _ _ end.
)
T=: T,"1]i.8
av=: (4 : 0)ap
 x=. +.x((r.Tan)+Txy)y
 v=. (Tfa y){~(L,R,D,U,:I){~7 1 5 3 4 i. 3#.(S,0)I.<.0.5+x
 if. -.v-:f=. _8{.y do.
  y=. y(1})~j./(f line v) chk (Txy1 y),:x
  y,:v,~_8}.(j./S|x)(1})y
 else.
  (j./x)1}y
 end.
)
gi=: (((Tan-d2r@:[),Txy,Tpe,Tfa)ap) :. gd
gd=: (((Tan+d2r@:[),Txy,Tpe,Tfa)ap) :. gi
line=: VC{~(2]\0 1 2 3 0){~(L,U,R,:D)i.{inv
MXY=: R=: 0 0
TR=: =i.4
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. 
  gllines"1<.,"2]2(160 160+{.)"1 C=: C mp TR
  NB. gllines <.,2(160 160+{.)"1 T1XY=: T1XY mp TR
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
 NB. T1XY=: 1,.~Txy1 T1=: ;u&.><T
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)