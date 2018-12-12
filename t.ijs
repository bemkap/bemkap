NB. day 4
NB. require'regex'
NB. I=: ,&' -1 -2' L: 0 'b' fread '~temp/input.txt'
NB. r1=: '\[\d{4}-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] Guard \#(\d+) begins shift'
NB. r2=: '\[\d{4}-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] falls asleep (-1)'
NB. r3=: '\[\d{4}-(\d{2})-(\d{2}) (\d{2}):(\d{2})\] wakes up -1 (-2)'

NB. m1=: r1&(rxmatch ".@:>@}.@rxfrom ]) each I
NB. m2=: r2&(rxmatch ".@:>@}.@rxfrom ]) each I
NB. m3=: r3&(rxmatch ".@:>@}.@rxfrom ]) each I

NB. J=: /:~,/>(#~ a:&~:)"1 m1,.m2,.m3

NB. day 6
NB. N=: ". S: 0 'b'fread'~temp/input.txt'
NB. C=: { <@i."0 >:+>./ N
NB. d=: +/ .(|@-)
NB. part 1
NB. s=: (>:@(i. * i. = i:) <./)@:(d |:)
NB. S=: > s&N L: 0 C
NB. I=: ~. ({. , {: , {."1 , {:"1) S
NB. S=: S ([ (* -.) e.) I
NB. O=: \:~ (#;{.)/.~ , S
NB. part 2
NB. s=: +/@:(d |:)
NB. S=: (#~ 10000&>) ; s&N L: 0 C

NB. day 7
NB. part 1
NB. I=: 'm'fread'~temp/input.txt'
NB. A=: a.{~65+i.26
NB. G=: }. L: 0 (<@:({."1)/.~ {:"1) (/: {:"1) (_,.i.26),A i. 5 36 {"1 I
NB. rm=: ~: # ]
NB. s=: 3 : 0
NB.  v=. 0$0
NB.  while. 26>#v do.
NB.   v=. v,n=. v {.@:-.~ a: I.@:= y
NB.   y=. n rm each y
NB.  end.v
NB. )
NB. Sc=: 'BGKDMJCNEQRSTUZWHYLPAFIVXO'
NB. Sn=: 62 67 71 64 73 70 63 74 65 77 78 79 80 81 86 83 68 85 72 76 61 66 69 82 84 75
NB. part 2
NB. pp=: {. ,: ,.@(/:~) each@:{:
NB. G=: (<"0]61+i.26),:G
NB. s=: 3 : 0
NB.  i=. 0
NB.  while. -. *./ a: = {: y do.
NB.   y=. ({: ,:~ {. (0>.-)&.> a: <@= {:) y
NB.   z=. (<0) I.@:= {. y
NB.   y=. ({. ,: -.&z each@:{:) y
NB.   i=. >:i
NB.  end.i++/;{.y
NB. )

NB. day 9
NB. part 1
n=: >:@{: ,~ 1&|.
m=: 2&|.@}:@(_7&|.) , 2+{:
s=: 3 : 0
 'lm p'=. y
 pp=. p$0
 i=. >:l=. 0
 while. i<:lm do.
  if. 0=23|i do.
   pp=. ((_8{l)+i+pp{~p|<:i) (p|<:i)} pp
   l=. m l
   i=. i+2
  else.
   l=. n l
   i=. i+1
  end.pp
 end.
)