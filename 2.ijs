F=: ;:&>'b'fread'~temp/input2.txt'

O=: <"0((;:'on off')i.0&{)"1 F
C=: (".&>)&.> '..'&splitstring&.>3 7 11{"1 F
G=: (1,2~:/\O) <;.1 C

int=: 4 : 'if. <:/a=. x(>.&{.,<.&{:)y do. a else. 0$0 end.'
intp=: (<0$0)-.@:e.int&.>
vol=: */"1@:(-~/&>)
comb=: 4 : '>(#~0<vol&>),{<"1&.>x((0 2,2 3,:3 1){,)&.>y'
union=: 4 : 0
 if. (<0$0)e.i=. x int&.> y do. x,:y else. x~.@:,&(comb&i)y end.
)
group=: 3 : 0
 r=. ,:{.y
 for_c. }.y do.
  if. (#r)>i=. 1 i.~ c&intp"1 r do.
   u=. c union i{r
   r=. (i{.r),u,(r}.~>:i)
  else. r=. c,r end.
 end.
)
reduce=: 3 : '*./"1(0 2 3 1-:/:)@:,&>"1/~y'