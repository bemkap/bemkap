INPUT=: 5 NB. 4 0 3 2 1 0
OP=: end`sum`mul`inp`out`jit`jif`lt`eq
IC=: 99 1 2 3 4 5 6 7 8
P=: ".}:fread'~temp/input.txt'
fr=: ({~ :: _:)"_ 0
rwi=: 4 : 0
 INPUT=: ({.,0:,}.)x
 (run bind y)^:(#x)''
 INPUT
)
run=: 3 : '0: OP@.(IC i. _2&{.&.(10&#.inv)@:{)&>/^:((<#)&>/)^:_]0;y'
end=: #@:];]
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
 mo=. 1-2 1{(5#10)#:x{y
 pa=. mo}y fr^:1 2 x+>:i.2
 y;~(0=0{pa){(x+3),1{pa
)
lt =: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2</@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
eq =: 4 : 0
 mo=. 1 1 0-2 1 0{(5#10)#:x{y
 (x+4);y (2=/@:{.])`(2{])`[} mo}y fr^:1 2 x+>:i.3
)
