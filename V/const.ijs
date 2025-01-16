SUMDMA =: 'read sum pg by dd,mm,aa from VIAJ where aa,mm=%d,%d'
SUMAM  =: 'read sum pg from VIAJ where aa,mm=%d,%d'
SUMAMD =: 'read sum pg from VIAJ where aa,mm,dd=%d,%d,%d'
SUGAMD =: 'read sum pg from GAST where aa,mm,dd=%d,%d,%d'
SUMGS  =: 'read sum pg from GAST where gs,aa,mm="%s",%d,%d'
SUMDD  =: 'read sum pg by dd from VIAJ where aa,mm=%d,%d order by dd'
SUGDD  =: 'read sum pg by dd from GAST where aa,mm=%d,%d order by dd'
SUMTOP =: 'read tot:sum pg by cl from VIAJ where aa,mm=%d,%d order by tot desc'
SUMMM  =: 'read sum pg by aa,mm from VIAJ'

SUMAA  =: 'read sum pg by aa,mm,dd from VIAJ'

DDCL   =: 'read dd from VIAJ where mm=%d and aa=%d and cl="%s"'

SUMCAMD=: 'read from VIAJ where aa,mm,dd=%d,%d,%d'
SUMGAMD=: 'read from GAST where aa,mm,dd=%d,%d,%d'
HISTAM =: 'read from HIST where aa,mm=%d,%d order by aa,mm,dd'

PRECAM =: 'read pr from PREC where aa,mm=%d,%d'
HISTAMD=: 'read pr from HIST where aa,mm,dd=%d,%d,%d order by aa,mm,dd'
HISTDMA=: 'read pr,aa,mm,dd from HIST where dd,mm,aa in %s order by aa,mm,dd'

AHORAMD=: 'read max ahaa,max ahmm,max ahdd,last ahmo by ahix,AHORL.ahly,AHORL.ahmo from AHORH,AHORH.AHORL'
AHORL  =: 'read ahdd,ahmm,ahaa,ahix,ahmo,HIST.pr,AHORL.ahmo from AHORH,AHORH.HIST,AHORH.AHORL'
AHORC  =: 'read count ahmo by ahdd,ahmm,ahaa from AHORH'

CNTAM  =: 'read count cl by dd from VIAJ where aa,mm=%d,%d'

REPORT =: 'read dd,mm,aa,pg,ds from VIAJ where cl="%s" and aa,mm=(%d,%d) order by aa,mm,dd'

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

NB. clientes

CLDIM=: 5 12
CLSZ=: 65 45
GSDIM=: 3 4
GSSZ=: 65 45

RETURN_K   =: 239 160 132
BACKSPACE_K=: 239 160 131
DELETE_K   =: 239 160 135