BACK=: 41 53 59

textxy=: 4 : 0
 gltextxy x
 gltext y
)
glpre=: 3 : 0
 glbrush glrgb BACK
 glrect 0 0,+:C=. -:glqwh''
 C
)