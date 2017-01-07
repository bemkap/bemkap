comb=: 4 : 0
 k=. i.>:d=.y-x
 z=. (d$<i.0 0),<i.1 0
 for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
 ; z
)

M=: ,:0 0 0 1 2 1 2 1 2 1 2 0 0 0 0 NB. configuration
L=: <:#{.M
G=: (>:L)$3 NB. goal
C=: (3 : '1 y} L$0')"1 ] 2 comb L NB. combination 2 up
C=: ((_1,.-),(1&,.)) C NB. floor number,2 down
C=: ((,-)1,.=i.L),C NB. 1 up,1 down

al2=: #~ (1<|@(+/))"1 NB. sum at least 2
a  =: ([:~.[:;<@(+"1[:al2[:~.C*"1(={.))"1) NB. apply all posible movements

Ge=: i.&.-:L
Ch=: >:Ge

gnc =: _2&(=/\) NB. generator and chip
ngnc=: *./@(Ge&{ ~:/ Ch&{) NB. not generator and chip
pf  =: *./@(>:&0 *. <:&3) NB. posible floor
ec  =: #~([:~:([:/:~_2&(4&#.\))&.|."1) NB. equivalence class
good=: [:*./(gnc+.ngnc)@}.*.pf NB. good
next=: ~.@:(#~ good"1)@:a

s=: 3 : 0
 Mv=. Mc=. M
 i =. 0
 while. -.G e. Mc do.
   Mv=. Mv,Mc=. Mv -.~ ec@:next Mc
   smoutput i =.>:i
 end.
)