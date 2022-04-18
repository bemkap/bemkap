F=: 'b'fread'abr'
v=: 110
prop=: ".&>{.F
cls=: F{~+:i.-:#F=: }.F
pag=: ".&.>F{~>:+:i.-:#F
dia=: +/&>pag
ord=: ,./_9]\\:~(;;:&.>cls)(+&.>//.,.~.@:[)<"0;pag
prom=: prop(+/@:]%({~#))dia
proj=: prom*{:prop
