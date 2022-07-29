f=: [:;<@q:@:(!~i.@:>:)
gr=: ~.,:#/.~
M=: 1000000007
por=: M&|@*
pow=: M&|@^
mas=: M&|@+
i=: pow&(M-2)
sum=: ((_1 por/@:mas (pow >:)/)(por i)(_1 por/@:mas {.))