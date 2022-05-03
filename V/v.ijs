F=: 'b'fread'may'
CL=: 'b'fread'CL'
V=: 120
prop=: ".&>{.F
cls=: F{~+:i.-:#F=: }.F
pag=: ".&.>F{~>:+:i.-:#F
MAT=: (;pag)(<"1;(,.~&.>i.@#)CL&i.&.>;:&.>cls)}0$~cls,&#CL
dia=: +/"1 MAT
ord=: ,./_9]\({&CL(,.<"0){&t)\:t=. +/MAT
pord=: ,./_9]\({&CL(,.<"0){&t)\:t=. 100%~0.5<.@+10000*(%+/)+/MAT
prom=: prop(+/@:]%({~#))dia
proj=: prom*{:prop