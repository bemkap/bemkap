NB. julia set

require'viewmat'

k   =: 0.001
int =: [ + k * i.@:<.@:(k %~ |@:-)  NB. int x y = intervalo [x,y) con espaciado k

c   =: _0.70176j_0.3842
NB. c   =: _0.835j_0.2321
NB. c   =: _0.74543j0.11301
z   =: +&c @: *:

limi=: 20 NB. limite iteraciones
limr=: 4  NB. limite radio
bien=: (limr>(*+) +: 128!:5)@:{: *. limi>{.  NB. bien x y = x<lim & y!=_ & y!=_.
step=: >:@:{. , z@:{:
juli=: [: {. step^:(bien :: 0:)^:_

HUE=: 10 10 ,"_ 0 <.(i. * 255&%) limi
NB. HUE viewmat | (juli@:(0&,))"0 j.~/~ _1.5 int 1.5