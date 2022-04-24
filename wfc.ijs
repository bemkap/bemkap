load'media/imagekit'

IMG=: '~temp/img.png'
TILE=: 2 2

Pi=: ($P)$(i.~~.),P=: (,:~TILE) <;._3 rgb_to_i read_image jpath IMG
itoc=: ($P)&#:
ctoi=: itoc^:_1
md=: +/@:|@:-
N=: (<@:#"1 _~1=md"1/~@:itoc)i.*/$P