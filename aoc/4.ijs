input=: cutLF(0 : 0)
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
)

input=: (#~a:&~:)'b'fread'~temp/aoc/input4'

roll=: ".&>{.input
boards=: _5]\".&>}.input

first_roll=: 1 i.~ +./"1 first_card=: +./"1 *./"1 every_roll=: boards&e.\roll
first_unmarked=: -.every_roll {~ <first_roll , first_board=: i.&1 first_roll { first_card
first_winner=: first_unmarked*first_board{boards
solution1=: (first_roll{roll)*+/,first_winner

row=: *./"1
col=: *./"2

last_roll=: 0 i:~ *./"1 +./"1 (row+.col) every_roll
last_board=: 0 i.~ +./"1 (row+.col) last_roll{every_roll
last_unmarked=: -.last_board{every_roll{~1+last_roll
solution2=: (roll{~1+last_roll)*+/,last_unmarked*last_board{boards