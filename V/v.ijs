DIR=: '/home/bemkap/doc/b/V/'
F=: 'b'fread DIR,'0123'
G=: 'b'&fread&.>DIR&,&.>MES=: ' 'splitstring'0222 0322 0422 0522 0622 0722 0822 0922 1022 1122 1222 0123'
'V CFG'=: ({.;}.)".&>{.F
prop=: (#~*)0 1 0.25{~CFG
cls=: 0({"1)_2]\F=: }.F
tab=: _10]\]
CL=: /:~~.;;:&.>;(0({"1)_2]\}.)&.>G
gpag=: 0({"1)_2]\]
pag=: ".&.>1({"1)_2]\F
MAT=: (;pag)(<"1;(,.~&.>i.@#)(}:CL)&i.&.>;:&.>cls)}0$~cls,&#CL
dia=: +/"1 MAT
top=: |:tab(\:~CL,&.>6&":"0&.>)+/MAT
prom=: prop(]%&(+/)({.~#))dia
proy=: prom*+/prop
hdr=: ((6:I.@:=]),#)@:(7(#~*)@:|(+i.))

summary=: ('~V  ',:' D '),.":dia,:~<.0.5+dia%V
summary=: summary,'','   prom  ~prov   proy  total        prop',:((+/prop)(],'/',[)&(5j2&":)+/prop({.~#)dia),~' ',~7":<.prom,(prom%V),proy,+/dia
smoutput summary

SUMA=: +/&.>+/@:".&>L:1(1({"1)_2]\}.)&.>G
PREC=: {.@:".&.>{.&>G
hist=: (SUMA<.@%&.>PREC)(,5&":)&>~PREC(,5&":)&.>~MES(,8&":)&.>SUMA