load'~addons/convert/misc/md5.ijs'
t4=: 'af'I.4{.md5
pp=: #~ (0&<:*./@:*.<:&3)"1
P=: 0 _1,0 1,_1 0,:1 0
D=: 'UDLR'
n=: pp@:(+"1 P#~t4)
K=: 'pvhmgsws'
pd=: P{~D&i.
i=: (,"_ 0([: pd inv (+/@:pd (n -"1 [) (K&,))))
j=: (,(i@{. L: 0)@{:)
s=: 3 : 0
A=. j <{.^:_1,''
L=. 0
while. 1<#A do.
  if. 0 e. ,$ S: 0 {: A do. A=. (}:,(}. L: 0)@{:) }:A
  else. A=. j A end.
  if. 3 3-:+/{.pd _1{::A do.
    smoutput L=. L>.#{._1{::A
    A=. (}:,(}. L: 0)@{:) A
  end.
end.L
)