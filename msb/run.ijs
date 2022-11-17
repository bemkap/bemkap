load'data/jd ',;DIRECTORY&,&.>'fcob.ijs ';'fcue.ijs ';'fprod.ijs '
jdadmin'fiam'

MAIN=: 3 : 0
 wd'fontdef Monospace 12;'
 wd'pc main closeok;pn "MSB"'
 wd'cc opes tab'
 wd'tabnew COBRO'
 wd FCOB
 fcob_init''
 wd'tabnew CUENTAS'
 wd FCUE
 fcue_init''
 wd'tabnew PRODUCTOS'
 wd FPRO
 wd'tabend'
 wd'pshow fullscreen'
)

main_resize=: 3 : 0
 main_fcob_tb_cobr_change''
 main_fcue_tb_cuen_change''
 main_tb_prod_change''
)

MAIN''