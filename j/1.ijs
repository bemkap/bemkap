load'trig stats'

F=: 'b'fread'~temp/input.txt'
P=: ".&>&.>(('___'-:3&{.)&><@:}:;._1])F

rx=: (1 0 0),(0,cos,-@sin),:(0,sin,cos)
ry=: (cos,0:,sin),(0 1 0)"_,:(-@sin,0:,cos)
rz=: (cos,-@sin,0:),(sin,cos,0:),:(0 0 1)"_
mp=: +/ .*
R =: ~.>([:,/mp"2/)&.>/0.5&(<.@:+)&.>(rx"0;ry"0;rz"0)0 1r2p1 1p1 3r2p1

pair=: 3 : 0
 b=. {<"2&.>-"1/~&.>y
 c=. 1 i.~"1 ((6<:+/@:e."2)R|:"2@:(mp|:)])&>/&>b
 (($#:I.@:,)c<24);<./,c
)

NB. N=: pair"1 P{~C=: 2 comb #P

tsum=: 4 : 'if. +./_=x,y do. _ else. (R i. mp"2/~R){~<x,y end.'
tinv=: 3 : 'if. y=_ do. _ else. 0 i.~ y{(R i. mp"2/~R) end.'

reduce=: 3 : 0
 t=. (<0 2$0)~:{."1 y
 y=. t#y
 c=. t#C
 m=. 0 3$0
 for_i. i.#c do.
  'a b'=. i{c
  m=. m,(({.{.0{::i{y){a{::P)-((1{::i{y){R)mp({:{.0{::i{y){b{::P  
 end.
 M=. m(<"1 c)}39 39 3$0
 O=. (1 {::"1 y)(<"1 c)}_ 0{~=i.39
)

NB. solution=: (#;P)-+/<:#&>reduce N