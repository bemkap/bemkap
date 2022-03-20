F=: ;:&>'b'fread'~temp/input2.txt'

o=: <"0((;:'on off')i.0&{)"1 F
c=: (".&>)&.> '..'&splitstring&.>3 7 11{"1 F
int=: 4 : 'if. <:/a=. x(>.&{.,<.&{:)y do. a else. 0$0 end.'

cuboid=: +/"1-~/&>}.c
diff=: 2([:+/[:-~/&>int&.>/)\c