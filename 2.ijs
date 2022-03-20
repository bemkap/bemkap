F=: ;:&>'b'fread'~temp/input2.txt'

o=: <"0((;:'on off')i.0&{)"1 F
c=: (".&>)&.> '..'&splitstring&.>3 7 11{"1 F
int=: 4 : 'if. <:/a=. x(>.&{.,<.&{:)y do. a else. 0$0 end.'
sz=: [:+/-~/&>

M=: sz"1 int&.>"1/~c
cuboid=: ({"0 1~i.@:#)M
diff=: 2(sz"1@:(int&.>/))\c