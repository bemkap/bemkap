require'xml/sax/x2j files'

x2jclass'px2j4'

'Items'x2jDefn
/           := root                : root=: 0 0$0
fractal     := root=: root,n;ty;fr : fr  =: 0 0$0 [ 'n ty'=: atr'name type'
fractal/t   := fr  =: fr,0".t      : t   =: (ty-:'prob') # atr'p'
fractal/t/f := t   =: t,' ',y
)

rfr=: process @ fread @ jpath