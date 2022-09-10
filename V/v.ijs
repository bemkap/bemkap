F=: 'b'fread'sep'
V=: {.CFG=: ".&>{.F
prop=: 0.33(}.}:CFG)}1#~{:CFG
cls=: F{~+:i.-:#F=: }.F
CL=: /:~~.;;:&.>cls
pag=: ".&.>F{~>:+:i.-:#F
MAT=: (;pag)(<"1;(,.~&.>i.@#)(}:CL)&i.&.>;:&.>cls)}0$~cls,&#CL
dia=: +/"1 MAT
top=: |:_8]\(\:~CL,&.>6&":"0&.>)+/MAT
prom=: prop(](+/%#)@:%({.~#))dia
proy=: prom*+/prop

summary=: ('~V  ',:' D '),.":dia,:~<.0.5+dia%V
summary=: summary,'','   prom  ~prov   proy  total        prop',:((+/prop)(],'/',[)&(5j2&":)+/prop({.~#)dia),~' ',~7":<.prom,(prom%V),proy,+/dia
smoutput summary