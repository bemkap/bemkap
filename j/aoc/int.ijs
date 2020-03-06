INPUT=: 5 NB. 4 0 3 2 1 0
OP=: sum`mul`inp`out`jit`jif`lt`eq
IC=: 1 2 3 4 5 6 7 8
P=: ".}:fread'~temp/input.txt'
fr=: ({~ :: _:)"_ 0
rwi=: 4 : 0
 INPUT=: ({.,0:,}.)x
 (run bind y)^:(#x)''
 INPUT
)
run=: 3 : 0
 ip=. 0
 while. 1 do.
  op=. IC i. 10#.3}.(5#10)#:ip{y
  if. op=#IC do. break. end.
  'ip y'=. ip(OP@.op)y
 end.0
)
sum=: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2+/@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
mul=: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2*/@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
inp=: 4 : 0
 h=. {.INPUT
 INPUT=: }.INPUT
 (x+2);h(y{~>:x)}y
)
out=: 4 : 0
 mo=. 2-2{(5#10)#:x{y
 INPUT=: ({.INPUT),(y {~^:mo >:x),}.INPUT
 (x+2);y
)
jit=: 4 : 0
 mo=. 1-2 1{(5#10)#:x{y
 pa=. mo}y fr^:1 2 x+>:i.2
 y;~(0~:0{pa){(x+3),1{pa
)
jif=: 4 : 0
 mo=. 2-2 1{(5#10)#:x{y
 pa=. 0$0
 for_i. i.2 do. pa=. pa,y{~^:(i{mo)x+>:i end.
 if. 0=0{pa do. x=. _3+1{pa end.
 (x+3);y
)
lt =: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2</@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
eq =: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2=/@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
