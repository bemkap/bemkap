A=: (1,.2#:@:i.@:^])&.>i.13
N=: 4}.i.1000001
f=: 3 : 0
 a=. A{::~<:#n=. 10#.inv *:y
 t=. 10>.@^.y
 b=. y e. +/@:(10&#.;.1&n)"1 (#~t&([:+./((t#0)&-:)\)"1) a
 NB. if. b<#a do. <b{a else. a: end.
)