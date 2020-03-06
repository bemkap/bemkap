require'gl2'
coinsert'jgl2'

MAX=: -256 #. 255 255 255

NB. ----- util -----

scale=: [ #"1 # 
bord1=: 0 ,~ 0 , 0 ,. 0 ,.~ ]
bord2=: ({: , [ , {.)"1@:({: , [ , {.)
cnt=: +/@:=

NB. neighbourhood selectors
c=: (<1 1)&{             NB. center
s=: (0 2;2 2;2 0;0 0)&{  NB. square

nn=: (0 1;1 2;2 1;1 0)&{  NB. von neumann
nm=: nn ,@,. s            NB. moore

rule1=: +/@nm % 8:

NB. ----- config -----

RULE =: rule1
STATE=: 64

NB. ----- prog -----

next=: (1 1,: 3 3) RULE;._3 bord2

M=: 64 (5 25;6 25;6 26)} 50 50 $ 0

AUT=: 0 : 0
pc autwin owner;
minwh 400 400;cc g isidraw flush;
pas 0 0;
)

autwin=: 3 : 0
wd AUT
wd'ptimer 100'
wd'pshow'
)

autupdate=: 3 : 0
wd'psel autwin'
glfill 255 255 255
glpixels 0 0 400 400,,8 scale M*MAX%STATE
M=: next M
glpaintx''
)

autwin_timer=: autupdate

autwin_close=: wd bind 'ptimer 0;pclose'

autwin''