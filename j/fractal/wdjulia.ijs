load'gl2 numeric'
coinsert'jgl2'

SIZE =: 300
COOR =: _3r2 _3r2 3
BLACK=: RGBA 0 0 0 255
LI   =: 256x
LR   =: *:2x
data =: ''
xy   =: 0 0
zoom =: 1

nrange=: 3 : 0
 'x y n'=. y
 range (x+m),y,m=. (y-x)%n
)
ms=: +/@:*:@:+.
sc=: [ #"1 #
step=: 3 : 0
 if. p=. (y<LI)*.(128!:5+:LR<ms)w=. ".equ do. z=: w end.
 >:^:p y
)
juli=: 3 : 'step^:_ 0: z=: y'
JULIA=: 0 : 0
 pc win closeok;pn "julia";
 bin vh;
 cc sequ static;set sequ text f(z)=;
 cc equ edit;set equ text _0.835j_0.2321 + *: z;
 cc view button;
 bin z;
 minwh 300 300;cc grph isigraph;
 pshow;
)
win_grph_paint=: 3 : 0
 if. #data do. glpixels 0 0,SIZE,SIZE,,2 sc data end.
 glrgb 0 0 0
 glpen 2
 glrect 0 0,SIZE,SIZE
 glrgb 255 255 255
 gltextcolor ''
 gltextxy 8 8
 gltext '(x,y) = ',":xy
 gltextxy 9 24
 gltext 'zoom = x',":zoom
)
calc=: 3 : 0
 xr=. nrange (0{COOR),(+/0 2{COOR),150
 yr=. nrange (1{COOR),(+/1 2{COOR),150
 data=: BLACK+(256#.4 0 0)*yr juli@j./ xr
)
win_grph_mbldown=: 3 : 0
 COOR=: (xy--:2{COOR),2{COOR*1 1 0.5
 zoom=: +: zoom
 glpaint calc''
)
win_grph_mmove=: 3 : 'glpaint xy=: (2{.COOR)+(2{COOR)*SIZE%~2{.".sysdata'
win_view_button=: glpaint@:calc
wd JULIA