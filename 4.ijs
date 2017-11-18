require'dd'
C=: ddcon'dsn=bcc'

get=: [: ddfch _1 ,~ C ddsel~ ('select * from ',])

coma=: ','&joinstring
prep=: coma @:(quote@:": each)

ins=: 'insert into ',[,' (',') values (',~coma@:]
put=: C ddsql~ (, ')',~prep)

pcate=: ('categorias' ins ;:'categoria') put <
pcocc=: ('cocciones' ins ;:'coccion') put <
pingr=: 3 : 0
 'i c'=. ;: y
 cid=. cateid c
 if. cid>0 do.
  ('ingredientes' ins ;:'ingrediente categoria') put i;cid
 else. _1 end.
)
pplat=: 3 : 0
 'p t'=. ;: y
 tid=. tipoid t
 if. tid>0 do.
  ('platos' ins ;:'plato tipo') put p;tid
 else. _1 end.
)
ptipo=: ('tipos' ins ;:'tipo') put <
pplin=: 3 : 0
 'p i c'=. ;: y
 pid=. platid p
 iid=. ingrid i
 cid=. coccid c
 if. pid>0 *. iid>0 *. cid>0 do.
  ('platos_ingredientes' ins ;:'plato ingrediente coccion') put pid;iid;cid
 else. _1 end.
)

getid=: 3 : 0
'table col where'=. ;: y
{.^:_ >ddfet C ddsel~ 'select id from ',table,' where ',col,'=',quote where
)

cateid=: [: getid 'categorias categoria '&,
coccid=: [: getid 'cocciones coccion '&,
ingrid=: [: getid 'ingredientes ingrediente '&,
platid=: [: getid 'platos plato '&,
tipoid=: [: getid 'tipos tipo '&,