require'regex'
R=:    'cpy (-?\d+) ([abcd])';'cpy ([abcd]) ([abcd])'
R=: R, 'inc ([abcd])';'dec ([abcd])'
R=: R, 'jnz (\d+) ([abcd])';'jnz ([abcd]) (-?\d+)';'jnz ([abcd]) ([abcd])'
R=: R,<'tgl ([abcd])'
T=: 4 6 3 2 0 _1 1 2
F=: 'b' fread jpath './input3.txt'
p=: 3 : 0
I=. ,/F I.@:(rxeq~&>/) R
C=. 0 3$0
for_i. i.#I do. C=. C,(<":i{I),}.,/(R{~i{I) (rxmatches rxfrom ])&> (i{F) end.C
NB. ".`('abcd'&i.)@.([:,/4>'abcd'&i.) L: 0 C
)