require'regex'
R =: '(\d+) units each with (\d+) hit points (\(.+\) )*'
R =: R,'with an attack that does (\d+) (.+) damage at initiative (\d+)'
rxget=: [: }. [: {. rxmatches rxfrom ]
T =: R rxget"1 'm' fread '~temp/input24.txt'
T =: T #~ (6#a:) -.@:-:"1 T
TY=: ;:'cold radiation slashing fire bludgeoning'
ti=: [: (#~ ~:&',') ';' taketo 'immune to ' takeafter ]
tw=: [: (#~ ~:&',') ';' taketo 'weak to ' takeafter ]
S =: (TY i. ;:) L: 0 (tw ; ti)@:(1 }. _2 }. ]) S: 0 ] 2 {"1 T
A =: <"0 TY i. 4{"1 T
T =: (2&{."1 ,. S ,. 3&{"1 ,. A ,. {:"1) T
T =: ".`]@.(2 4 i. 3!:0) L: 0 T
T =: ;(10 split T) ,.&.> (<0);<<1
NB.simulation
ep=: [: *&>/ 0 4&{       NB.effective power
hp=: [: *&>/ 0 1&{       NB.total hp
un=: 0&{:: [ ih=: 1&{::  NB.units/individual hp
wt=: 2&{:: [ it=: 3&{::  NB.weak to/immune to
po=: 4&{:: [ ty=: 5&{::  NB.attack power/initiative
in=: 6&{:: [ gr=: 7&{::  NB.initiative/group
NB.conditions
dg =: ~:&gr              NB.different group
da =: ep@:[              NB.damage
wm =: 1 + ty@:[ e. wt@:] NB.weak to multiplier
im =: ty@:[ -.@:e. it@:] NB.immune to multiplier
co =: im*wm*da*dg
atk=: ([: < 0 >. un@:] - co <.@:% ih@:])`0:`]}
NB.select phase. y: group table
sp=: 3 : 0
 TO=. <"1 ([: \:"2 (co , ep@:] , in@:])"1/)~ y NB.targets order
 I =. (0<co/@:({&y))"1 L: 0 (;/i.#TO) ,.&.> TO
 TO=. I #&.> TO                                NB.remove non damaging targets
 SO=. \: (ep , in)"1 y                         NB.select order
 SO /:~ (SO{TO) (] , ({::~ #) (-. {.@:, _1:) ])^:(#SO) 0$0
)
NB.attack phase. x: group target selection, y: group table
ap=: 4 : 'for_n. (#~ _1<{:"1)(,.{&x) \: in"1 y do. y=. (atk/ n{y) ({:n)} y end.y'
cl=: #~ (0 < un)"1                       NB.clean dead groups
nx=: [: cl (ap~ sp)                      NB.next generation
bi=: ] (<a:;4)}~ (* 0=gr"1) +&.> po"1@:] NB.boost immune