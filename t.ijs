load'stats'
P=: ;:'O C B E'
N=: ;/1 2 3 4 5 6 7 10 11 12
C=: ,{P,&<N
n_C2=: C{~_3]\6?40"_
env=: 3 : 0
 c=. (0 1,0 2,:1 2){y
 e=. =&{.&>/"1 c
 n=. (*10&>)&>{:&>c
 >./(20+e#+/"1 n),,n
)
S=: ;:'e ae nae ee aee naee eer aeer naeer eerf aeerf naeerf eef aeef naeef er aer naer erf aerf naerf ef aef naef r ar nar rf arf narf f af naf z n'
T=: (S e. ;:)&>'ae ee er ef nae';'';'';'aee eer eef naee';'';'';'aeer eerf naeer';'';'';'aeerf naeerf';'';'';'aeef naeef';'';'';'aer erf naer';'';'';'aerf naerf';'';'';'aef naef';'';'';'ar rf nar';'';'';'arf narf';'';'';'af naf';'';'';'e r f n';''
gp=: 3 : '(%"1+/)"2(*100?@:$~15,~$)T'
dp=: 3 : '(*0(0.2*_0.5+?)@:$~15,~$)T'
np=: (%"1+/)"2@:((0>.+)dp)@:{
rnd=: ?@:0:
ix=: (7,20+i.14)I.env
loop=: 4 : '(-.{.y),((+/\I.rnd)(<a:;y{~2+{.y){(<2{.y){x),2}.y'
sim=: 4 : 0
 r=. 1&{"1}.x&loop^:(T+./@:{~1&{)^:a: 0 _2,ix"1 y
 if. 34 e. r do. r=. 33,33<.1&{"1}.x&loop^:(T+./@:{~1&{)^:a: 1 _2,ix"1 y end.r
)
calc=: 4 : 0
 f=. (30-|.x)*y
 r=. f(10 13 19 22 28 31)}33 2$0
 r=. (2 4 7 5 5*/y)(1 4 7 16 25)}r
 (1 0,0 2,4 0,0 7,4 0,0 2,5 0,0 1,1 0,0 3,:1 0)(2 5 8 11 14 17 20 23 26 29 32)}r
)
play=: 4 : 0
 s=. x sim h=. n_C2''
 c=. y calc (1 0,:0 1){~<&env/h
 if. 0 1 e.~ z=. +/33=s do. y=. y+|.^:z c{~{:s end.y
)
match=: 4 : 0
 x0=. x
 while. *./30>y do.
  y=. x play |.y
  x=. |.x
 end.y{~x0 i. x
)
evolve=: 4 : 0
 for_i. i.y do.
  smoutput 'round ',":i
  x=. x{~(<.-:l){.\:(2*#)/.~/:~c{~"1 0</@:(match&0 0)"_1 x{~c=. 2 comb l=. #x
  x=. (,(%"1+/)"2@:((0>.+)dp)"3)x
 end.0
)
saveP=: fwrite~ ":@:,@:({&PL)
loadP=: 35 35 15$".@:fread
