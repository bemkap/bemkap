F=: 'b'fread'/feb',~jcwdpath''

cls=: F{~  +:i.-:#F
pag=: F{~>:+:i.-:#F

dia=: +/@:".&>pag
ord=: |:\:~(;;:&.>cls)(+&.>//.,.~.@:[)<"0;".&.>pag