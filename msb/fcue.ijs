require'format/printf'

FCUE=: 0 : 0
tabnew CUENTAS;
bin h;
cc fcue_cl_cuen combolist;
bin z;
cc fcue_tb_cuen table 1 4;
set fcue_tb_cuen hdr fecha compra entrega parcial;
bin h;
cc fcue_tx_entr edit;
cc fcue_bt_entr button; cn entrega;
cc fcue_bt_tota button; cn cancela;
)

fcue_init=: 3 : 0
 wd'set fcue_cl_cuen items ',boxtoitem'elegir cuenta';{."1 ] 1!:0 jpath CUENTAS,'*'
)

main_fcue_tb_cuen_change=: 3 : 0
 wd'set fcue_tb_cuen colwidth ',":<.1r4*_30+{.".wd'getp wh'
)

main_fcue_cl_cuen_select=: 3 : 0
 if. 1=#1!:0 jpath fn=. CUENTAS,fcue_cl_cuen do.
  if. 0<#E=. _2]\".}:fread fn do.
   F=. '%02d-%02d-%02d   %02d:%02d' sprintf 54 A."1 (DBASE#.inv{.)"1 E
   M=. ||.^:(0<{:)"1 ] 0,.{:"1 E
   P=. +/\{:"1 E
   D=. (<"1 F) ,. M ,.&:(<"0) P
  else. D=. 0 4$0 end.
  wd'set fcue_tb_cuen shape ',":$D
  wd'set fcue_tb_cuen data ',boxtoitem ":&.> ,D
  main_fcue_tb_cuen_change''
 end.
)

main_fcue_bt_entr_button=: 3 : 0
 if. 1=#1!:0 jpath fn=. CUENTAS,fcue_cl_cuen do.
  main_fcue_cl_cuen_select (' ',~12":(-".fcue_tx_entr),~DBASE#.x:5{.6!:0'') fappend jpath CUENTAS,fcue_cl_cuen
 end.
)
 