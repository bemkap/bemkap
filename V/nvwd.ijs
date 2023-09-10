DIR=: '/home/bemkap/doc/b/V/'
load'gl2 plot graph format/printf web/gethttp jd ',DIR,'const.ijs'
coinsert'jgl2'
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
show=: (;:'hide show')&stringreplace
ixapply=: 1 : '(u x{y)(x})y'
'AA MM DD'=: _2000 0 0+3{.6!:0''

jdadmin'vwd'
wd FORM=: fread DIR,'FORM1'

upd_cal=: 3 : 0
 C=. ".&.>}.{._3<\"1}.&>calendar 2000 0+AA,MM
 T=. SUMAMD&(0 1{::jd@:sprintf)&.>(3{.(AA,MM),,&_1)&.>C
 P=. {.0 1{::jd PRECAM sprintf AA,MM
 set_table_data 'cal';boxtoitem 42{._3([:<'%2d   %3d\n%8d'&sprintf)\(0&-:&>{"0 1,.&a:),(,C),.T,.~&,<.@%&P&.>T
 tops=. jd SUMTOP sprintf AA,MM
 set_table_data 'tops';boxtoitem,|:6 11$66{.,<"1 '%4s %6d'&sprintf"1 ,&<"1 0&>/ }."1 tops
)

upd_clientes=: 3 : 0
 PG=: <@:(0 1{::jd)"1 SUMCAMD&sprintf"1 CL,"0 1 DD;;/AA,MM
 set_table_data 'clientes';boxtoitem'%6s\n%6d'&(<@:sprintf)"1]72{.CL,.PG
)

upd_meses=: 3 : 0
 PBM=. <.@%&1000&.>(0 1{::SUMAM jd@:sprintf ])&.>{(22+i.6);(>:i.12)
 PBM=. (;:'ene feb mar abr may jun jul ago sep oct nov dic'),PBM
 PBM=. PBM,.~,.a:,;/2022+i.6
 set_table_data 'meses';boxtoitem,PBM
)

upd_ahorro=: 3 : 'upd_total >,.&.>/<"_1&.>{:"1 jd''read from AHOR'''

upd_total=: 3 : 0
 wd'set ahorro shape ',":3,~#y
 wd'set ahorro data ',boxtoitem,y
 wd'set cotizacion text USD=',' ARS',~":D=. 0 1{::jd'read from DOLA'
 wd'set total text ','%d ARS  ~  %d USD' sprintf <.(,(%&D))(;1&{"1 y)(+/ .*)&x:(1,D,D){~(;:'ARS USD USC')i.{:"1 y
)

upd_summary=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 prom=. (~./:~(+/%#)/.&(1{::Q))6=weekday(2000+AA),.MM,.0{::Q
 proy=. (parc=. +/1{::Q)++/(prom{~6=weekday)(#~0<weekday)(2000+AA),.MM,.(0{::Q)-.~>:i.MM{MN
 T=. {.0 1{::jd PRECAM sprintf AA,MM
 T=. (proy;parc),~;/,prom,.(<.prom%T)
 P=. 0 1{::jd PRECAM sprintf AA,MM
 wd'set summary text ','prec    %9d\n\nprom    %6d %2d\nprom_s  %6d %2d\nproy    %9d\nparc    %9d' sprintf P;T
)

main_resize=: 3 : 'upd_summary stat_paint grph_paint gsum_paint upd_ahorro upd_cal upd_meses upd_clientes CL=: /:~~.<"1(0 1){::jd''read cl from VIAJ'''

main_meses_mbldbl=: 3 : 'upd_summary stat_paint grph_paint gsum_paint upd_cal ''AA MM''=: 21 0+".meses'

stat_paint=: 3 : 0
 glsel'stat'
 glbrush glrgb 41 53 59
 glrect 0 0,+:C=. -:glqwh''
 glpen 0
 glbrush glrgb hueRGB 0.6
 glellipse (_120+C),240 240
 for_i. i.#P=. |.((_120+C),240 240)&,"1 C([,+)"1<.100*(cos,.sin)-2p1*(#~0.75&>)0,+/\(%+/)1 1{::jd SUMTOP sprintf AA,MM do.
  glbrush glrgb hueRGB 0.6+0.2*(>:i)%#P
  glpie i{P
 end.
 glpaint''
)

gsum_paint=: 3 : 0
 Q=. jd SUMDD sprintf AA,MM
 T=. (7$0)(~.W)}~(W=. weekday(2000+AA),.MM,.0 1{::Q)(+/%#)/.1 1{::Q
 glsel'gsum'
 glbrush glrgb 41 53 59
 glrect 0 0,glqwh''
 glbrush glrgb 0 0 196
 glrect"1 (-(<.@%(160%~>./))T),.~25,.~230,.~80+40*i.7
 glfont'Terminus 12 bold'
 gltextxy 90 240
 glpaint gltext'D    L    M    M    J    V    S'
)

grph_paint=: 3 : 0
 Q=. {:"1 jd SUMDD sprintf AA,MM
 M=. >./;T=. (1{::Q)</.~0 6 e.~weekday(2000+AA),.MM,.0{::Q
 glsel'grph'
 glbrush glrgb 41 53 59
 glrect 0 0,glqwh''
 glrgb 0 0 0
 glpen 2 
 gllines 55 60 55 260,(65+35*<:>./#&>T),260
 gllines ,(,.~60+35*i.@:#)<.60+200*1-M%~0{::T
 glpaint gllines ,(,.~60+35*i.@:#)<.60+200*1-M%~1{::T
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
 jd'delete DOLA'
 jd'insert DOLA ';'mn';D
 upd_total 1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
)

main_sape_button=: 3 : 0
 jd'delete AHOR'
 jd 50 A. 'insert AHOR';'ly';'mn';'mo';>&.>,&.>/<&.>1&(".&.>ixapply)"1]_3]\<;._2 wd'get ahorro table'
)

main_ahorro_change=: 3 : 'upd_total 1&(".&.>ixapply)"1]_3[\<;._2 wd''get ahorro table'''