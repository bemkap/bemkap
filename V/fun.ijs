BACK=: 25 35 45

textxy=: 4 : 0
 gltextxy x
 gltext y
)
glpre=: 3 : 0
 glbrush glrgb BACK
 glrect 0 0,+:C=. -:glqwh''
 C
)
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
show=: (;:'hide show')&stringreplace
ixapply=: 1 : '(u x{y)(x})y'