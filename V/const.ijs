SUMTOP =: 'read tot:sum pg by cl from VIAJ where aa=%d and mm=%d order by tot desc'
SUMDMA =: 'read sum pg by dd,mm,aa from VIAJ where aa=%d and mm=%d'
SUMAM  =: 'read sum pg from VIAJ where aa=%d and mm=%d'
SUMAMD =: SUMAM,' and dd=%d'
SUMCAMD=: 'read from VIAJ where aa=%d and mm=%d and dd=%d'
PRECAM =: 'read pr from PREC where aa=%d and mm=%d'
SUMDD  =: 'read sum pg by dd from VIAJ where aa=%d and mm=%d'
PRECAM =: 'read pr from PREC where aa=%d and mm=%d'
HISTAM =: 'read from HIST where aa=%d and mm=%d'
HISTAMD=: 'read pr from HIST where aa=%d and mm=%d and dd=%d'
AHORAMD=: 'read max ahaa,max ahmm,max ahdd,last ahmo by ahix,AHORL.ahly,AHORL.ahmo from AHORH,AHORH.AHORL'

MO=: 'ARS',:'USD'

MN=: _ 31 28 31 30 31 30 31 31 30 31 30 31

NB. graphs constants

STAT_RAD=: 200

GSUM_Y=: 50 250
GSUM_WIDTH=: 25

GAHO_Y=: 50 250
GAHO_X=: 50

GRPH_Y=: 50 250
GRPH_X=: 50
GRPH_WIDTH=: 20