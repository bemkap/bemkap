HEIGHT=: 1
WINDOW=: 0 : 0
pc win1 closeok;
bin h;
cc  tabl table 1 5;
set tabl hdr codigo cantidad producto p_unitario p_total;
set tabl colwidth 256 128 384 128 128;
set tabl type 0 0 0 0 0;
set tabl data 0 0 "def" "ghi" "jkf";
set tabl protect 0 0 1 1 1;
pshow;
)
win1_tabl_change=: 3 : 0
if. (1,~<:HEIGHT)-:".tabl_cell do. 
 wd'set tabl shape ',(":HEIGHT=: >:HEIGHT),' 5'
 wd'set tabl protect ',":,(HEIGHT,5)$0 0 1 1 1
end.
)
wd WINDOW