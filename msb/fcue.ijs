FCUE=: 0 : 0
bin h;
cc fcue_cl_cuen combolist;
cc fcue_bt_nuev button; cn +;
bin z;
cc fcue_tb_cuen table 1 4;
set fcue_tb_cuen hdr fecha compra entrega parcial;
bin h;
cc fcue_tx_entr edit;
cc fcue_bt_entr button; cn entrega;
cc fcue_bt_tota button; cn cancela;
)

fcue_init=: 3 : 0
 wd'set fcue_cl_cuen items ',,LF,.~>'elegir cuenta';{."1 ] 1!:0 jpath DIRECTORY,'CUENTAS/*'
)

main_fcue_tb_cuen_change=: 3 : 0
 wd'set fcue_tb_cuen colwidth ',":<.1r4*_30+{.".wd'getp wh'
)

main_fcue_cl_cuen_select=: 3 : 0
 if. 1=#1!:0 jpath fn=. ({.~ 1+0 i:~ ' '&=)DIRECTORY,'CUENTAS/',fcue_cl_cuen do.
  D=. ((A.~ 0>1&{)"1,.+/\@:(1&{"1))0,.~_2]\".}:fread fn
  wd'set fcue_tb_cuen shape ',":$D
  wd'set fcue_tb_cuen data ',(' 0 ';' "" ')stringreplace":,|D
  main_fcue_tb_cuen_change''
 end.
)

main_fcue_bt_nuev_button=: 3 : 0
 if. 0=#1!:0 fn=. DIRECTORY,'CUENTAS/',wd'mb input text "" "nueva cuenta:" ""' do.
  '' fwrite fn
  fcue_init''
 end.
 wd'pshow fullscreen'
)

main_fcue_bt_entr_button=: 3 : 0
 