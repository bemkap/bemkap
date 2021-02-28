require 'viewmat'

NB. 1d automata

NB. reglas
r110=: 0 1 1 1 0 1 1 0
r90 =: 0 1 0 1 1 0 1 0
r30 =: 0 1 1 1 1 0 0 0
rg  =: (8#2)&#:
rnd =: 8 {. #: ? 256

NB. hay que hacer load para que se cambie la regla
rule=: {& rnd @#.

next    =: 3 rule\ 0 , 0 ,~ ]
gen     =: next^:(<@[) ]
automata=: 64 gen [: ? 64 $ 2:
