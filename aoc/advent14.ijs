load'~addons/convert/misc/md5.ijs'
e2=: 2&(=/\)
g=: (([:I.*./@:e2\) ,/@:{ ]) md5^:2017
K=: 'ahsbgdzn'
s3=: ([: ]`(' '"_)@.((0$0)&-:) 3 {.@g K,":)
s5=: ([: ]`(' '"_)@.((0$0)&-:) 5 g K,":)
s=: 3 : 0
A=. 0$0
I=. <@s5"0 >:i.1000
lh=. 0 1000
while. 1>#A do.
  if. -.' '-:t=. s3 {.lh do.
    if. I ([: +./ +./@:(=/) S: 0) t do. A=. A,{.lh end.
  end.
  lh=. >:lh
  if. 0=10000|{:lh do. smoutput {:lh end.
  I=. (}.I),<s5 {:lh
end.8 8$A
)