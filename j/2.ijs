F=: ;:&>'b'fread'~temp/input2.txt'

O=: <"0((;:'on off')i.0&{)"1 F
C=: (".&>)&.> '..'&splitstring&.>3 7 11{"1 F

int=: 4 : 'if. <:/a=. x(>.&{.,<.&{:)y do. a else. 0$0 end.'
vol=: */"1@:(-~/&>)
comb=: 4 : '>(#~0<vol&>),{<"1&.>x((0 2,2 3,:3 1){,)&.>y'
union=: 4 : 0
 if. (<0$0)e.i=. x int&.> y do. x,:y else. x~.@:,&(comb&i)y end.
)
group=: 3 : 0
 r=. <{.y
 for_c. }.y do. r=. <"1;(c&union)"1&.>r end.
)