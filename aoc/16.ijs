d1=: 0;binary packet1=: 'C200B40A82'
d2=: 0;binary packet2=: '04005AC33890'
d3=: 0;binary packet3=: '880086C3E88112'
d4=: 0;binary packet4=: 'CE00C43D881120'
d5=: 0;binary packet5=: 'D8005AC2A8F0'
d6=: 0;binary packet6=: 'F600BC2D8F'
d7=: 0;binary packet7=: '9C005AC2F8F0'
d8=: 0;binary packet8=: '9C0141080250320F1802104A08'

E=: '0123456789ABCDEF'
binary=: [:, [:#: E&i.
version=: 3&{.
type=: 3{.3&}.
data=: 6&}.

literal=: #.@:{~ [:, (>:i.4)+/~5*1 i.@+ 0 i.~ _5{.\]

tlen=: 0{data
lib=: 15{.}.@:data NB. length in bits
lip=: 11{.}.@:data NB. length in packets

TOTAL=: 0

parse=: (3 : 0)^:(4<:#)
 TOTAL=: TOTAL+#.version y
 t=. #.type y
 if. 4=t do. (literal;(}.~5*1+0 i.~ _5{.\]))data y
 else.
  op=. +`*`<.`>.`]`>`<`=@.t
  w=. 0$0
  select. tlen y
   case. 0 do.
    l=. #. lib y
    rest=. l }. 15 }. }. data y
    y=. l {. 15 }. }. data y
    while. 4<:#y do.
     'v y'=. parse y
     w=. w,v
    end.    
    y=. y,rest
   case. 1 do.    
    l=. #. lip y
    y=. 11 }. }. data y
    for. i.l do.
     'v y'=. parse y
     w=. w,v
    end.
  end.
  y;~w=. op/w
 end.
)

solution2=: >{.parse binary ;'b'fread'input16'
solution1=: TOTAL NB. absolutely crazy