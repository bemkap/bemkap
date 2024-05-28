input=: cutLF(0 : 0)
199
200
208
210
200
207
240
269
260
263
)

NB. input=: 'b'fread'~temp/aoc/input1'

input=: ".&>input

solution1=: +/ 2 </\ input

solution2=: +/ 2 </\ 3 +/\ input