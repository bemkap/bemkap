DIR=: '/home/bemkap/doc/b/V/'
load'gl2 plot stats graph format/printf web/gethttp jd ',DIR,'const.ijs ',DIR,'fun.ijs'
coinsert'jgl2'
jdadmin DIR,'jd/vwd'

'AA MM DD'=: _2000 0 0+3{.6!:0''
CO=: GS=: CL=: DOLARHOY=: a:
thread=: 0
SHOW=: 0
jdparam=: {:"1@:jd@:sprintf

upd_clientes=: 3 : 0
 IX=. (CL i. <"1&>)1{3{Q=. jd SUMCAMD sprintf AA,MM,DD
 PG=. (<"0&>1{4{Q)IX}a:#~#CL
 set_table_data 'clientes';boxtoitem'%6s\n%6d'&(<@:sprintf)"1]72{.CL,.PG
)

upd_gastos=: 3 : 0
 IX=. (GS i. <"1&>)1{3{Q=. jd SUMGAMD sprintf AA,MM,DD
 PG=. (<"0&>1{4{Q)IX}a:#~#GS
 set_table_data 'gastos';boxtoitem'%6s\n%6d'&(<@:sprintf)"1]9{.GS,.PG
)

upd_summary=: 3 : 0
 T=. (AA,MM)(SAB=daytype)0 col Q=. SUMDD jdparam AA,MM
 prom=. 0 0(~.T)}~T avg/. 1 col Q
 proy=. (parc=. +/1{::Q)++/(prom,0){~2-(AA,MM) daytype DD-.~&(1+i.)MM{MN
 T=. (proy;parc),~;/,prom,.<.prom%{.P=. 0 col PRECAM jdparam AA,MM
 sh=. ,.&.>/ HISTAM jdparam AA,MM
 sv=. ,.&.>/ SUMDMA jdparam AA,MM
 pd=. +/((_1{<.@%/*2=#)/.~3&{."1)sv,&>sh
 pr=. ({.;+/)(0 0.5 1+/@:{~(AA,MM)&daytype)&>DD split >:i.MM{MN
 gana=. >cutLF 'prec%13d\n\nprom%10d %2d\npros%10d %2d\nproy%13d\nparc%13d\npard%13d\n\nprop%8.1f/%4.1f' sprintf P;T,(<pd),pr
 gasta=. 4 A. '',~'%s%8d'&sprintf"1(GS,'tota';'cost'),.(,(+/;+/@:(CO&{))@:;),SUMGS&jdparam"1 GS,"0 1 AA;MM
 wd'set summary text ',,LF,.~gana
 wd'set gummary text ',,LF,.~gasta
)

upd_ahorro=: 3 : 0
 y=. >,.&.>/<"_1&.>2({&MO&.> ixapply)(<1 6 2;1){jd AHORAMD
 wd'set ahorro shape %d 3' sprintf #y
 wd'set ahorro data ',boxtoitem, 1&(10&":&.> ixapply)"1 y
 wd'set ahorro colwidth 1'
 wd'set ahorro protect ',":,(#y)#,:1 0 1
 wd'set ahorro align 2'
 upd_total y
)

upd_total=: 3 : 0
 L=. 6!:0'DD-MM hh:mm:ss'
 wd'set cotizacion text USD=%d ARS\n%s' sprintf L;~D=. {:jd'get HIST pr'
 wd'set total text ','ARS %10d\nUSD %10d' sprintf <.(,%&D)+/(1&{::*(D,1000){~'ARS'-:>@:{:)"1 y
)

upd_tops=: 3 : 0
 set_table_data 'tops';boxtoitem,|:5 13$65{.,<"1(,7&":)"1 0&>/SUMTOP jdparam AA,MM
 wd'set tops align 2'
)

main_tops_mbldbl=: 3 : 0
 upd_cal^:(0<#)<"0]0 col DDCL jdparam MM;AA;4{.wd'get tops cell ',":tops
)

upd_meses=: 3 : 0
 P=. {(22+i.6);(>:i.12)
 T=. (1000<.@%~0 col SUMAM&jdparam)&.>P
 Q=. ((10(%~<.)100%~avg)@:((1 col ])#~[(SAB~:daytype)(0 col ]))SUMDD&jdparam)&.>P
 T=. (Q=<0)}T,:a:$~$T
 Q=. (Q=<0)}Q,:a:$~$T
 T=. ($T)$([:<'%4d\n%4.1f'&sprintf)"1(,T),.(,Q)
 T=. (;:'ene feb mar abr may jun jul ago sep oct nov dic'),T
 T=. T,.~,.a:,;/2022+i.6
 set_table_data 'meses';boxtoitem,T
 wd'set meses align 2'
)

upd_cal=: 3 : 0
 C=. {._3<@:".\"1]2}.&>calendar 2000 0+AA,MM
 T=. (0 col SUMAMD&jdparam)&.>(3{.(AA,MM),,&_1)&.>C
 G=. (0 col SUGAMD&jdparam)&.>(3{.(AA,MM),,&_1)&.>C
 P=. {.0 col PRECAM jdparam AA,MM 
 set_table_data 'cal';boxtoitem 42{._4([:<'%2d   %3d\n%8d\n%8d'&sprintf)\(0&-:&>{"0 1,.&a:),(,G),.~(,C),.T,.~&,<.@%&P&.>T
 if. 0<#y do. wd'set cal background ',boxtoitem (BACK_STR;'#333388'){~,C e. y
 else. stat_paint upd_tops'' end.
)

main_meses_mbldbl=: 3 : 0
 'AA MM'=: 21 0+".meses
 stat_paint grph_paint gsum_paint upd_summary upd_cal''
)

main_meses_mbrdbl=: 3 : 0
 I=. wd'mb input int "" "" %d 0 999999 1' sprintf 0:^:(0=#)0 col PRECAM jdparam am=. 21 0+".meses
 if. 0<O=. ".`0:@.(0=#)I do. jd'upsert PREC ';'aa mm';'aa';({.am);'mm';({:am);'pr';O end.
)

stat_paint=: 3 : 0
 C=. glpre glsel'stat'
 glpen 0
 glbrush glrgb hueRGB 0.6
 glellipse E=. (C-(-:STAT_RAD)),2#STAT_RAD
 A=. -2p1*0,+/\(%+/)1 col Q=. SUMTOP jdparam AA,MM
 for_i. i.#P=. |.E&,"1 C([,+)"1<.(-:STAT_RAD)*(cos,.sin)A do.
  glbrush glrgb hueRGB 0.6+0.2*(>:i)%#P
  glpie i{P
 end.
 if. y do.
  XY=. 2{.".sysdata
  glrect XY,(105*_1^l=. 195<{.XY),_30
  if. 0<#L=. ,.&>/<"_1&.>Q do.
   glfont'Terminus 10'
   (XY+(5-l*105),_30) textxy '%12s' sprintf <0{::T=. (L{~_1+i.&0)A>(-2p1*0&<)atan2 j./XY-C
   (XY+(5-l*105),_15) textxy '%5d %05.2f%%' sprintf (1{::T)([;100*%)+/1 col Q
  end.
 end.
 glpaint''
)

main_stat_mmove=: 3 : 'stat_paint (*:-:STAT_RAD)>+/*:(-:glqwh'''')-2{.".sysdata'

gsum_paint=: 3 : 0
 glpre glsel'gsum'
 Q=. SUMDD jdparam AA,MM
 T=. (7$0)(~.W)}~(W=. weekday(2000+AA),.MM,.0 col Q)avg/.1 col Q 
 glfont'Terminus 12'
 gltextcolor glpen 1:glrgb 128 128 128
 ((+:GSUM_WIDTH),10+{:GSUM_Y) textxy 'D    L    M    M    J    V    S'
 glbrush glrgb 0 0 196
 glpaint glrect"1 ((15+GSUM_WIDTH)*>:i.7),.({:GSUM_Y),.GSUM_WIDTH,.<.-.(%(-~/GSUM_Y)%~>./)T
)

gaho_paint=: 3 : 0
 glpre glsel'gaho'
 Q=. '(',')',~','joinstring~.<"1('(%2d,%2d,%2d)'&sprintf)&>g=. ,.&.>/3{.T=. AHORL jdparam ''
 a=. 3 col AHORC jdparam ''
 P=. 1000%D=. a#0 col HISTDMA jdparam <Q
 h=. *&>/1(({"0 1)&(1000,.D)&.>ixapply)_2{.T
 i=. *&>/1(({"0 1)&(P,.1)&.>ixapply)_2{.T
 p=. 1000%~(>g)+//.h
 m=. >./p,q=. (>g)+//.i
 gltextcolor glpen 1:glrgb 128 128 128
 gllines 0 2 0 3 1 3{GAHO_X,(GAHO_X+#p),GAHO_Y
 gllines"1 ,"2(_3 3+{:GAHO_Y),.~"1 0/GAHO_X+I.2~:/\1&{"1~.&>,.&.>/{:"1 jd'read ahdd,ahmm,ahaa from AHORH'
 glfont'Terminus 10'
 gltextcolor glpen glrgb 255 0 0
 gllines ,(5+GAHO_X+i.#p),.0.5<.@+({.GAHO_Y)+(-~/GAHO_Y)*1-p%m
 (GAHO_X,7+{:GAHO_Y) textxy 'ARS'
 gltextcolor glpen glrgb 0 255 255
 gllines ,(5+GAHO_X+i.#q),.0.5<.@+({.GAHO_Y)+(-~/GAHO_Y)*1-q%m
 glpaint ((25+GAHO_X),7+{:GAHO_Y) textxy 'USD'
)

grph_paint=: 3 : 0
 glpre glsel'grph'
 Q=. SUMDD jdparam AA,MM
 gltextcolor glpen 1:glrgb 128 128 128
 if. __<M=. >./;T=. 2{.(~./:~(1 col Q)</.~])0 6 e.~weekday(2000+AA),.MM,.0 col Q do.
  gllines 0 2 0 3 1 3{GRPH_X,(GRPH_X+(11+GRPH_WIDTH)*>./#&>T),GRPH_Y
  glbrush glrgb 0 0 196
  glrect"1 (,.(({:GRPH_Y)-1&{)"1)GRPH_WIDTH,.~(,.~(GRPH_X+10)+(10+GRPH_WIDTH)*i.@:#)Y=. <.({.GRPH_Y)+(-~/GRPH_Y)*1-M%~0{::T
  glbrush glrgb 0 196 196
  glrect"1 (,.(({:GRPH_Y)-1&{)"1)GRPH_WIDTH,.~(,.~(GRPH_X+10)+(10+GRPH_WIDTH)*i.@:#)    <.({.GRPH_Y)+(-~/GRPH_Y)*1-M%~1{::T
  glfont'Terminus 12'
  gltextcolor glrgb 128 128 128
  ((GRPH_X+(10+GRPH_WIDTH)*2+#0{::T),   GRPH_Y) textxy 'x- = %d' sprintf avg 0{::T
  ((GRPH_X+(10+GRPH_WIDTH)*2+#0{::T),14+GRPH_Y) textxy 'x∽ = %d' sprintf median 0{::T
  ((GRPH_X+(10+GRPH_WIDTH)*2+#0{::T),28+GRPH_Y) textxy 'σ  = %d' sprintf stddev 0{::T
  glpaint ((GRPH_X+(10+GRPH_WIDTH)*2+#0{::T),42+GRPH_Y) textxy 'M  = %d' sprintf >./0{::T
 end.
)

main_cal_mbldbl=: 3 : 'upd_gastos upd_clientes DD=: ".2{.wd''get cal cell '',cal'

main_clientes_mbldbl=: 3 : 0
 I=. ".wd'mb input int "" "" 0 0 999999 1'
 wd'set clientes block ',clientes
 wd'set clientes data ',boxtoitem <'%6s\n%6d'sprintf(6{.wd'get clientes cell ',clientes);I
)

main_gastos_mbldbl=: 3 : 0
 I=. ".wd'mb input int "" "" 0 0 999999 1'
 wd'set gastos block ',gastos
 wd'set gastos data ',boxtoitem <'%6s\n%6d'sprintf(6{.wd'get gastos cell ',gastos);I
)

main_save_button=: 3 : 0
 if. 0<+/T=. ,_6&(0".{.);._2 D=. wd'get clientes table' do.
  jd'delete VIAJ ';'aa';AA;'mm';MM;'dd';DD
  jd'insert VIAJ';'aa';(C#AA);'mm';(C#MM);'dd';(DD#~C=. +/0<T);'cl';((0<T)#2 3 4 5&{;._2 D);'pg';(#~0&<)T
 end.
 if. 0<+/T=. ,_6&(0".{.);._2 D=. wd'get gastos table' do.
  jd'delete GAST';'aa';AA;'mm';MM;'dd';DD
  jd'insert GAST';'aa';(C#AA);'mm';(C#MM);'dd';(DD#~C=. +/0<T);'gs';((0<T)#2 3 4 5&{;._2 D);'pg';(#~0&<)T
 end.
 grph_paint gsum_paint upd_summary upd_meses upd_cal''
)

main_upd_button=: 3 : 0
 try.
  D=. (+%2:)&".&>/(3{;:)&>0 2{(<;.1~('<p>'&E.+.'</p>'&E.))>DOLARHOY
  upd_total 1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
  jd'upsert HIST';'aa mm dd';'aa';AA;'mm';MM;'dd';DD;'pr';D
 catch.
  DOLARHOY=: gethttp t. thread 'www.dolarhoy.com/i/cotizaciones/dolar-blue'
 end.
)

main_sape_button=: 3 : 0
 I=. i.#M=. ".&> 1{"1 T=. _3]\<;._2 wd'get ahorro table' 
 gaho_paint jd'upsert AHORH';'ahaa ahmm ahdd ahix';'ahaa';(AA#~#I);'ahmm';(MM#~#I);'ahdd';(DD#~#I);'ahix';I;'ahmo';M
)

main_ahorro_change=: 3 : 'upd_total _3(1(".&.>ixapply)])\<;._2 wd''get ahorro table'''

main_close=: 3 : 0
 55 T. ''
 wd'pclose'
)

main=: 3 : 0
 wd show^:SHOW FORM=: fread DIR,'FORM1'
 thread=: 0 T. 1
 DOLARHOY=: gethttp t. thread 'www.dolarhoy.com/i/cotizaciones/dolar-blue'
)

main_resize=: 3 : 0
 upd_gastos GS=: /:~'b'fread DIR,'GAST'
 CO=: GS i. 'mono';'naft'
 upd_clientes CL=: /:~'b'fread DIR,'CLIE'
 upd_summary upd_ahorro upd_cal upd_meses''
 gaho_paint stat_paint grph_paint gsum_paint''
)

main''