F=: 'b'fread'jun'
CL=: 'b'fread'CL'
V=: 120
prop=: ".&>{.F
cls=: F{~+:i.-:#F=: }.F
pag=: ".&.>F{~>:+:i.-:#F
MAT=: (;pag)(<"1;(,.~&.>i.@#)CL&i.&.>;:&.>cls)}0$~cls,&#CL
dia=: +/"1 MAT
ord=: |:_8]\(\:~CL,&.>5&":"0&.>)+/MAT
prom=: prop(+/@:]%({~#))dia
proy=: prom*{:prop

summary=: ('~V  ',:' D '),.":dia,:~<.0.5+dia%V
summary=: summary,'','   prom  ~prov   proy  total        prop',:(({:prop)(],'/',[)&(5j2&":)prop({~#)dia),~' ',~7":<.prom,(prom%V),proy,+/dia
smoutput summary