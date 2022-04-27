load'media/imagekit'

IMG=: '~temp/img.png'
TILE=: 2 2

SYM=: 1
tail=: }.`( 1&|.)@.SYM
liat=: }:`]@.SYM

Pi=: ($P)$(i.~~.),P=: (,:~TILE) <;._3 rgb_to_i read_image jpath IMG
UP=: ~.&.>(~.@:,@:tail/:~(tail</.&,liat))Pi
DO=: ~.&.>(~.@:,@:liat/:~(liat</.&,tail))Pi
LE=: ~.&.>(~.@:,@:(tail"1)/:~(tail"1</.&,liat"1))Pi
RI=: ~.&.>(~.@:,@:(liat"1)/:~(liat"1</.&,tail"1))Pi

expand=: (],({~?@:#)&>@:({~{:))
create=: 3 : '>,.&.>/,&.>/(~.,P){~RI expand^:y"1,.DO expand^:y?5'