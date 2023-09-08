set_table_data=: 3 : 0
 wd'set %s block' sprintf {.y
 wd'set %s data %s' sprintf y
 wd'set %s protect 1' sprintf {.y
)
SUMTOP =: 'read tot:sum pg by cl from VIAJ where aa=%d and mm=%d order by tot desc'
SUMAM  =: 'read sum pg from VIAJ where aa=%d and mm=%d'
SUMAMD =: 'read sum pg from VIAJ where aa=%d and mm=%d and dd=%d'
SUMCAMD=: 'read pg from VIAJ where cl="%s" and dd=%d and aa=%d and mm=%d'
PRECAM =: 'read pr from PREC where aa=%d and mm=%d'
SUMDD  =: 'read sum pg by dd from VIAJ where aa=%d and mm=%d'

MN=: _ 31 28 31 30 31 30 31 31 30 31 30 31