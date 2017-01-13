require'regex'
R =:    'cpy (-?\d+) ([abcd])';'cpy ([abcd]) ([abcd])'
R =: R, 'inc ([abcd])';'dec ([abcd])'
R =: R, 'jnz (-?\d+) ([abcd])';'jnz ([abcd]) (-?\d+)';'jnz ([abcd]) ([abcd])'
R =: R, 'tgl ([abcd])';'add ([abcd]) ([abcd])';'mul ([abcd]) ([abcd])'
R =: R,<'nop'
T =: 4 6 3 2 0 _1 1 2 _1 _1
NB. F =: 'b' fread './input4.txt'
F =: 'b' fread 'c:/users/usuario/j804-user/temp/aoc/input3.txt'
tr=: ".`('abcd'&i.)@.(4>'abcd'&i.)
p=: 3 : 0
I=. ,/F I.@:(rxeq~&>/) R
C=. 0 3$0
for_i. i.#I do. C=. C,(<":i{I),}.,/(R{~i{I) (rxmatches rxfrom ])&> (i{F) end.C
> 0:`(tr@:(,/))`".`".@.# L: 0 C
)
P   =: p''
T   =: 4 6 3 2 0 _5 1 2 _8 _9
abcd=: 12 0 0 0
PC  =: 0
cpy0=: 4 : 'PC=: >:PC[abcd=: x y} abcd'
cpy1=: 4 : 'PC=: >:PC[abcd=: abcd y}~   x{abcd'
inc =: 4 : 'PC=: >:PC[abcd=: abcd x}~ >:x{abcd'
dec =: 4 : 'PC=: >:PC[abcd=: abcd x}~ <:x{abcd'
jnz0=: 4 : 'PC=: PC + 1:^:(0&=) (y{abcd) * 0~:x     '
jnz1=: 4 : 'PC=: PC + 1:^:(0&=)  y       * 0~:x{abcd'
jnz2=: 4 : 'PC=: PC + 1:^:(0&=) (y{abcd) * 0~:x{abcd'
add =: 4 : 'PC=: >:PC[abcd=: abcd+(y{abcd) x} 0 0 0 0'
mul =: 4 : 'PC=: >:PC[abcd=: abcd*(y{abcd) x} 1 1 1 1'
tgl =: 4 : 0
 I=. PC+x{abcd
 if. I<#P do. P=: P (PC+x{abcd)}~ ((T{~{.),}.)P{~I end.
 PC=: >:PC
)
nop =: 4 : 'PC=: >:PC'
run =: 3 : 0
while. PC<#P do.
  n=. cpy0`cpy1`inc`dec`jnz0`jnz1`jnz2`tgl`add`mul`nop@.({.PC{P)
  n/ }.PC{P
end.
)
test=: run