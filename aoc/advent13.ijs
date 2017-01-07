c=: 4 : '1362+(x*x)+(3*x)+(2*x*y)+y+y*y'
and=: 17 b.
p=: [:<:[:#(and<:)^:(0&<)^:a:
M=: -.2|p"0 c~"0/~ i.40
N=: 0 _1,_1 0,0 1,:1 0
ib=: #~(*./@:(40&>*.>:&0))"1 NB. in bounds
free=: #~(M{~([:<;/))"1 NB. free space
G=: 39 31
s=: 3 : 0
st=. ,<v=. ,:1 1
ps=. 0 2$0
while. (0<#0{::st) do. NB. +.G -.@e. _1{::st do.
  if. (51<#st)+.0=#_1{::st do.
    st=. (}: , (}. L: 0@:{:)) }:st
  else.
    ps=. ps,{._1{::st
    st=. st,<t=. v-.~free ib N+"1 {._1{::st
    v=. v,t
  end.
end.ps
)