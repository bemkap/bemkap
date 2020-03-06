coclass'cfr'

mp=: +/ .*
TYPES=: 'union';'random';'prob'

create=: 3 : 0
P=: ,: X0=: 0 0
I=: 0
'N TY'=: 2 {. y
t=. >{: y
select. TY
  case.   'prob' do. 
    T=: (3 3&$ @ }.)"1 t
    PR=: +/\ {."1 t
    V=: (<@)(`])((mp (T {~ PR I. [: ? 0:))^:)
  case.  'union' do.
    T=: 3 3 $"1 t
    V=: (`,:)(,/@:(mp"2&T)^:)
  case. 'random' do.
    T=: 3 3 $"1 t
    V=: (<@)(`])((mp ({~ ?@#)@(T"_))^:)
end.
1
)

destroy=: codestroy

calc=: 3 : 0
'i x0'=. y
if. y -.@-: I;X0 do.
  P=: }:"1 i"_ V x0,1
end.
I =: i
X0=: x0
P
)

NM=: 3 : 'N__y'