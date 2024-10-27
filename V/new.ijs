DIR=: '/home/bemkap/doc/b/V/'
load'gl2 plot stats graph format/printf web/gethttp jd ',DIR,'const.ijs ',DIR,'fun.ijs'
coinsert'jgl2'
jdadmin DIR,'jd/vwd'

'AA MM DD'=: _2000 0 0+3{.6!:0''
CO=: GS=: CL=: DOLARHOY=: a:
NB. thread=: 0
NB. SHOW=: 0
jdparam=: {:"1@:jd@:sprintf

FORM=: 'ide hide;pc w closeok;cc k webview;pshow;'

ixapply=: 1 : (':'; '(u x{y)(x})y')
MO=: 'ARS',:'USD'

tag=: '<%s>%s</%s>' sprintf [;];[
tabi=: 'table'(tag;)(<'tr')tag&.>((,&.>/\<"1)('<td>%s<br><input type="number" value="%d"></td>'&sprintf"1))
tab=: 'table'(tag;)(<'tr')tag&.>(,&.>/\('</td>',~'<td>',":)&.>)
summ=: 3 : 0
 T=. (AA,MM)(SAB=daytype)0 col Q=. SUMDD jdparam AA,MM
 prom=. 0 0(~.T)}~T avg/. 1 col Q
 proy=. (parc=. +/1{::Q)++/(prom,0){~2-(AA,MM) daytype DD-.~&(1+i.)MM{MN
 T=. (proy;parc),~;/,prom,.<.prom%{.P=. 0 col PRECAM jdparam AA,MM
 sh=. ,.&.>/ HISTAM jdparam AA,MM
 sv=. ,.&.>/ SUMDMA jdparam AA,MM
 pd=. +/((_1{<.@%/*2=#)/.~3&{."1)sv,&>sh
 pr=. ({.;+/)(0 0.5 1+/@:{~(AA,MM)&daytype)&>DD split >:i.MM{MN
 G=. <,cutLF'prec\n%d\n\nprom\n%d %d\npros\n%d %d\nproy\n%d\nparc\n%d\npard\n%d\n\nprop\n%3.1f/%3.1f' sprintf P;T,(<pd),pr
 G,<,(GAST,'tota';'cost'),.(,(+/;+/@:(COST&{))@:;),SUMGS&jdparam"1 GAST,"0 1 AA;MM
)
mese=: 3 : 0
 P=. {(22+i.6);(>:i.12)
 T=. (1000<.@%~0 col SUMAM&jdparam)&.>P
 Q=. ((10(%~<.)100%~avg)@:((1 col ])#~[(SAB~:daytype)(0 col ]))SUMDD&jdparam)&.>P
 T=. (Q=<0)}T,:a:$~$T
 Q=. (Q=<0)}Q,:a:$~$T
 T=. ($T)$([:<'%d<br>%4.1f'&sprintf)"1(,T),.(,Q)
 T=. (;:'ene feb mar abr may jun jul ago sep oct nov dic'),T
 ,T,.~,.a:,;/2022+i.6
)
cale=: 3 : 0
 C=. {._3<@:".\"1]2}.&>calendar 2000 0+AA,MM
 T=. (0 col SUMAMD&jdparam)&.>(3{.(AA,MM),,&_1)&.>C
 G=. (0 col SUGAMD&jdparam)&.>(3{.(AA,MM),,&_1)&.>C
 P=. {.0 col PRECAM jdparam AA,MM 
 (;:'dom lun mar mie jue vie sab'),42{._4([:<'%2d   %3d<br>%8d<br>%8d'&sprintf)\(0&-:&>{"0 1,.&a:),(,G),.~(,C),.T,.~&,<.@%&P&.>T
)
html=: 3 : 0
 IX=. (CLIE i. <"1&>)1{3{Q=. jd SUMCAMD sprintf AA,MM,DD
 PG=. (<"0&>1{4{Q)IX}a:#~#CLIE
 TOPS=. ,|:_12]\<"1(,7&":)"1 0&>/SUMTOP jdparam AA,MM
 IX=. (GAST i. <"1&>)1{3{Q=. jd SUMGAMD sprintf AA,MM,DD
 GS=. (<"0&>1{4{Q)IX}a:#~#GAST
 AHOR=. ,;,.&.>/<"1&.>1('<input type="number" value="%d">'&sprintf"0&.>ixapply)2({&MO&.>ixapply)(<1 6 2;1){jd AHORAMD
 'SUM1 SUM2'=. summ''
 'set k html *',y sprintf STYL;(_12 tabi CLIE,.PG);(_9 tabi GAST,.GS);(_3 tab AHOR);(_2 tab SUM1);(_2 tab SUM2);(_5 tab TOPS);(_13 tab mese'');(_7 tab cale'')
)

STYL=: fread DIR,'style.css'
CLIE=: ,'b'fread DIR,'CLIE'
GAST=: ,'b'fread DIR,'GAST'
COST=: GS i. 'mono';'naft'
HCMD=: html TEMP=: fread DIR,'template.html'

wd FORM
wd HCMD