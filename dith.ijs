require'jpeg'
NB. I=: readjpeg jpath '~temp/capibara.jpg'
NB. J=: {.@(256 256 256&#:)"0 I
I=: i. 12 12
J=: I-10
b=: 0,.0,.~0,0,~]
M=: 3 3$0 0 0 0 0 7r16 3r16 5r16 1r16
c=: (<1 1)&{
K=: (1 1,:3 3) (M*c);._3 b I-J
f=: [: |: [: +//. |:"2
L=: J + }: |: f |:"2 }."2 }:"1 }."1 f"3 K NB. the hell is this