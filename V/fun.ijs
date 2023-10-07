BACK=: 25 35 45

set_table_data=: 3 : 0
 wd'set %s block' sprintf {.y
 wd'set %s data %s' sprintf y
 wd'set %s protect 1' sprintf {.y
)
textxy=: 4 : 0
 gltextxy x
 gltext y
)
glpre=: 3 : 0
 glpen 0:glbrush glrgb BACK
 glrect 0 0,+:C=. -:glqwh''
 C
)
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
show=: (;:'hide show')&stringreplace
ixapply=: 1 : '(u x{y)(x})y'