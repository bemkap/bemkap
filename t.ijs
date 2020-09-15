P=: ;:'O C B E'
N=: 1;2;3;4;5;6;7;10;11;12
C=: ,{P,&<N
O=: 6 5 4 13 12 11 3 9 8 7 6 5 4 13 12 11 10 9 8 7 1 5 4 13 12 11 10 9 8 7 0 5 4 13 12 11 2 9 8 7

n_C =: C A.~ ?@:!@:(40x"_)
n_C2=: _3]\ 6{.n_C
n_C4=: _3]\12{.n_C
n_C6=: _3]\18{.n_C

env=: 3 : 0
 c=. (0 1,0 2,:1 2){y
 e=. =&{.&>/"1 c
 n=. (*10&>)&>{:&>c
 >./(20+e#+/"1 n),,n
)

gp=: ((100(%+/)"1@:?@:$~(15,#))&.>)@:(T"_)
P=: gp"0]0 0
rnd=: ?@:0:

S=: ;:'e ae nae ee aee naee eer aeer naeer eerf aeerf naeerf eef aeef naeef er aer naer erf aerf naerf ef aef naef r ar nar rf arf narf f af naf z'
T=: (S i. ;:)&.>'ae ee er ef nae';'';'';'aee eer eef naee';'';'';'aeer eerf naeer';'';'';'aeerf naeerf';'';'';'aeef naeef';'';'';'aer erf naer';'';'';'aerf naerf';'';'';'aef naef';'';'';'ar rf nar';'';'';'arf narf';'';'';'af naf';'';'';'e r f n';''

loop_e=: 4 : '(-.{.y),(T{::~{:y){~(+/\I.rnd)(({:y){::P{~{.y){~((7,20+i.14)I.env)({.y){x'
sim_e=: 3 : 0
 if. 34 e. r=. {:"1}.y loop_e^:(0(<#)T{::~{:@:])^:a: 0 _2 do.
  r=. 33,33<.{:"1}.y loop_e^:(0(<#)T{::~{:@:])^:a: 1 _2
 end.r
)
calc_e=: 4 : 0
 0,(2*w),1 0,0,(4*w),0 2,0,(7*w),4 0,0,f,0 7,0,f,4 0,0,(5*w),0 2,0,f,5 0,0,f,0 2,0,(5*w=. g y),1 0,0,f,0 3,0,(f=. x fp y),:1 0
)
g=: (1 0,:0 1){~<&env/
fp=: (30-|.@:[)*g@:]

play_e=: 3 : 0
 s=. sim_e h=. n_C2''
 c=. y calc_e h
 select. +/33=s
 case. 0 do. y=. y+  c{~{:s
 case. 1 do. y=. y+|.c{~{:s
 case. 2 do. y=. y
 end.
)

match=: play_e^:(30&(*./@:>))^:_