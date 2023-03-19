load'regex'
B=: cutLF(0 : 0)
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
)
R=: 'Blueprint \d+: Each ore robot costs (\d+) ore. Each clay robot costs (\d+) ore. Each obsidian robot costs (\d+) ore and (\d+) clay. Each geode robot costs (\d+) ore and (\d+) obsidian.'
lx=: rxmatch }.@:rxfrom ]

CFG=: R&lx&>B
I=: <"2(=i.4),~"1"2-(0 0;1 0;2 0;2 1;3 0;3 2)}&(4 4$0)"1".&>CFG

STTR=: <"0(#I)#<0 0 0 0 1 0 0 0

mat=: 0 1 2 3&{
rob=: 4 5 6 7&{
m4=: =i.4

step=: 4 : 0
 ok=. (#~_&>)t=. >.(rob y)>./@:%"1~x -&mat"1 y
 b=. m4#~_>t
 s=. ((mat"1 x)#~_>t)-~(mat y)+"1 ok*"0/rob y
 s ,"1 (({: y)+ok),.~b +"1 rob y
)

rs=: 4 : 0
 a=. x step&.> y
 b=. ~. <"1 ; a
 (#~24>:{:&>)b
)

xx=: |&.>{.I
yy=: ,&0&.>0{::STTR