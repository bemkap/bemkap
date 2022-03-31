P=: 'b'fread'~temp/input24.txt'

run=: 3 : 0
 N=. y
 w=. x=. y=. z=. 0
 for_i. P do.
  j=. ;:>i  
  select. 0{::j
   case. 'inp' do.
    ".(1{::j),'=.',":{.N
    y=. }.N
   case. 'add' do. ".(1{::j),'=.',(1{::j),'+',(2{::j)
   case. 'mul' do. ".(1{::j),'=.',(1{::j),'*',(2{::j)
   case. 'div' do. ".(1{::j),'=.(**<.@|)',(1{::j),'%',(2{::j)
   case. 'mod' do. ".(1{::j),'=.',(1{::j),'|~',(2{::j)
   case. 'eql' do. ".(1{::j),'=.',(1{::j),'=',(2{::j)
  end.
 end.
)