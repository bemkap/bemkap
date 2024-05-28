input=: 16,1,2,0,4,2,7,1,2,14

input=: ;".&.>'b'fread'input7'

solution1=: +/|input-({~-:@#)/:~input

solution2=: <./+/x:(-:@*>:)|input-/i.>:>./input