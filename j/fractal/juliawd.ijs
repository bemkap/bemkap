load 'gl2 numeric'
coinsert 'jgl2'

SIZE =: 300
COOR =: x: _1.5 _1.5 3
BLACK=: -256#.255 255 255
LI   =: 127x
LR   =: *:2x
nrange=: 3 : 0
'x y n'=. y
m=. (y-x)%n
range (x+m),y,m
)
ms=: +/@:*:@:+.
sc=: [ #"1 #
step=: 3 : 0
w=. ".equ
if. ((128!:5 +: LR<ms) w) *. y<LI do.
  z=: w
  >:y
else. 
  y
end.
)
juli=: 3 : 'step^:_ [ 0 [ z=: y'
JULIA=: 0 : 0
pc win closeok;pn "julia";
bin vh;
cc sequ static;set sequ text f(z)=;
cc equ edit;set equ text _0.835j_0.2321 + *: z;
cc view button;
bin z;
cc grph isigraph;
)
win_run=: 3 : 0
data=: ''
xy=: 0 0
zoom=: 1
wd JULIA
wd 'pshow'
)
win_grph_paint=: 3 : 0
if. #data do. glpixels 0 0,SIZE,SIZE,,data end.
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
xr=. nrange (0{COOR),(+/0 2{COOR),300
yr=: nrange (1{COOR),(+/1 2{COOR),300
data=: (256#.0 0 127)+BLACK+(256#.2 0 0)*juli"0 yr j./ xr
)
win_grph_mbldown=: 3 : 0
COOR=: COOR*1 1 0.5
COOR=: (xy--:2{COOR),2{COOR
zoom=: +: zoom
calc''
glpaint''
)
win_grph_mmove=: 3 : 0
xy=: (2{.COOR)+(2{COOR)*SIZE%~2{.".sysdata
glpaint''
)
win_view_button=: 3 : 0
calc''
glpaint''
)
win_run''