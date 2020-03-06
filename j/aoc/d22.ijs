load'format/printf'
T=: cutLF fread'~temp/input.txt'
O=: 'deal into new stack';'cut';'deal with increment'
ds=: 119315717514047x
mi=: 4 : 'x y&|@^ <:5 p: y'
di=: ds|(<:ds)-]
ci=: ds|+
ii=: ds|(ds mi~ [)*]
ri=: 3 : 0
 p=. 0".(}.~i:&' ')&> |.T
 c=. O&(1 i.~ {.@:E.&>)"0 |.T
 for_i. p,.c do. y=. ({.i)di`ci`ii@.({:i)y end.
)
NB. f(y)=a*y+b
m=: 42226282425198x
b=: 34377085558178x
n=: 101741582076661x
iter=: 4 : 0
 an=. m ds&|@^ x
 ds|(y*an)+b*(an-1)*(m-1) mi ds
)
d22=: n iter 2020