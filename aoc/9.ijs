input=: cutLF(0 : 0)
2199943210
3987894921
9856789892
8767896789
9899965678
)

input=: 'b'fread'input9'

input=: "."0&>input
check=: (<1 1)&{ *./@:< (0 1;1 0;1 2;2 1)&{
solution1=: +/,(>:input)*t=: (1 1,:3 3) check;._3 ] _,_,~_,._,.~input

transitions=: ,(1 1,:3 3) ([:<[:(#~_&>)(0 1;1 0;1 2;2 1)&{);._3 ] _,_,~_,._,.~i.$input

input=: ,input
state=: <"0 I.,t

expand1=: 3 : 0
 a=. input{~n=. >y{transitions
 n#~a>y{input
)
expand=: <"0@:;@:(expand1&.>)
count=: {{+/9>input{~;(~.@:,expand)^:_ y}}
solution2=: */3{.\:~count"0 state