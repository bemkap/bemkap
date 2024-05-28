input=: cutLF(0 : 0)
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
)

input=: 'b'fread'input3'

input=: "."0&>input

sum=: +/input
half=: -:0{dim=: $input
solution1=: (*&#.-.)half<sum

filter=: 1 : 0
 for_i. i.1{$y do.
  if. 1=#y do. break. end.
  y=. y#~(=u)i{"1 y
 end.y
)

oxygen=: [:#.(-:@#<:+/)filter
co2=: [:#.(-:@#>+/)filter

solution2=: (oxygen*co2)input