load'gl2 plot format/printf'
coinsert'jgl2'
DIR=: '/home/bemkap/doc/b/V/'
MES=: /:~ {."1 ] 1!:0 <'/home/bemkap/doc/b/V/*.basic'
NMES=: ;:'ene feb mar abr may jun jul ago sep oct nov dic'
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
hdr=: ((6:I.@:=]),#)@:(7(#~*)@:|(+i.))
COL=: '#000000';'#ffffff';'#ffff00'
file2my=: |.@:(2000 0+100#.inv".)@:(4&{.)
IHIST=: 0

FORM=: 0 : 0
 ide hide;
 pc main closeok;
 fontdef Terminus 14;
 bin vhv;
 cc MESES static panel;
 cc meses listbox;
 cc save button;
 bin zv;
 cc DIAS static panel;
 cc tota listbox;
 bin z;
 minwh 1300 1;cc reg editm;
 bin v; cc AHORRO static panel;
 minwh 300 1;cc aho table;
 cc tot static center;
 cc sape button;
 bin zzh;
 maxwh 350 200; cc grph isidraw;
 minwh 1 140; cc summary static center sunken; set summary text "";
 maxwh 1000 200; cc gsum isidraw;
 maxwh 270 200; cc cal table 7 7;
 bin zhh;
 maxwh 385 294; cc clientes table 9 8;
 bin z;
 maxwh 865 294; cc tops table 9 8;
 bin v;
 maxwh 615 150; cc history table 3 13;
 maxwh 615 135; cc stat static center sunken; set stat text "";
 bin z;
 pshow;
)

main_meses_button=: 3 : 0
 G=: 'b'&fread&.>DIR&,&.>MES
 CL=: /:~~.;;:&.>;(0({"1)_2]\}.)&.>G
 FL=: 'b'fread DIR,MES{::~".meses_select
 'V CFG'=: ({.;}.)".&>{.FL
 prop=: (#~*)CFG						NB. tipo de dia
 cls=: 0({"1)_2]\F=: }.FL					NB. clientes del dia
 pag=: ".&.>1({"1)_2]\F						NB. pago del dia
 IX=. <"1;(,.~&.>i.@#)CL&i.&.>;:&.>cls
 MAT=: (IX+//.;pag)(~.IX)}0$~cls,&#CL                           NB. matriz dia x cliente
 dia=: +/"1 MAT							NB. total del dia
 top=: |:_9]\(\:~CL,&.>6&":"0&.>)+/MAT				NB. tabla de tops
 prom=: prop(~.@:[/:~2{.({.~#)(+/<.@:%#)/.])dia			NB. promedio normal sabado
 proy=: +/prom{~2=prop						NB. proyeccion mes

 summary=: 'prom      %5d %2d\nprom_s    %5d %2d\nproy        %6d\nparc        %6d' sprintf ;/(<.0 2 1 3{4{.(,%&V)prom),proy,+/dia
 summary=: summary,LF,'prop   ',((+/0 1 0.5{~prop)(],'/',[)&(5j2&":)+/0 1 0.5{~prop({.~#)dia)

 SUMA=: +/&.>+/@:".&>L:1(1({"1)_2]\}.)&.>G			NB. suma total por mes
 PREC=: {.@:".&.>{.&>G						NB. viaje por mes
 DAYP=: (6$0)(~.<:t)}~dia(+/%#)/.~t=. (#~(t{.~#))7|(weekday (1,~|.file2my MES{::~".meses_select))+i.>:(#dia)i.~+/\t=. 0<CFG
 idx=: ((_1 _2022|.@:+file2my)&.>MES)}&(2 12$a:)
 H0=. idx (('k',~":)&.>SUMA<.@%&.><1000)
 H1=. idx PREC
 H2=. idx SUMA<.@%&.>PREC
 HIST=: H0,H1,:H2

 wd'set reg wrap 0'
 wd'set reg text ',;,&LF&.>F
 wd'set reg scroll max'
 wd'set tota items ',boxtoitem <"1 (6":"0 dia),"1~2":"0<.0.5+dia%V
 wd'set summary text ',summary
 wd'set tops data ',boxtoitem ,top
 wd'set tops protect 1'
 wd'set history data ',boxtoitem ((IHIST{'TOTA','PREC',:'CANT');'2022';'2023'),.NMES,IHIST{HIST
 wd'set history protect 1'
 wd'set clientes data ',boxtoitem 72{.CL
 wd'set clientes protect 1'
 wd'set cal block'
 wd'set cal data ',boxtoitem 49{.,CAL=: }._3<\"1{.>calendar|.file2my MES{::~".meses_select
 wd'set cal rowheight ',":<.200%7
 wd'set cal block 1 6 0 6'
 wd'set cal foreground ',boxtoitem COL{~42{.CFG,~0#~PAD=: 1 i.~ (<'   ')~:,}.CAL
 wd'set cal protect 1'
 paintgrph''
 paintgsum''

 'AHC AHM AHL AHD AHI'=: 'b'fread DIR,'ahorro'
 wd'set aho shape ',":(2+#;:AHL),3
 wd'set aho data ',boxtoitem ('USD';0{".AHC),('USC';1{".AHC),(;:AHL),.(' ' splitstring AHD),.((".AHI){;:AHM)
 wd'set tot text ','%d ARS  ~  %d USD' sprintf (;%&(0{".AHC))(".AHD)+/ .*(".AHI){1,".AHC
)

main_save_button=: 3 : 0
 ((":V,CFG),LF,reg) fwrite DIR,MES{::~".meses_select
 main_meses_button''
)

main_sape_button=: 3 : 0
 D=. ,".&>1{"1]_3]\<;._2 wd'get aho table'
 (DIR,'ahorro') fwrite~ }:;(LF,~":)&.>(<2{.D)(0})(<2}.D)(3})'b'fread DIR,'ahorro'
 main_meses_button''
)

main_cal_mbldbl=: 3 : 0
 i=. <:".wd'get cal cell ',":cal
 CFG=: (3|>:i{CFG)(i})CFG
 wd'set cal block 1 6 0 6'
 wd'set cal foreground ',boxtoitem COL{~42{.CFG,~0#~PAD=: 1 i.~ (<'   ')~:,}.CAL
 wd'set cal protect 1'
)

main_clientes_mbldbl=: 3 : 0
 wd'set reg text ',reg,' ',~wd'get clientes cell ',":clientes
 wd'set reg scroll max'
 wd'set clientes protect 1'
)

main_tops_mbldbl=: 3 : 0
 i=. 1 9+/ .*".tops
 belo=. 100%~<.10000*i(}.%&(+/)])sm=. \:~+/MAT
 uniq=. 100%~<.10000*(i{sm)%+/sm
 wd'set stat text ','acum  %6.2f%%\npunt  %6.2f%%' sprintf belo;uniq
)

main_history_mbldbl=: 3 : 0
 if. 0 0-:".history do. main_meses_button IHIST=: 3|>:IHIST end.
)

paintgrph=: 3 : 0
 glsel'grph'
 glclear''
 glrgb 41 53 59
 glbrush''
 glrect 0 0 350 200
 glrgb 0 0 128
 glbrush ''
 glrect"1 (-(<.@%(160%~>./))DAYP),.~25,.~180,.~80+40*i.6
 glfont'Terminus 12 bold'
 gltextxy 25 170
 gltext'    0'
 gltextxy 25,170-<.(>./DAYP)%~160*5000
 gltext' 5000'
 gltextxy 25 10
 gltext 5":<.>./DAYP
 gllines 70 10 70 180 310 180
 gltextxy 90 182
 gltext'L    M    M    J    V    S'
 glpaint''
)

paintgsum=: 3 : 0
 glsel'gsum'
 glclear''
 glrgb 41 53 59
 glbrush''
 glrect 0 0 1000 200
 glrgb 0 0 0
 glpen 2
 gllines ,(60+35*i.#d),.180-160(<.@*(%>./))d=. dia#~1=prop({.~#)dia
 gllines ,(60+35*i.#e),.180-<.160*(>./d)%~e=. dia#~2=prop({.~#)dia
 glpen 1
 gllines 50 20 50 180,(70+35*<:#d),180
 glfont'Terminus 12 bold'
 gltextxy 5 170
 gltext'    0'
 gltextxy 5,170-<.(>./dia)%~160*5000
 gltext' 5000'
 gltextxy 5 10
 gltext 5":<.>./dia
 glpaint''
)

wd FORM
wd'set meses items ',boxtoitem ((NMES{::~<:@:{.),' ',":@:{:)&.>file2my&.> MES
wd'set meses select ',":<:#MES
main_meses_button meses=: >{:MES