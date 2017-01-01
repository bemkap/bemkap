load'~addons/convert/misc/md5.ijs'
e2=: 2&(=/\)
e4=: 4&(=/\)
g2=: (([:I.*./@:e2\) { ]) md5
g4=: (([:I.*./@:e4\) { ]) md5
key=. 'abc'
s3=: 3 g key,":
s5=: 5 g key,":
i1000=: >:i.1000
s3n1000s5=: +./@:(s5"0)@(i1000&+)*.s3