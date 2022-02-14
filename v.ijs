F=: }.'b'fread'/feb',~jcwdpath''

cls=: F{~  +:i.-:#F
pag=: F{~>:+:i.-:#F

dia=: +/@:".&>pag
ord=: 25({."1,}."1)|:\:~(;;:&.>cls)(+&.>//.,.~.@:[)<"0;".&.>pag