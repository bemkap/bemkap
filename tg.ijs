require'regex'
y=: 'av 10 gd 45 rp 5 [av 10 rp 2 [gi 45 av 5] gi 90] av 20'
w=: 'av 10 gd 90 av 10 gd 90 av 10 gd 90 av 10'
r=: '(av \d+)|(gd \d+)|(gi \d+)|(rp \d+)|(?:\[(.*)\])'

br=: '[]'-:{.,{:
mt=: r rxall }.@:}:
to=: ((,".&.>)/@:;:)L:0
lx=: [:to[:]`mt@.br L:0^:_ r&rxall

NB. mf =:  : '{.u&n`'''''
cm=: ;:'av gd gi rp'
T =: <0j0 0
av=: ]+(0,~(r.{:))
gd=: (0,[)-]
gi=: (0,[)+]
NB. rp =: ^:
NB. NB. sm =: (av mf@:arg)`(gd mf@:arg)`(gi mf@:arg)`rp@.(cm i. {.)

ex=: 4 : '(1{::x) av`gd`gi@.(cm i. 0{x) y'

NB. br=: '[]'-:{.,{:
NB. mt=: r&(}."2@:rxmatches rxfrom ])
NB. lx=: [:".L:0[:]`mt@.br L:0^:_ mt