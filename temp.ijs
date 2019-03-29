B=: >:?10 10$4 NB.board is rotated clockwise 90 degrees
msk=: 0 1#~[,.~i.@-.@- NB.<n> msk <width>.mask for n-blocks
eq=: [:(1=#@:=)"1]\ NB.<n> eq <row>.n-block its all the same color
rmH=: (eq(1-+./)@:*(msk#))*] NB.zero horizontal equal n-blocks
rmHV=: |:@:(rm"1)^:2 NB.zero horizontal and vertical equal n-blocks
rnw=: (],([:>:@?4#~(-#)))(#~>&0) NB.renew zeroed cells
