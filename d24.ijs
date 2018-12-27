NB. require'regex'
NB. F =: 'm' fread '~temp/input24.txt'
NB. R =: '(\d+) units each with (\d+) hit points (\(.+\) )*'
NB. R =: R,'with an attack that does (\d+) (.+) damage at initiative (\d+)'
NB. rxget=: [: }. [: {. rxmatches rxfrom ]
NB. T =: R rxget"1 F
NB. T =: T #~ (6#a:) -.@:-:"1 T
NB. takefrom=: (#@:[ + E. i. 1:) }. ]
NB. Ty=: ;:'cold radiation slashing fire bludgeoning'
NB. ti=: [: (#~ ~:&',') [: ';'&taketo 'immune to '&takefrom
NB. tw=: [: (#~ ~:&',') [: ';'&taketo 'weak to '&takefrom
NB. S =: (Ty i. ;:) L: 0 (tw ; ti)@:(1 }. _2 }. ]) S: 0 ] 2 {"1 T
NB. A =: <"0 Ty i. 4{"1 T
NB. T =: (2&{."1 ,. S ,. 3&{"1 ,. A ,. {:"1) T
NB. T =: (".`])@.(2 4 i. 3!:0) L: 0 T

T1=: ". S: 0 cutLF (0 : 0)
17  ;5390;1 4;'';4507;3;2
989 ;1274;4 2;3 ;25  ;2;3
801 ;4706;1  ;'';116 ;4;1
4485;2961;3 0;1 ;12  ;2;4
)

T2=: ". S: 0 cutLF (0 : 0)
228 ;8064 ;0  ;''   ;331 ;0;8 
284 ;5218 ;1  ;2 3  ;160 ;1;10
351 ;4273 ;'' ;1    ;93  ;4;2 
2693;9419 ;4  ;1    ;30  ;0;17
3079;4357 ;1 0;''   ;13  ;1;1 
906 ;12842;'' ;3    ;100 ;3;6 
3356;9173 ;4  ;3    ;24  ;1;9 
61  ;9474 ;'' ;''   ;1488;4;11
1598;10393;3  ;''   ;61  ;0;20
5022;6659 ;'' ;4 3 0;12  ;1;15
120 ;14560;1 4;0    ;241 ;1;18
8023;19573;0 2;4 1  ;4   ;4;4 
3259;24366;0  ;2 1 4;13  ;2;16
4158;13287;'' ;''   ;6   ;3;12
255 ;26550;'' ;''   ;167 ;4;5 
5559;21287;'' ;''   ;5   ;2;13
2868;69207;4  ;3    ;33  ;0;14
232 ;41823;'' ;4    ;359 ;4;3 
729 ;41762;4 3;''   ;109 ;3;7 
3690;36699;'' ;''   ;17  ;2;19
)

Immune=: (2{.T1),.<0
Infection=: (2}.T1),.<1

ep=: [: *&>/ 0 4&{ NB. effective power
hp=: [: *&>/ 0 1&{ NB. hit points
un=: 0&{::         NB. units
ih=: 1&{::         NB. individual hp
wt=: 2&{::         NB. weak to
it=: 3&{::         NB. immune to
ty=: 5&{::         NB. attack type
in=: 6&{::         NB. initiative
gr=: 7&{::         NB. gr

NB. conditions
di=: ~:&id            NB. different id
dg=: ~:&gr            NB. different group
da=: ep@[             NB. damage
wm=: 2 * ty@[ e. wt@] NB. weak to multiplier
im=: ty@[ -.@e. it@]  NB. immune to multiplier
co=: im * wm * da * dg * di

sp=: 3 : 0 NB. select phase
 II=. Immune,Infection
 TO=. ([: \: (co , ep@] , in@])"1)"1 2/~ II NB. targets order
 SO=. \: (ep , in)"1 II NB. select order
 A =. 0$0
 for. i.#TO=. SO{TO do.
  A =. A,{.A-.~{.TO
  TO=. }.TO
 end./:~ SO,.A
)

atk=: ([: < 0 >. un@] - ih@] <.@%~ hp@] - da@[)`1:`]}