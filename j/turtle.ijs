require'regex plot'
r=: '((?:av|gi|gd) (?:\d+|cnt))|(rp (?:\d+|cnt) \[.*\])'
s=: '(rp) (\d+|cnt) (\[.*\])'
t=: '(?:av|gi|gd) (?:\d+|cnt)'

lxmatch=: rxmatch }.@:rxfrom ]

ir=: s&rxeq NB. is rp regex
io=: t&rxeq NB. is other regex
mt=: r&rxall NB. match regex r
br=: '[]'-:0 _1&{ NB. is between brackets
to=: ;:^:io L:0 NB. command;argument for av,gi and gd
nu=: ".^:(''-.@:-:".) L:0 NB. convert arguments
NB. first mt -> (mt inside brackets increasing depth)^:_ -> convert arguments
lx=: [:nu[:to[:([:(mt@:}.@:}:)^:br L:0 s&lxmatch^:ir L:0)^:_ mt

co=: ;:'av gd gi rp' NB. commands
ap=: 1 : '],((0{::[)u{:@:])'
av=: (]+0,~(r.(1r180p1*{:))) ap NB. forward
gi=: (]+0,[) ap NB. turn left
gd=: (]-0,[) ap NB. turn right
ic=: 'cnt'&-: NB. is count
rp=: 4 : 'for_i. i.0{::x do. y=. y ex~ (i"_)^:ic L:0 ] 1{::x end.' NB. repeat
ex=: 4 : 'for_c. x do. y=. (}.>c) av`gd`gi`rp@.(co i. {.>c)y end.' NB. execute

T =: ,:0j0 0 NB. turtle

run=: T&$: :(ex~ lx)
plt=: [:plot[:<"1+.@:{.&.|: