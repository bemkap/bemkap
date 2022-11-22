FALT=: 0 : 0
bin vs;
groupbox productos;
bin h; cc falt_lb_codi static; cn "codigo:    "; cc falt_tx_codi edit; bin z;
bin h; cc falt_lb_nomb static; cn "nombre:    "; cc falt_tx_nomb edit; bin z;
bin h; cc falt_lb_marc static; cn "marca:     "; cc falt_cl_marc combolist; bin z;
bin h; cc falt_lb_cost static; cn "costo:     "; cc falt_tx_cost edit; bin z;
bin h; cc falt_lb_porc static; cn "porcentaje:"; cc falt_tx_porc edit; set falt_tx_porc text 0.3; bin z;
cc falt_bt_palt button; cn "agregar";
groupboxend;
bin s;
groupbox marcas;
bin h; cc falt_lb_prov static; cn "nombre:    "; cc falt_tx_prov edit; bin z;
cc falt_bt_malt button; cn "agregar";
groupboxend;
bin s;
)

falt_init=: 3 : 0
 'IDX PROV'=: {:"1 jd'read provcodi,provnomb from prov'
 wd'set falt_cl_marc items ',,LF,.~PROV
)

main_falt_bt_palt_button=: 3 : 0
 if. *./0<#&> falt_tx_codi;falt_tx_nomb;falt_cl_marc;falt_tx_cost;falt_tx_porc do.
  jd'insert prod';'prodcodi';(".falt_tx_codi);'prodnomb';falt_tx_nomb;'prodprov';(IDX{~PROV i. falt_cl_marc);'prodcost';(".falt_tx_cost);'prodporc';".falt_tx_porc
  wd'set falt_tx_codi text ""'
  wd'set falt_tx_nomb text ""'
  wd'set falt_tx_cost text ""'
  wd'set falt_tx_porc text 0.3'
  wd'set falt_tx_codi focus'
 end.
)

main_falt_bt_malt_button=: 3 : 0
 if. *./0<#falt_tx_prov do.
  jd'insert prov';'provnomb';falt_tx_prov;'provcodi';_1
  jd'update prov';(jd'key prov';'provcodi';_1);'provcodi';{.>{:"1 jd'read jdindex from prov where provcodi=_1'
  wd'set falt_tx_prov text ""'
  wd'set falt_tx_prov focus'
  falt_init''
 end.
)