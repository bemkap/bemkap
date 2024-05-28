input=: 'b'fread'input8'

input=: ;:&.>'|'&splitstring&> input

solution1=: +/ 2 3 4 7 e.~ #S:0 {:"1 input

check=: 3 : 0
 n=. #/.~/:~;>y
 t=. {.>(#~4=#&>)>y
 a=. (#~-.@e.&t) o=. 'abcdefg'#~8=n
 b=. 'abcdefg' {~ 6 i.~ n
 c=. o-.a
 d=. (#~e.&t) o=. 'abcdefg'#~7=n
 e=. 'abcdefg' {~ 4 i.~ n
 f=. 'abcdefg' {~ 9 i.~ n
 g=. o-.d
 a,b,c,d,e,f,g
)

NUMBERS=: 'abcefg';'cf';'acdeg';'acdfg';'bcdf';'abdfg';'abdefg';'acf';'abcdefg';'abcdfg'

parsed=: NUMBERS&i.&.>(check@:{.('abcdefg'/:~@:{~i.)L:0{:)"1 input

solution2=: +/10&#.&>parsed