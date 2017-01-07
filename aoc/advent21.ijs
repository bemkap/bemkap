require'regex'
sp =: (C.~ <) :. (C.~ <)                         NB. swap position
sl =: ([ sp i.) :. ([ sp i.)                     NB. swap letters
ro =: (|.~) :. (|.~ -)                           NB. rotate
rl1=: [ ro (<:@- - 4&<:)@i.
P  =: 1 1 _2 2 _1 3 0 4
rl2=: [ |.~ P{~i.
rl =: rl1 :. rl2                                 NB. rotate based on letter
rp1=: |.@:{`[`]}~ ([ + i.@>:@-~)/
rp =: rp1 :. rp1                                 NB. reverse by position
mp1=: C.~ (<./ <@:+ i.@:(+ *)@:-~/) 
mp =: mp0 :. (mp0 |.)                            NB. move to position

rpe=: mpe=: spe=: ". S: 0
sle=: rle=: ;
roe=: ".@(1&{::)*1+_2*'right'-:0&{::

F=: 'b' fread jpath './input.txt'
S=: 'fbgdceah' NB.'abcdefgh'
R=:    'swap position (\d+) with position (\d+)'
R=: R;~'swap letter ([a-z]) with letter ([a-z])'
R=: R;~'rotate (right|left) (\d+) steps?'
R=: R;~'rotate based on position of letter ([a-z])'
R=: R;~'reverse positions (\d+) through (\d+)'
R=: R;~'move position (\d+) to position (\d+)'
n=: 4 : 0
I=. I. (0 = x&(rxindex~) S: 0) R
g=. mpe`rpe`rle`roe`sle`spe@.I
A=. g }.{. (I{::R) (rxmatches rxfrom ]) x
f=. mp`rp`rl`ro`sl`sp@.I
y f inv A
)