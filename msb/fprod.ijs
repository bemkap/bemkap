FPRO=: 0 : 0
tabnew PRODUCTOS;
cc fpro_tb_prod table 1 5;
set fpro_tb_prod hdr codigo nombre marca costo porcentaje;
cc fpro_tx_prod edit;
)

main_tb_prod_change=: 3 : 0
 wd'set fpro_tb_prod colwidth ',":<.1r5*_30+2{".wd'qscreen'
)

fpro_init=: 3 : 0
 T=. |:<"1&>('" ',~'"',":)"1&.>{: jd'reads from prod order by prodcodi'
 wd'set fpro_tb_prod shape ',":5,~#T
 wd'set fpro_tb_prod protect ',":,1$~5,~#T
 wd'set fpro_tb_prod data ',}:;T
)

fpro_focus=: 3 : 0
 wd'set fpro_tx_prod focus'
)

main_fpro_tx_prod_char=: 3 : 0
 T=. |:<"1&>('" ',~'"',":)"1&.>{: jd'reads from prod where prodnomb like "',fpro_tx_prod,'"'
 wd'set fpro_tb_prod shape ',":5,~#T
 wd'set fpro_tb_prod protect ',":,1$~5,~#T
 wd'set fpro_tb_prod data ',}:;T
 main_tb_prod_change''
)

main_fpro_tb_prod_mbldbl=: 3 : 0
 wd'set fcob_tx_codi text ',(}:^:('b'={:)fcob_tx_codi),>({.".fpro_tb_prod){_5{.\<;._2 wd'get fpro_tb_prod table'
 wd'set opes active 0'
)