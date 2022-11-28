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

main_opes_select=: 3 : 0
 select. ".opes_select
  case. 0 do. fcob_focus''
  case. 2 do. fpro_focus''
 end.
)

MAIN''