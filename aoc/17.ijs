fy=: *-(-:@*<:)@:]
fx=: ([fy[)`fy@.>
shoot=: (fx~{.),(fy~{:)

X=: 240 292
Y=: _57 _90

NB. x >: 23

P=: {:(#~(_ _-.@-:target)"1) ] 23,.i.100
solution1=: {:>./shoot&P"0 i.200

target=: 3 : 0
 t=. i=. 0
 while. _90<{:t do.
  t=. i shoot y
  if. (240<:{.t)*.(292>:{.t)*.(_90<:{:t)*.(_57>:{:t) do. t return. end.
  i=. >:i
 end._ _
)

solution2=: +/(<_ _)~:,target&.><"1(i.293),"0/_100+i.200