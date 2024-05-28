input=: cutLF(0 : 0)
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
)

input=: cutLF(0 : 0)
start-A
start-b
A-c
A-b
b-d
A-end
b-end
)

input=: 'b'fread'input12'

input=: '-'&splitstring&>input
nodes=: ~.,input
start=: nodes i. <'start'
end=: nodes i. <'end'
to=: ({."1</.{:"1) ix=: nodes i. (,|."1)input
T=: to(~. {."1 ix)}a:#~#nodes
lower=: I.(97*./@:<:a.&i.)&>nodes
next=: (3 : 0)^:(end~:{:)
 lav=. (#~e.&y)lower
 t=. lav-.~T{::~{:y
 y,"_ 0 t
)
solution1=: #([:~.[:;[:<"1&.>next&.>)^:_<start

max=: 1,:~1(lower i. start,end)}2#~#lower
next2=: (3 : 0)^:(end~:{:)
 lav=. lower#~(>:max{~2&e.)+/y=/lower
 t=. lav-.~T{::~{:y
 y,"_ 0 t
)
solution2=: #([:~.[:;[:<"1&.>next2&.>)^:_<start