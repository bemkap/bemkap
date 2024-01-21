SUMDMA =: 'read sum pg by dd,mm,aa from VIAJ where aa,mm=%d,%d'
SUMAM  =: 'read sum pg from VIAJ where aa,mm=%d,%d'
SUMAMD =: 'read sum pg from VIAJ where aa,mm,dd=%d,%d,%d'
SUGAMD =: 'read sum pg from GAST where aa,mm,dd=%d,%d,%d'
SUMGS  =: 'read sum pg from GAST where gs,aa,mm="%s",%d,%d'
SUMDD  =: 'read sum pg by dd from VIAJ where aa,mm=%d,%d order by dd'
SUMTOP =: 'read tot:sum pg by cl from VIAJ where aa,mm=%d,%d order by tot desc'

SUMCAMD=: 'read from VIAJ where aa,mm,dd=%d,%d,%d'
SUMGAMD=: 'read from GAST where aa,mm,dd=%d,%d,%d'
HISTAM =: 'read from HIST where aa,mm=%d,%d'

PRECAM =: 'read pr from PREC where aa,mm=%d,%d'
HISTAMD=: 'read pr from HIST where aa,mm,dd=%d,%d,%d'
HISTDMA=: 'read pr from HIST where dd,mm,aa in %s'

AHORAMD=: 'read max ahaa,max ahmm,max ahdd,last ahmo by ahix,AHORL.ahly,AHORL.ahmo from AHORH,AHORH.AHORL'
AHORL  =: 'read *,AHORL.ahmo from AHORH,AHORH.AHORL'
AHORC  =: 'read count ahmo by ahdd,ahmm,ahaa from AHORH'

MO=: 'ARS',:'USD'

MN=: _ 31 28 31 30 31 30 31 31 30 31 30 31

NB. daytype constants

'DOM SAB OTR'=: i.3

NB. graphs constants

STAT_RAD=: 200

GSUM_Y=: 50 250
GSUM_WIDTH=: 25

GAHO_Y=: 50 250
GAHO_X=: 50

GRPH_Y=: 50 250
GRPH_X=: 50
GRPH_WIDTH=: 20