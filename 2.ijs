require'jpeg'
I=: readjpeg jpath '~temp/capibara.jpg'
J=: {.@(256 256 256&#:)"0 I
b=: 0,.0,.~0,0,~]
M=: 3 3$0 0 0 0 0 7r16 3r16 5r16 1r16
c=: (<1 1)&{
K=: (1 1,:3 3) (M*c);._3 b J-I
f=: [: |: [: +//. |:"2