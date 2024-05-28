input=: cutLF(0 : 0)
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
)

input=: 'b'fread'input15'

input=: "."0&>input

dist=: 3 : 0
 D=. 0(0})_#~#,y
 a=. 0
 C=. 1#~#,y
 while. 1 do.
  m=. (a{D)+y{~i#~t=. C{~i=. >a{trans
  D=. D<.m(t#i)}D
  if. -.+./C=. 0(a})C do. break. end.  
  a=. (C#i.#y){~(i.<./)C#D
 end.D
)

trans=: ,(1 1,:3 3) (1 3 5 7(#~_&>)&.:>@:{,);._3 ] _,_,~_,._,.~i.$input
solution1=: dist,input

input=: >:9|<:>,&.>/,.&.>/(+/~i.5)+&.>5 5$<input
trans=: ,(1 1,:3 3) (1 3 5 7(#~_&>)&.:>@:{,);._3 ] _,_,~_,._,.~i.$input
solution2=: {:dist,input