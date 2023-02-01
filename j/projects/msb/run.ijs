load'data/jd ',;DIRECTORY&,&.>'fcob.ijs ';'fcue.ijs ';'fprod.ijs ';'falt.ijs '
jdadmin'fiam'

MAIN=: 3 : 0
 wd'fontdef Monospace 12;pc main closeok;pn "MSB";cc opes tab'
 wd&> FCOB;FCUE;FPRO;FALT
 wd'tabend;pshow fullscreen'
 fcob_init''
 fcue_init''
 fpro_init''
 falt_init''
)

main_opes_select=: 3 : 'fcob_focus`fcue_focus`fpro_focus`0:@.(".opes_select)0'

MAIN''