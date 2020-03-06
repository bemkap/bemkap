C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
door=: 1=(_1 0+C i. 'AZ')&I.
opos=: ($@:]#:((=,)i.1:))"0 _
I=: <27 opos M=: C i. >cutLF(0 : 0)
########################
#...............b.C.D.f#
#.######################
#.....@.a.B.c.d.A.e.F.g#
########################
)
N=: +/,key M
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(y free@:{~ <)"1)&.> co +"1&.> dco
)
expl=: ]~.@:,(<"1)@:>@:(,&.>/)@:{~
open=: [*(-.@:e.(,27&+))
TR0=: ~.@:,&.>/tr"2 M&open"0 >:i.26
aux=: 4 : 'TR0&expl&.>^:(y-.@:e.>)^:a:<x'
path=: [:,aux([{.@:-.-.)&,&>|.@:aux~
KTKM=: (<:@:#,_27+(#~door))@:(path&</@:opos{])&M L:0 {;~27,>:i.N
NB. KTKM=: ".fread'~temp/table18'
expl1=: 3 : 0
 mx=. >./"1>{.&.> KTKM{"1~y-.~i.{:$KTKM 
 n=. y-.~I.(y*./@:e.~}.)&>r=. KTKM{~{:y
 y ,"_ 0 n/:(n{mx)+{.&>n{r
)
step=: 3 : '<"1>,&.>/expl1&.>"0 y'
H=: >./"1{.&>KTKM
search=: 3 : 0
 g=. 0(0})_$~N+1
 f=. (>./{.&>0{KTKM)(0})_$~N+1
 p=. 0$~N+1
 s=. 0
 while. #s do.
  y=. {.s([-.-.)/:f
  k=. p{~^:(0<])^:a:y
  n=. k-.~I.(k*./@:e.~}.)&>y{KTKM
  t=. (y{g)+{.&>n{y{KTKM
  u=. t<:n{g
  p=. (u}y,:~n{p)n}p
  g=. g<.t(n})g
  f=. f<.(H+&(n&{)g)n}f
  s=. ~.(s-.y),u#n
 end.g
)

mat=: {.&> KTKM
tps=: 4 : 0
 if. 0=#y do. mat{~<x,0 return. end.
 c=. mat{~<"1 x,.y
 <./c+y tps"0 1]1]\.y
)