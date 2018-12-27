require'regex'
F =: 'm' fread '~temp/input24.txt'
R =: '(\d+) units each with (\d+) hit points (\(.+\) )*'
R =: R,'with an attack that does (\d+) (.+) damage at initiative (\d+)'
rxget=: [: }. [: {. rxmatches rxfrom ]
T =: R rxget"1 F
T =: T #~ (6#a:) -.@:-:"1 T
takefrom=: (#@:[ + E. i. 1:) }. ]
Ty=: ;:'cold radiation slashing fire bludgeoning'
ti=: [: (#~ ~:&',') [: ';'&taketo 'immune to '&takefrom
tw=: [: (#~ ~:&',') [: ';'&taketo 'weak to '&takefrom
S =: (Ty i. ;:) L: 0 (tw ; ti)@:(1 }. _2 }. ]) S: 0 ] 2 {"1 T
A =: <"0 Ty i. 4{"1 T
T =: (2&{."1 ,. S ,. 3&{"1 ,. A ,. {:"1) T
T =: (".`])@.(2 4 i. 3!:0) L: 0 T

Immune=: (10{.T),.<0
Infection=: (10}.T),.<1

ep=: [: *&>/ 0 4&{ NB. effective power
hp=: [: *&>/ 0 1&{ NB. hit points
wt=: 2&{::         NB. weak to
it=: 3&{::         NB. immune to
ty=: 5&{::         NB. attack type
in=: 6&{::         NB. initiative
gr=: 7&{::         NB. group

NB. conditions
dg=: ~:&gr            NB. different group
da=: ep@[             NB. damage
wm=: 2 * ty@[ e. wt@] NB. weak to multiplier
im=: ty@[ -.@e. it@]  NB. immune to multiplier
co=: im * wm * da * dg