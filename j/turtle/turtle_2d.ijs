load'plot gl2'
coinsert'jgl2'

T =: ,:1r2p1 0 1
d2r=: *&1r180p1
Tan=: 0{"1]
Txy=: 1{"1]
Tpe=: 2{"1]
sym=: 360&((*%+.)%])
ap=: 1 : '],(u{:)'
av=: (Tan,((r.{.)+Txy),Tpe)ap
gi=: (((Tan-d2r@:[),Txy,Tpe)ap) :. gd
gd=: (((Tan+d2r@:[),Txy,Tpe)ap) :. gi
sp=: (Tan,Txy,[)ap
sh=: (d2r@:[(0})])ap
convert=: 3 : '(<"1@:|:@:+.@:(Txy"1))&>(#~0<#&>)({.,}.&.>@:}.)(</.~+/\@:-.@:({:"1))y'
tp=: 3 : 0
 pd'reset;labels 0 0;frame 0;grids 0 0;tics 0 0'
 pd'color black'
 pd"1 ;,&.>/convert&.>y
 pd'show'
)
win_grph_paint=: 3 : 0
 try.
  glrect 0 0 320 320
  gllines&>(1(_1})-.TICS{.T1pe) (<@:,@:<.);._2 TICS{.T1xy
 catch. return. end.
)
win_timer=: 3 : 'if. TICS<:#T1XY do. glpaint TICS=: >:TICS' else. wd''ptimer 0'' end.'
ta=: 1 : 0
 TICS=: 0
 b=. -.(0,}.-:"1}:)}."1 T1=.;u&.><T
 T1xy=: 10+300((%>./)*"1])(-"1<./)+.b#Txy"1 T1
 T1pe=: b#Tpe"1 T1
 wd 'pc win closeok;minwh 320 320;cc grph isigraph;ptimer ',(":y),';pshow;'
)