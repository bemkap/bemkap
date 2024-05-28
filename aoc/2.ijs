input=: cutLF(0 : 0)
forward 5
down 5
forward 8
up 3
down 8
forward 2
)

input=: 'b'fread'input2'

input=: ;:&>input

STRING=: ;:'forward down up'
COORD=: 0 1,1 0,:_1 0

direction=: COORD {~ STRING i. {."1 input
magnitude=: ".&> {:"1 input

solution1=: */ | +/ direction * magnitude

mp=: +/ .*

forward=: 0 0 0 0,0 0 0 0,1 0 0 0,:0 1  0 0
down   =: 0 0 0 0,0 0 0 0,0 0 0 0,:0 0  1 0
up     =: 0 0 0 0,0 0 0 0,0 0 0 0,:0 0 _1 0

direction=: (forward,down,:up) {~ STRING i. {."1 input
magnitude=: ".&> {:"1 input

solution2=: */ 2 {. 0 0 0 1 mp mp/ (=i.4) +"2 direction * magnitude