F=: }.'b'fread'/mar',~jcwdpath''
v=: 110

cls=: F{~  +:i.-:#F
pag=: F{~>:+:i.-:#F

dia=: +/@:".&>pag
ord=: ,./_8]\\:~(;;:&.>cls)(+&.>//.,.~.@:[)<"0;".&.>pag

prop=: +/\0,0.33(3 9 15 21})26#1
prom=: prop(+/@:]%({~#))dia
proj=: prom*{:prop
