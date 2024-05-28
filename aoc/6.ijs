input=: 3,4,3,1,2

input=: ;".&.>'b'fread'input6'
state=: (9$0)(#/.~@:])`(~.@:])`[}input
new=: 0 0 0 0 0 0 1 0 0*{:
day=: [:(+new)1&|.

solution1=: day^:80 state

solution2=: day^:256 state