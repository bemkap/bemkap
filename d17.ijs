require'viewmat'
F=: 'm' fread '~temp/input17.txt'
F=: ". L: 0 ('..' splitstring 2&}.) L: 0 ', '&(\:~@:splitstring)"1 F
F=: >`(([ + i.@:>:@:-~)&>/)@.(<:@#) L: 1 F
F=: 0 _428 +"1 ~. ] S: 0 <@:{"1 F
M=: 1 (;/F)} 1985 260$0
W=: ,:0 _428+0 500

ra=: (+"1 {:) <"1@-. ]
c =: 1 0,0 _1,:0 1
w =: (<:$M) >&{. {:
bt=: (e.~ 0 1 + {:) +. (M {~ 0 1 <@:+ {:)
f =: 3 : 0
 R=. (c ra y) (<&{.&> # [) <$M
 I=. 0 i.~ M{~R
 if. I>:#R do. _1|.y else. y,I{::R end.
)