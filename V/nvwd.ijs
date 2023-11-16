DIR=: '/home/bemkap/doc/b/V/'
load'gl2 plot graph format/printf web/gethttp jd ',DIR,'const.ijs ',DIR,'fun.ijs'
coinsert'jgl2'
jdadmin'vwd'

'AA MM DD'=: _2000 0 0+3{.6!:0''
CL=: DOLARHOY=: a:
thread=: 0

upd_clientes=: 3 : 0
 IX=. (CL i. <"1&>)1{3{Q=. jd SUMCAMD sprintf AA,MM,DD
 PG=. (<"0&>1{4{Q)IX}a:#~#CL
 set_table_data 'clientes';boxtoitem'%6s\n%6d'&(<@:sprintf)"1]72{.CL,.PG
)

upd_summary=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 prom=. 2{.(~./:~(+/%#)/.&(1{::Q))6=weekday(2000+AA),.MM,.0{::Q
 proy=. (parc=. +/1{::Q)++/(prom{~6=weekday)(#~0<weekday)(2000+AA),.MM,.(#~DD&<)>:i.MM{MN
 T=. (proy;parc),~;/,prom,.<.prom%{.P=. 0 1{::jd PRECAM sprintf AA,MM
 SUMH=. ,.&.>/ }."1 jd HISTAM sprintf AA,MM
 SUMV=. ,.&.>/ }."1 jd SUMDMA sprintf AA,MM
 PARD=. +/((_1{<.@%/*2=#)/.~3&{."1){.SUMV,&>SUMH
 PROP=. ({.;+/)+/&>(0.5 0 1{~6 0 i. weekday"1)&.>(((2000+AA),.MM,.])({.;}.)~(1+i.&DD))>:i.MM{MN
 wd'set summary text ','prec    %9d\n\nprom    %6d %2d\nprom_s  %6d %2d\nproy    %9d\nparc    %9d\npard    %9d\n\nprop    %4.1f/%4.1f' sprintf P;T,(<PARD),PROP
)

upd_ahorro=: 3 : 0
 y=. >,.&.>/<"_1&.>2({&MO&.> ixapply)(<1 6 2;1){jd AHORAMD
 wd'set ahorro shape %d 3' sprintf #y
 wd'set ahorro data ',boxtoitem, 1&(10&":&.> ixapply)"1 y
 wd'set ahorro protect ',":,(#y)#,:1 0 1
 wd'set ahorro align 2'
 upd_total y
)

upd_total=: 3 : 0
 L=. 6!:0'DD-MM hh:mm:ss'
 wd'set cotizacion text USD=%d ARS\n%s' sprintf L;~D=. {:jd'get HIST pr'
 wd'set total text ','%d ARS  ~  %d USD' sprintf <.(,%&D)+/(1&{::*(D,1000){~'ARS'-:>@:{:)"1 y
)

upd_tops=: 3 : 'set_table_data ''tops'';boxtoitem,|:6 11$66{.,<"1 ''%4s %6d''&sprintf"1 ,&<"1 0&>/ }."1 jd SUMTOP sprintf AA,MM'

upd_meses=: 3 : 0
 PBM=. <.@%&1000&.>(0 1{::SUMAM jd@:sprintf ])&.>{(22+i.6);(>:i.12)
 PBM=. (;:'ene feb mar abr may jun jul ago sep oct nov dic'),PBM
 PBM=. PBM,.~,.a:,;/2022+i.6
 set_table_data 'meses';boxtoitem,PBM
)

upd_cal=: 3 : 0
 C=. ".&.>}.{._3<\"1}.&>calendar 2000 0+AA,MM
 T=. SUMAMD&(0 1{::jd@:sprintf)&.>(3{.(AA,MM),,&_1)&.>C
 P=. {.0 1{::jd PRECAM sprintf AA,MM
 set_table_data 'cal';boxtoitem 42{._3([:<'%2d   %3d\n%8d'&sprintf)\(0&-:&>{"0 1,.&a:),(,C),.T,.~&,<.@%&P&.>T
 stat_paint upd_tops''
)

main_meses_mbldbl=: 3 : 'stat_paint grph_paint gsum_paint upd_summary upd_cal ''AA MM''=: 21 0+".meses'

main_meses_mbrdbl=: 3 : 0
 I=. wd'mb input int "" "" %d 0 99999 1' sprintf 0:^:(0=#)0 1{::jd PRECAM sprintf am=. 21 0+".meses
 if. 0<O=. ".`0:@.(0=#)I do. jd'upsert PREC ';'aa mm';'aa';({.am);'mm';({:am);'pr';O end.
)

stat_paint=: 3 : 0
 C=. glpre glsel'stat'
 glpen 0
 glbrush glrgb hueRGB 0.6
 glellipse E=. (C-(-:STAT_RAD)),2#STAT_RAD
 A=. -2p1*0,+/\(%+/)1 1{::Q=. jd SUMTOP sprintf AA,MM
 for_i. i.#P=. |.E&,"1 C([,+)"1<.(-:STAT_RAD)*(cos,.sin)A do.
  glbrush glrgb hueRGB 0.6+0.2*(>:i)%#P
  glpie i{P
 end.
 if. y do.
  XY=. 2{.".sysdata
  glrect XY,(105*_1^l=. 195<{.XY),_30
  if. 0<#L=. {.,.&(<"_1)&>/}."1 Q do.
   T=. (L{~_1+i.&0)A>(-2p1*0&<)atan2 j./XY-C
   S=. +/1 1{::Q
   glfont'Terminus 10'
   (XY+(5-l*105),_30) textxy '%12s' sprintf <0{::T
   (XY+(5-l*105),_15) textxy '%5d %05.2f%%' sprintf (1{::T);100*S%~1{::T
  end.
 end.
 glpaint''
)

main_stat_mmove=: 3 : 'stat_paint (*:-:STAT_RAD)>+/*:(-:glqwh'''')-2{.".sysdata'

gsum_paint=: 3 : 0
 Q=. jd SUMDD sprintf AA,MM
 T=. (7$0)(~.W)}~(W=. weekday(2000+AA),.MM,.0 1{::Q)(+/%#)/.1 1{::Q
 glpre glsel'gsum'
 glfont'Terminus 12'
 gltextcolor glpen 1:glrgb 128 128 128
 ((+:GSUM_WIDTH),10+{:GSUM_Y) textxy 'D    L    M    M    J    V    S'
 glbrush glrgb 0 0 196
 glpaint glrect"1 ((15+GSUM_WIDTH)*>:i.7),.({:GSUM_Y),.GSUM_WIDTH,.<.-.(%(-~/GSUM_Y)%~>./)T
)

gaho_paint=: 3 : 0
 glpre glsel'gaho'
 T=. {:"1 jd'read *,AHORL.ahmo from AHORH,AHORH.AHORL'
 g=. >,.&.>/3&{.T
 P=. 1000%D=. , (0 1{::jd)"1 'read pr from HIST where dd=%d and mm=%d and aa=%d'&sprintf"1 g
 h=. *&>/1(({"0 1)&(1000,.D)&.>ixapply)_2{.T
 i=. *&>/1(({"0 1)&(P,.1)&.>ixapply)_2{.T
 p=. 1000%~g+//.h
 m=. >./p,q=. g+//.i
 gltextcolor glpen 1:glrgb 128 128 128
 gllines 0 2 0 3 1 3{GAHO_X,(GAHO_X+2*#p),GAHO_Y
 glfont'Terminus 10'
 gltextcolor glpen glrgb 255 0 0
 gllines ,(5+GAHO_X+2*i.#p),.0.5<.@+({.GAHO_Y)+(-~/GAHO_Y)*1-p%m
 (GAHO_X,5+{:GAHO_Y) textxy 'ARS'
 gltextcolor glpen glrgb 0 255 255
 gllines ,(5+GAHO_X+2*i.#q),.0.5<.@+({.GAHO_Y)+(-~/GAHO_Y)*1-q%m
 glpaint ((25+GAHO_X),5+{:GAHO_Y) textxy 'USD'
)

grph_paint=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 glpre glsel'grph'
 gltextcolor glpen 1:glrgb 128 128 128
 if. __<M=. >./;T=. 2{.(\:#&>)(1{::Q)</.~0 6 e.~weekday(2000+AA),.MM,.0{::Q do.
  gllines 0 2 0 3 1 3{GRPH_X,((15+GRPH_WIDTH)*>./#&>T),GRPH_Y
  glbrush glrgb 0 0 196
  glrect"1 (,.(({:GRPH_Y)-1&{)"1)GRPH_WIDTH,.~(,.~(GRPH_X+10)+(10+GRPH_WIDTH)*i.@:#)Y=. <.({.GRPH_Y)+(-~/GRPH_Y)*1-M%~0{::T
  glbrush glrgb 0 196 196
  glrect"1 (,.(({:GRPH_Y)-1&{)"1)GRPH_WIDTH,.~(,.~(GRPH_X+10)+(10+GRPH_WIDTH)*i.@:#)    <.({.GRPH_Y)+(-~/GRPH_Y)*1-M%~1{::T
  glfont'Terminus 12'
  gltextcolor glrgb 128 128 128
  glpaint ((GRPH_X-55),_6+<./Y) textxy '%6d' sprintf (0{::T){~(i.<./)Y
 end.
)

main_cal_mbldbl=: 3 : 'upd_clientes DD=: ".2{.wd''get cal cell '',cal'

main_clientes_mbldbl=: 3 : 0
 I=. ".wd'mb input int "" "" 0 0 99999 1'
 wd'set clientes block ',clientes
 wd'set clientes data ',boxtoitem <'%6s\n%6d'sprintf(6{.wd'get clientes cell ',clientes);I
)

main_clientes_mbrdbl=: 3 : 0
 wd'set hcli shape 10 4'
 set_table_data 'hcli';boxtoitem 8":&.>,|._10{.&>,.&.>/{:"1 jd'read dd,mm,aa,pg from VIAJ where cl="%s"' sprintf <2}.6{.wd'get clientes cell ',clientes
)

main_save_button=: 3 : 0
 jd'delete VIAJ ';'aa';AA;'mm';MM;'dd';DD
 T=. ,_6&(0".{.);._2 D=. wd'get clientes table'
 jd'insert VIAJ';'aa';(C#AA);'mm';(C#MM);'dd';(DD#~C=. +/0<T);'cl';((0<T)#2 3 4 5&{;._2 D);'pg';(#~0&<)T
 grph_paint gsum_paint upd_summary upd_meses upd_cal''
)

main_upd_button=: 3 : 0
 D=. (+%2:)&".&>/(3{;:)&>0 2{(<;.1~('<p>'&E.+.'</p>'&E.))>DOLARHOY
 upd_total 1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
 jd'upsert HIST';'aa mm dd';'aa';AA;'mm';MM;'dd';DD;'pr';D
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
 wd FORM=: fread DIR,'FORM1'
 thread=: 0 T. 1
 DOLARHOY=: gethttp t. thread 'www.dolarhoy.com/i/cotizaciones/dolar-blue'
)

main_resize=: 3 : 0
 upd_summary upd_ahorro upd_cal upd_meses upd_clientes CL=: <"1/:~~.jd'get VIAJ cl'
 gaho_paint stat_paint grph_paint gsum_paint''
)

main''