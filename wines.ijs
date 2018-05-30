wineprice=: 4 : 0
peak_age=. x-50
price=. -:x
if. y>peak_age do.
  price=. price*(5-y-peak_age)
else.
  price=. price*(5*((>:y)%peak_age))
end.
0>.price
)
wineset1=: (? ,.~ 50+?)300$50
euclidean=: [: | -&(j./)
K=: 3
gaussian=: 10&$: : (^@:(-@]%+:@[)&*:)
knew=: 1 : 'K +/@:((*u"0)%+/@:(u"0))@{. [: /:~ euclidean/"1'
kneo=: 1: knew
kneg=: gaussian knew
cv=: 3 : 0
C=. ((0.05 1 I. ?@0:)"1 (# ; (#~ -.)~) ])y
+/(wineprice/"1@:(0&{::) *:@- (gaussian knew)"1 _&>/) C
)