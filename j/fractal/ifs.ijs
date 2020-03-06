require'gl2'
coinsert'jgl2'

NB. RECT = x y x_opuesto y_opuesto angulo
mp=: +/ .*

rtop=: 3 : 0
 p=. (0 1,2 1,2 3,:0 3){y
 m=. (+/%2:) 0 2{p
 ,m +"1 (4{y) rotate p -"1 m
)

A=: 1,.~_2 ]\ rtop 50 50 200 200 0
IA=: %. A

IFS=: 0 : 0
 pc win closeok;pn "ifs";
 minwh 300 380;cc ifs isigraph;
)

win_run=: 3 : 0
 P=: 0
 T=: 0 5$0
 I=: 0
 wd IFS
 wd'pshow'
)

win_ifs_paint=: 3 : 0
 glrgb 0 0 0
 glpen 2
 glrect 0 0 300 300
 glrect 50 50 200 200
 glfont'Courier 8'
 gltextxy 4 304
 gltext'SHIFT      translate'
 gltextxy 4 316
 gltext'CTRL       scale'
 gltextxy 4 328
 gltext'MWHEEL     rotate'
 gltextxy 4 340
 gltext'CTRL+SHIFT remove'
 gltextxy 4 352
 gltext'1-9        select'
 gltextxy 4 364
 gltext'NO KEY     create'
 select. P
 case. 1 do.
   glrect xy,cu-xy
 case. 2 do.
   dv=. cu-xy
   T=: (({:,~dv,@:(+"1)_2]\}:) I{T) I} T
   xy=: cu
 case. 3 do.
   i=. <0 1;~I
   dv=. cu-xy
   T=: T i}~ dv+i{T
   xy=: cu
 end.
 glrgb 170 170 170
 glpen 2
 (glpolygon@rtop)"1 T
 if. #T do. 
  F=. (IA mp 1,.~_2&(]\)@:rtop)"1 T
  gpolygon"1 ,"2 }:"1 F ,/@:(mp"2/~)^:5 ,:A
  glrgb 255 0 0
  glpen 2
  glpolygon@rtop I{T
 end.
)

win_ifs_mbldown=: 3 : 0
 P=: >:#.6 7{".sysdata
 if. 4=P do.
  T=: (I&{.,(I+1)&}.) T
 end.
 xy=: cu
 glpaint''
)

win_ifs_char=: 3 : 0
 I=: 0>.<:0".sysdata
 glpaint''
)

win_ifs_mwheel=: 3 : 0
 i=. <4,~I
 d=. 1r90p1**_1{".sysdata
 T=: (d+i{T) i} T
 glpaint''
)

win_ifs_mblup=: 3 : 0
 if. 1=P do. T=: T,xy,cu,0 end.
 P=: 0
 glpaint''
)

win_ifs_mmove=: 3 : 0
 cu=: 2{.".sysdata
 glpaint''
)

win_run''