load'plot'
P=: j./"1 ?100 2$100
C=: j./"1 ?  5 2$100
plt=: 4 : 0
 pd'reset'
 pd'type dot'
 pd'pensize 5'
 pd'color red'
 pd a=. x&([ avg/.~ [: (i.<./)"1 euclidean/)^:_ y
 pd'pensize 4'
 pd'color blue'
 pd x
 pd'type line'
 pd'pensize 1'
 pd x ([ ,. ] {~ [: (i.<./)"1 euclidean/) a
 pd'show'
)