F=: 'b'fread'sep'
V=: {.CFG=: ".&>{.F
prop=: 0.33(}.}:CFG)}1#~{:CFG
cls=: 0({"1)_2]\F=: }.F
CL=: /:~~.;;:&.>cls
gpag=: 0({"1)_2]\]
pag=: ".&.>1({"1)_2]\F
MAT=: (;pag)(<"1;(,.~&.>i.@#)(}:CL)&i.&.>;:&.>cls)}0$~cls,&#CL
dia=: +/"1 MAT
top=: |:_8]\(\:~CL,&.>6&":"0&.>)+/MAT
prom=: prop(](+/%#)@:%({.~#))dia
proy=: prom*+/prop

summary=: ('~V  ',:' D '),.":dia,:~<.0.5+dia%V
summary=: summary,'','   prom  ~prov   proy  total        prop',:((+/prop)(],'/',[)&(5j2&":)+/prop({.~#)dia),~' ',~7":<.prom,(prom%V),proy,+/dia
smoutput summary

G=: 'b'&fread&.>MES=: ;:'feb mar abr may jun jul ago'
SUMA=: +/&.>;&.>".&.>L:1(1({"1)_2]\}.)&.>G
PREC=: {.@:".&.>{.&>G
hist=: PREC(,5&":)&>~MES(,8&":)&.>SUMA