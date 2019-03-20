require'regex'
cm=: ;:'av gd gi rp'
st=: _1 0 0 0j0 0 NB. cmd counter pc position angle

av=: 0 0} ]
gd=: 1 0} ]
gi=: 2 0} ]
rp=: 3 0} ]

AV=: ]+0 0 0,0,~(r.{:)
GD=: (-0 0 0 0&,)~
GI=: (+0 0 0 0&,)~
RP=: 2}
CM=: AV`GD`GI`RP
NU=: CM@.(0{])

fa=. 3 : '{.(":y)&NU`'''''

y =: 'av 10 gd 45 rp 5 [av 10 rp 2 [gi 45 av 5] gi 90] av 20'