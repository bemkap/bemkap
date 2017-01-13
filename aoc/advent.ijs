require'viewmat'
M =: > '0123456789.#'&i. each cutLF fread './input.txt'
n =: [: (#~ *./&(0 0&<: *. <&($M))"1) +"1&(4 2$_1 0 1 0 0 _1 0 1)
v =: #~ (11>M{~;/)
vn=: v@:n
h =: (] /: |@+/@:-"1) vn
to=: 4 : 0
st=. <ps=.,:x
whilst. -.y e. _1{::st do.
 st=. (, (ps -.~ [: ; <@vn"1)L:0@:{:) st
 ps=. ps,;{:st
end.st
)

NB. 17 29 to 5 3
NB. (, x&p@:{.L:0@:{:)
NB. ((&p)(@:({.L:0)))(@{:)