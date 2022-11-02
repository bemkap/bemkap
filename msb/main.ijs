require'data/jd'
WINDOW=: 0 : 0
pc win1 closeok;
bin h;

cc  tabl0 table 1 2;
set tabl0 hdr codigo cantidad;
set tabl0 colwidth 256 128;
set tabl0 protect 1 1;

pshow;
)
wd WINDOW

A=: 0 : 0
cc  tabl1 table 1 3;
set tabl1 hdr producto precio_unitario precio_total;
set tabl1 colwidth 384 128 128;
set tabl1 protect 1 1 1;
)