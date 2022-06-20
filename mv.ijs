rn=: 3 : 0
 i=. ;(</.i.@:#)y
 n=. ;<@:(,.<"0@:i.@:#)/.~y
 <"1(,'-',":)&>/"1 n/:i
)
slash=: ,&'/'^:('/'~:{:)

exit^:(5>#ARGV)1

'NAMES FROM TO'=: 2}.ARGV
OLD=: 1 dir '*.jp*g',~slash FROM
NEW=: ((slash TO),'.jpg',~])&.>rn 'b' fread NAMES

exit^:(OLD~:&#NEW)2

1!:5^:(-.@:fexist)<TO
NEW fcopynew&.>"1 OLD

exit 0