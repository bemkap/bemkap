load'data/jd ',;DIRECTORY&,&.>'fcob.ijs ';'fcue.ijs ';'fprod.ijs ';'falt.ijs '
jdadmin'fiam'

MAIN=: 3 : 0
 wd'fontdef Monospace 12;'
 wd'pc main closeok;pn "MSB"'
 wd'cc opes tab'
 wd'tabnew COBRO'
 wd FCOB
 wd'tabnew CUENTAS'
 wd FCUE
 wd'tabnew PRODUCTOS'
 wd FPRO
 wd'tabnew ALTAS'
 wd FALT
 wd'tabend'
 wd'pshow fullscreen'
 fcob_init''
 fcue_init''
 fpro_init''
 falt_init''
)

NB. debug
NB. main_default=: 3 : '1' NB.smoutput wdq'

main_resize=: 3 : 0
 main_fcue_tb_cuen_change''
 main_tb_prod_change''
)

main_opes_select=: 3 : 0
 select. ".opes_select
  case. 0 do. fcob_focus''
  case. 2 do. fpro_focus''
 end.
)

MAIN''