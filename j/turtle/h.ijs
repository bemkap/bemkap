load'~temp/turtle/turtle_c.ijs'
T=: 10 av 90 gi 310 av 90 gd T
OBJ=: ,:0 310 320 10
int=: (>:2{.])*./@:*.(<:2(}.+{.)])
av_t=: +./@:(+.@:Txy@:{:@:(1 av ])int"1[)
gi_t=: av_t 90&gi
gd_t=: av_t 90&gd
win_grph_paint=: 3 : 0
 try.
  glrect 0 0 320 320
  glrect"1 (0&{,(320-1&{+3&{),2&{,3&{)"1 OBJ
  gllines ,TICS{.({.,320-{:)"1 T1xy
 catch. return. end.
)
win_timer=: 3 : 0
 if. TICS<#T1xy do. glpaint'' else. wd'ptimer 0' end.
 TICS=: >:TICS
)
maze=: 3 : 0
 n=. Tan{:y
 e1=. 0 0 320 320 int~ +.@:Txy@:{:
 e2=. n~:Tan@:{:
 while. e1 y do.
  y=.  1&av^:(e1*.OBJ -.@:av_t ])^:_ y
  y=. 90&gi^:(e1*.OBJ -.@:gd_t ])^:_ y
  while. (e2*.e1)y do.
   y=.  1&av^:(e2*.e1*.OBJ     gd_t ])^:_ y
   y=. 90&gd^:(e2*.e1*.OBJ -.@:gd_t ])^:_ y
  end.
 end.
)
ta=: 1 : 0
 TICS=: 0
 T1xy=: <.+.Txy;u&.><T
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;ptimer ',(":y),';pshow;'
)