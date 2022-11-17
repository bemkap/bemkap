FCOB=: 0 : 0
bin v;
cc fcob_tb_cobr table 1 5;
set fcob_tb_cobr hdr codigo cantidad producto p_unitario p_total;
bin h;
cc fcob_cb_cuen checkbox; cn en cuenta:;
cc fcob_cl_cuen combolist; set fcob_cl_cuen enable 0;
bin z;
cc fcob_lb_tota static; cn total:;
bin z;
cc fcob_bt_cobr button; cn listo;
)

fcob_init=: 3 : 0
 wd'set fcob_cl_cuen items ',,LF,.~>'elegir cuenta';{."1 ] 1!:0 jpath DIRECTORY,'CUENTAS/*'
)

main_fcob_tb_cobr_change=: 3 : 0
 L=. >:a:i:~C=. {."1]_5]\<;._2 wd'get fcob_tb_cobr table'
 wd'set fcob_tb_cobr shape ',":L,5
 wd'set fcob_tb_cobr colwidth ',":<.1r6 1r6 2r6 1r6 1r6*_30+{.".wd'getp wh'
 wd'set fcob_tb_cobr protect ',":,(L,5)$0 0 1 1 1
)

main_fcob_cb_cuen_button=: 3 : 0
 wd'set fcob_cl_cuen enable ',fcob_cb_cuen
)