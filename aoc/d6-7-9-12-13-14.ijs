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
NB. n=: 1&|. , >:@{:
NB. m=: 2&|.@}:@(_7&|.) , 2+{:
NB. s=: 4 : 0 NB. lm s p
NB.  pp=. y$0
NB.  i=. >:l=. 0
NB.  while. i<:x do.
NB.   a=. 0=23|i
NB.   if. a do. pp=. ((_8{l)+i+pp{~y|<:i) (y|<:i)} pp end.
NB.   l=. n`m@.0 l
NB.   i=. >:i+a
NB.  end.pp
NB. )

NB. day 12
NB. part 1
NB. I=: '.#' i. '##.#....#..#......#..######..#.####.....#......##.##.##...#..#....#.#.##..##.##.#.#..#.#....#.#..#.#'
NB. R=: 'm'fread'~temp/input.txt'
NB. R1=: '.#' i. 5{."1]2}.R
NB. R2=: '.#' i. {."1]9}."1]2}.R
NB. R=: R2 /: #.R1
NB. ex=: 0 0 , 0 0 ,~ ]

NB. day 13
NB. part 1
NB. M=: 'm'fread'~temp/input.txt'
NB. N=: ' +v<^>|-\/' i. M
NB. C=: 1 0,0 _1,_1 0,:0 1
NB. I=: ($N) #: I. 1 = ,N
NB. P=: ($N) #: I. 2 3 4 5 e.~ ,N
NB. D=: _1$~#P

NB. day 14
NB. i=: 0 1
NB. r=: 3 7
NB. s=: 3 : 0
NB.  for. i.10+880751 do.
NB.   r=: r , 10 #.inv +/ i{r
NB.   i=: (#r)|>:i ([+{) r
NB.  end.
NB. )