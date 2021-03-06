load'~temp/turtle/turtle_c.ijs'

S=: 80
Tfa=: 3{"1]
Txy1=: +.@:Txy

N=: 0 5 3 2 1,1 0 2 4 5,2 0 3 4 1,3 0 5 4 2,4 2 3 5 1,:5 0 1 4 3
C=: S*1j0 0j1 1j1 2j1 1j2 1j3
C3=: (1 A. 80,Txy1)`(0,Txy1)`(0,~Txy1)`(80,Txy1)`(1 A. 0,Txy1)`(80,~Txy1)@.{:

T=: T,.0
av0=: Tan,((r.{.)+Txy),Tpe,Tfa
av1=: (3})~N{~Tfa<@:,3 2 5 4 1 i. (_1,S)#.@:I.Txy1
av2=: Tan,(S j./@:| Txy1),Tpe,Tfa
av=: av2@:av1@:av0 ap

win_grph_paint=: 3 : 0
 try.
  NB. glrect"1 S,.~S,.~+.C
  gllines <.,TICS{.T1xy
  NB. gllines&>(1(_1})-.TICS{.T1pe) (<@:,@:<.);._2 TICS{.T1xy
 catch. return. end.
)
win_timer=: 3 : 0
 if. TICS<#T1xy do. glpaint TICS=: >:TICS else. wd'ptimer 0' end.
)
ta=: 1 : 0
 TICS=: 0
 NB. b=. -.(0,}.-:"1}:)}."1 T1=.;u&.><T
 NB. T1xy=: 10+300((%>./)*"1])(-"1<./)
 T1xy=: +.(Txy+C{~Tfa);u&.><T
 NB. T1pe=: b#Tpe"1 T1
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;ptimer ',(":y),';pshow;'
)