load'gl2 gles'
coinsert'jgl2 jgles'

S=: 200
d2r=: *&1r180p1
Tan=: 0{"1]
Txy=: 1{"1]
Tpe=: 2{"1]
Tfa=: 3 4 5 6 7 8 9 10{"1]
Txy1=: +.@:Txy
mp=: +/ .*
T=: ,:0,(j.~-:S),1,i.8
VC2=: 2]\(,{.)S*0 0,0 1,1 1,:1 0
VC3=: 0 0 0,0 0 1,1 0 1,1 0 0,0 1 0,0 1 1,1 1 1,:1 1 0
LURDI=: 4 5 1 0 7 6 2 3,1 5 6 2 0 4 7 3,3 2 6 7 0 1 5 4,4 0 3 7 5 1 2 6,:0 1 2 3 4 5 6 7
chk=: 4 : 0
 pe=. _1 1*|.e=. ({:x)-a=. {.x
 pt=. _1 1*|.t=. ({:y)-p=. {.y
 mu=. (pe mp a-p)%pe mp t
 la=. (pt mp p-a)%pt mp e
 if. *./(0&<:*.1&>:)mu,la do. t,mu else. _ _ _1 end.
)
ap=: 1 : '],(u{:)'
switch=: (0,S)&i.{(S,0)&,
av=: (4 : 0)ap
 w=. <.0.5++.x((r.Tan)+Txy)y
 v=. (Tfa y){~LURDI{~i=. (1:i.~0<{:"1)j=. VC2 chk"2 (Txy1 y),:w
 if. -.v-:f=. _8{.y do.
  't mu'=. (2&{.;{:)i{j
  p=. (j./(Txy1 y)+t*mu)1}y
  p,(x*1-mu) av^:(1>mu) ,:(Tan y),(j./switch"0<.0.5+w-t*(1-mu)),(Tpe y),v
 else. (j./S|S+w)1}y end.
)
gi=: (((Tan-d2r@:[),Txy,Tpe,Tfa)ap) :. gd
gd=: (((Tan+d2r@:[),Txy,Tpe,Tfa)ap) :. gi
sh=: (d2r@:[(0})])ap
disp=: 4 : '(S*VC3{~0{y)++/x*-/"2 VC3{~(3 0,:1 0){y'
MXY=: RO=: 0 0
win_grph_paint=: 3 : 0
 glrect 0 0 320 320
 glclip 0 0 320 320
 try. 
  glrgba 0 0 0 32
  glpen 1
  gllines"1<.,"2]2(160 160+{.)"1 C mp TR
  glrgb 0 0 255
  glpen 2
  gllines <.,2(160 160+{.)"1 T1XY mp TR
 catch. return. end. 
)
win_grph_mmove=: 3 : 0
 if. 4{D=. ".sysdata do. 
  RO=: 2**MXY-2{.D
  MXY=: 2{.D
  glpaint TR=: TR mp (gl_Rotate (-{:RO),1 0 0) mp (gl_Rotate ({.RO),0 1 0)
 end.
)
NB. win_timer=: 3 : 'if. TICS<#T1XY do. glpaint TICS=: >:TICS else. wd''ptimer 0'' end.'
ta=: 1 : 0
 TR=: =i.4
 NB. TICS=: 0
 C=: (,{.)"2]1,."2~S*_0.5+6 4 3$,#:0 2 6 4 1 3 7 5 0 2 3 1 4 6 7 5 0 1 5 4 2 3 7 6
 T1XY=: 1,.~(-:S)-~(Txy1 disp"1 Tfa);u&.><T
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;pshow;'
)