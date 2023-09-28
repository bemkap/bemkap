DIR=: '/home/bemkap/doc/b/V/'
load'gl2 plot graph format/printf web/gethttp jd ',DIR,'const.ijs ',DIR,'fun.ijs'
coinsert'jgl2'
'AA MM DD'=: _2000 0 0+3{.6!:0''
IN=: 0

jdadmin'vwd'
wd FORM=: fread DIR,'FORM1'

upd_clientes=: 3 : 0
 PG=. (<"0]4 1{::Q)(CL i. <"1&>1{3{Q=. jd SUMCAMD sprintf AA,MM,DD)}a:{.~#CL
 set_table_data 'clientes';boxtoitem'%6s\n%6d'&(<@:sprintf)"1]72{.CL,.PG
)

upd_summary=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 prom=. (~./:~(+/%#)/.&(1{::Q))6=weekday(2000+AA),.MM,.0{::Q
 proy=. (parc=. +/1{::Q)++/(prom{~6=weekday)(#~0<weekday)(2000+AA),.MM,.(#~(>./0{::Q)&<)>:i.MM{MN
 T=. (proy;parc),~;/,prom,.<.prom%{.P=. 0 1{::jd PRECAM sprintf AA,MM
 SUMH=. ,.&.>/ }."1 jd HISTAM sprintf AA,MM
 SUMV=. ,.&.>/ }."1 jd SUMDMA sprintf AA,MM
 TOTD=. +/((_1{<.@%/*2=#)/.~3&{."1){.SUMV,&>SUMH
 wd'set summary text ','prec    %9d\n\nprom    %6d %2d\nprom_s  %6d %2d\nproy    %9d\nparc    %9d\ntotd    %9d' sprintf P;T,<TOTD
)

upd_ahorro=: 3 : 'upd_total >,.&.>/<"_1&.>{:"1 jd''read from AHOR'''

upd_total=: 3 : 0
 if. 0=#D=. 0 1{::jd HISTAMD sprintf AA,MM,DD do. D=. {:jd'get HIST pr' end.
 wd'set ahorro shape %d 3' sprintf #y
 wd'set ahorro data ',boxtoitem, 1&(10&":&.> ixapply)"1 y
 wd'set ahorro protect ',":,(#y)#,:1 0 1
 wd'set ahorro align 2'
 wd'set cotizacion text USD=',' ARS',~":D
 wd'set total text ','%d ARS  ~  %d USD' sprintf <.(,%&D)+/(1&{::*(D,1000){~'ARS'-:>@:{:)"1 y
)

upd_pago=: 3 : 0
 wd'set pago shape 6 2'
 wd'set pago type ',":,6 2$100 0
 wd'set pago data ',boxtoitem,(<0),.'monotributo';'ingresos brutos';'personal';'seguro auto';'seguro crypton';'seguro smash'
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

main_resize=: 3 : 'upd_pago upd_summary stat_paint grph_paint gsum_paint upd_ahorro upd_cal upd_meses upd_clientes CL=: /:~~.<"1]0 1{::jd''read cl from VIAJ'''

main_meses_mbldbl=: 3 : 'upd_summary stat_paint grph_paint gsum_paint upd_cal ''AA MM''=: 21 0+".meses'

main_meses_mbrdbl=: 3 : 0
 I=. wd'mb input int "" "" %d 0 99999 1' sprintf 0:^:(0=#)0 1{::jd PRECAM sprintf am=. 21 0+".meses
 if. 0<O=. ".`0:@.(0=#)I do. jd'upsert PREC ';'aa mm';'aa';({.am);'mm';({:am);'pr';O end.
)

stat_paint=: 3 : 0
 C=. glpre glsel'stat'
 glpen 0
 glbrush glrgb hueRGB 0.6
 glellipse (_120+C),240 240
 A=. -2p1*0,+/\(%+/)1 1{::Q=. jd SUMTOP sprintf AA,MM
 for_i. i.#P=. |.((_120+C),240 240)&,"1 C([,+)"1<.100*(cos,.sin)A do.
  glbrush glrgb hueRGB 0.6+0.2*(>:i)%#P
  glpie i{P
 end.
 if. IN do.
  glrect (XY=. 2{.".sysdata),105 _30
  L=. {.,.&(;/)&>/}."1 Q
  T=. (L{~_1+i.&0)A>(-2p1*0&<)atan2 j./XY-C
  S=. +/1 1{::Q
  glfont'Terminus 10'
  (XY+5 _30) textxy '%12s' sprintf <0{::T
  (XY+5 _15) textxy '%5d %05.2f%%' sprintf (1{::T);100*S%~1{::T
 end.
 glpaint''
)

main_stat_mmove=: 3 : 'stat_paint IN=: (*:120)>+/*:(-:glqwh'''')-2{.".sysdata'

gsum_paint=: 3 : 0
 Q=. jd SUMDD sprintf AA,MM
 T=. (7$0)(~.W)}~(W=. weekday(2000+AA),.MM,.0 1{::Q)(+/%#)/.1 1{::Q
 glpre glsel'gsum'
 glbrush glrgb 0 0 196
 glrect"1 (<.-.(%160%~>./)T),.~,&230 25"0]40*2+i.7
 glfont'Terminus 12'
 gltextcolor glrgb 255 255 255
 glpaint 90 240 textxy 'D    L    M    M    J    V    S'
)

grph_paint=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 M=. >./;T=. (1{::Q)</.~0 6 e.~weekday(2000+AA),.MM,.0{::Q
 glpre glsel'grph'
 glpen 2:glrgb 0 0 0
 gllines 65 60 65 260,(75+35*<:>./#&>T),260
 glpen 3
 gllines ,(,.~70+35*i.@:#)Y=. <.60+200*1-M%~0{::T
 glfont'Terminus 12 bold'
 (5,_6+<./Y) textxy '%6d' sprintf (0{::T){~(i.<./)Y
 5 254 textxy '     0'
 glpaint gllines ,(,.~70+35*i.@:#)<.80+200*1-M%~1{::T
)

main_cal_mbldbl=: 3 : 'upd_clientes DD=: ".2{.wd''get cal cell '',cal'

main_clientes_mbldbl=: 3 : 0
 I=. ".wd'mb input int "" "" 0 0 99999 1'
 wd'set clientes block ',clientes
 wd'set clientes data ',boxtoitem <'%6s\n%6d'sprintf(6{.wd'get clientes cell ',clientes);I
)

main_save_button=: 3 : 0
 jd'delete VIAJ ';'aa';AA;'mm';MM;'dd';DD
 T=. ,_6&(0".{.);._2 D=. wd'get clientes table'
 jd'insert VIAJ';'aa';(C#AA);'mm';(C#MM);'dd';(DD#~C=. +/0<T);'cl';((0<T)#2 3 4 5&{;._2 D);'pg';(#~0&<)T
 upd_summary grph_paint gsum_paint upd_meses upd_cal''
)

main_upd_button=: 3 : 0
 D=. gethttp'https://dolarhoy.com/i/cotizaciones/dolar-blue'
 D=. (+%2:)&".&>/(3{;:)&>0 2{(<;.1~('<p>'&E.+.'</p>'&E.))D
 upd_total 1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
 jd'upsert HIST';'aa mm dd';'aa';AA;'mm';MM;'dd';DD;'pr';D
)

main_sape_button=: 3 : 0
 jd'delete AHOR'
 jd 50 A. 'insert AHOR';'ly';'mn';'mo';>&.>,&.>/<&.>1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
)

main_ahorro_change=: 3 : 'upd_total 1&(".&.>ixapply)"1]_3[\<;._2 wd''get ahorro table'''

main_close=: wd bind 'pclose'