C=: '.abcdefghijklmnopqrstuvwxyz@ABCDEFGHIJKLMNOPQRSTUVWXYZ#'
free=: (C i. 'A')&>
key=: 1=(_1 0+C i. 'az')&I.
door=: 1=(_1 0+C i. 'AZ')&I.
opos=: ($@:]#:((=,)i.1:))"0 _
I=: <27 opos M=: C i. >cutLF(0 : 0)
#################
#i.G..c...e..H.p#
########.########
#j.A..b...f..D.o#
########@########
#k.E..a...g..B.n#
########.########
#l.F..d...h..C.m#
#################
)
N=: +/,key M
tr=: 3 : 0
 co =. {;&i./d=. $y
 dco=. (<0 2$0)([,.~[,.[,],[)(<1 0,_1 0,0 1,:0 _1)$~_2+d
 (#~(y free@:{~ <)"1)L:0 co +"1&.> dco
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
solve=: 3 : 0
 f =. 0(0})_$~N+1
 nb=. c-.~I.(c*./@:e.~}.)&>r=. KTKM{~{:c=. >{.y
 t =. (g{~{:c)+{.&>nb{r
 

 L=. 0:min=. _
 PLEN=. {.&>KTKM
 while. #y do.
  while. -.(N<:<:#>{.y)+.min<{.L do.
   Lf=. PLEN{~_2&{.&.>f=. step {.y
   L =. (}.,~Lf+{.)L
   y =. f,}.y
  end.
  min=. min<.{.L
  L=. }.L
  y=. }.y
 end.min
)