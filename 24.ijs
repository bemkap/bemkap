P=: 'b'fread'~temp/input24.txt'
I=: x: 6 9 7 6 8 4 7 1 7 9 5 7 4 6

run=: 3 : 0
 N=. y
 w=. x=. y=. z=. 0x
 r=. 0$0
 for_i. P do.
  j=. ;:>i  
  select. 0{::j
   case. 'inp' do.
    ".(1{::j),'=.',":{.N
    N=. }.N
   case. 'add' do. ".(1{::j),'=.',(1{::j),'+',(2{::j)
   case. 'mul' do. ".(1{::j),'=.',(1{::j),'*',(2{::j)
   case. 'div' do. ".(1{::j),'=.(**<.@|)',(1{::j),'%',(2{::j)
   case. 'mod' do. ".(1{::j),'=.',(1{::j),'|~',(2{::j)
   case. 'eql' do. ".(1{::j),'=.',(1{::j),'=',(2{::j)
  end.r=.r,z
 end.r
)

run1=: 3 : 0
 z=. 0
 if. ( 0{y)~: 11+26|z do. smoutput z=. 1+( 0{y)+z*26 end.
 if. ( 1{y)~: 11+26|z do. smoutput z=.11+( 1{y)+z*26 end.
 if. ( 2{y)~: 14+26|z do. smoutput z=. 1+( 2{y)+z*26 end.
 if. ( 3{y)~: 11+26|z do. smoutput z=.11+( 3{y)+z*26 end.
 if. ( 4{y)~: _8+26|z do. smoutput z=. 2+( 4{y)+((**<.@|)z%26)*26 end.
 if. ( 5{y)~: _5+26|z do. smoutput z=. 9+( 5{y)+((**<.@|)z%26)*26 end.
 if. ( 6{y)~: 11+26|z do. smoutput z=. 7+( 6{y)+z*26 end.
 if. ( 7{y)~:_13+26|z do. smoutput z=.11+( 7{y)+((**<.@|)z%26)*26 end.
 if. ( 8{y)~: 12+26|z do. smoutput z=. 6+( 8{y)+z*26 end.
 if. ( 9{y)~: _1+26|z do. smoutput z=.15+( 9{y)+((**<.@|)z%26)*26 end.
 if. (10{y)~: 14+26|z do. smoutput z=. 7+(10{y)+z*26 end.
 if. (11{y)~: _5+26|z do. smoutput z=. 1+(11{y)+((**<.@|)z%26)*26 end.
 if. (12{y)~: _4+26|z do. smoutput z=. 8+(12{y)+((**<.@|)z%26)*26 end.
 if. (13{y)~: _8+26|z do. smoutput z=. 6+(13{y)+((**<.@|)z%26)*26 end.
 z
)
