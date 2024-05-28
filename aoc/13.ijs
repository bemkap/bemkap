input=: cutLF(0 : 0)
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0
-
fold along y=7
fold along x=5
)

input=: 'b'fread'input13'

sep=: (i.&(<,'-'))input
instructions=: (('xy'i.11&{),([:".13&}.))&.>(1+sep)}.input
points=: ".&>sep{.input

axis=: 0{[
at=: 1{[
coord=: axis{]
fold=: ((at([-]-[)coord)`axis`]})^:(coord>at)

solution1=: #~.(>{.instructions) fold"1 points

solution2=: |:'#'(<"1&>fold"1&.>/(|.instructions),<points)}40 6$' '