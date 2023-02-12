load'gl2 plot'
coinsert'jgl2'
DIR=: '/home/bemkap/doc/b/V/'
MES=: ' 'splitstring'0222 0322 0422 0522 0622 0722 0822 0922 1022 1122 1222 0123 0223'
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
hdr=: ((6:I.@:=]),#)@:(7(#~*)@:|(+i.))
COL=: '#000000';'#ffffff';'#ffff00'

FORM=: 0 : 0
 ide hide;
 pc main closeok;
 fontdef Terminus 14;
 bin vhv;
 cc meses listbox;
 cc save button;
 bin z;
 minwh 1600 1;cc reg editm;
 cc tota listbox;
 bin zh;
 maxwh 350 200; cc grph isidraw;
 minwh 1 140; cc summary static center sunken; set summary text "";
 maxwh 1000 200; cc gsum isidraw;
 maxwh 270 200; cc cal table 7 7;
 bin zhh;
 minwh 1 256; cc history static center sunken; set history text "";
 maxwh 380 283; cc clientes table 9 8;
 bin z;
 maxwh 860 283; cc tops table 10 8;
 pshow;
)

main_meses_button=: 3 : 0
 G=: 'b'&fread&.>DIR&,&.>MES
 F=: 'b'fread DIR,meses
 'V CFG'=: ({.;}.)".&>{.F
 prop=: (#~*)0 1 0.25{~CFG
 cls=: 0({"1)_2]\F=: }.F
 CL=: /:~~.;;:&.>;(0({"1)_2]\}.)&.>G
 gpag=: 0({"1)_2]\]
 pag=: ".&.>1({"1)_2]\F
 MAT=: (;pag)(<"1;(,.~&.>i.@#)(}:CL)&i.&.>;:&.>cls)}0$~cls,&#CL
 dia=: +/"1 MAT
 top=: |:_10]\(\:~CL,&.>6&":"0&.>)+/MAT
 prom=: prop(]%&(+/)({.~#))dia
 proy=: prom*+/prop
 
 summary=: ((+/prop)(],'/',[)&(5j2&":)+/prop({.~#)dia),~11":<.prom,(prom%V),proy,:+/dia
 summary=: summary,"1~' ',.~' prom','~prov',' proy',' parc',:' prop'

 SUMA=: +/&.>+/@:".&>L:1(1({"1)_2]\}.)&.>G
 PREC=: {.@:".&.>{.&>G
 DAYP=: (~.t)/:~dia(+/%#)/.~t=. (#~(t{.~#))7|(weekday (1,~|.0 2000+100#.inv".meses))+i.>:(#dia)i.~+/\t=. 0<CFG

 hist=: (SUMA<.@%&.>PREC)(,5&":)&>~PREC(,5&":)&.>~MES(,8&":)&.>SUMA
 wd'set reg text ',;,&LF&.>F
 wd'set reg scroll max'
 wd'set tota items ',boxtoitem <"1 dia,.<.0.5+dia%V
 wd'set summary text ','"',~'"',,LF,.~summary
 wd'set tops data ',boxtoitem ,top
 wd'set history text ',,LF,.~hist
 wd'set clientes data ',boxtoitem 72{.CL
 wd'set clientes rowheight ',":<.283%9
 wd'set clientes protect 1'
 wd'set cal block'
 wd'set cal data ',boxtoitem 49{.,CAL=: }._3<\"1{.>calendar|.0 2000+100#.inv".meses
 wd'set cal block 1 6 0 6'
 wd'set cal foreground ',boxtoitem COL{~42{.CFG,~0#~PAD=: 1 i.~ (<'   ')~:,}.CAL
 wd'set cal protect 1'
 paintgrph''
 paintgsum''
)

main_save_button=: 3 : 0
 ((":V,CFG),LF,reg) fwrite DIR,meses
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

paintgrph=: 3 : 0
 glsel'grph'
 glclear''
 glrgb 59 66 82
 glbrush''
 glrect 0 0 350 200
 glrgb 0 0 128
 glbrush ''
 glrect"1 (-(<.@%(160%~>./))DAYP),.~25,.~180,.~80+40*i.6
 glfont'Terminus 12 bold'
 gltextxy 30 170
 gltext'   0'
 gltextxy 30,170-<.(>./DAYP)%~160*5000
 gltext'5000'
 gltextxy 30 10
 gltext":<.>./DAYP
 gllines 70 10 70 180 310 180
 gltextxy 90 182
 gltext'L    M    M    J    V    S'
 glpaint''
)

paintgsum=: 3 : 0
 glsel'gsum'
 glclear''
 glrgb 59 66 82
 glbrush''
 glrect 0 0 1000 200
 glrgb 0 0 0
 glpen 2
 gllines ,(60+35*i.#dia),.180-160(<.@*(%>./))dia
 glpen 1
 gllines 50 20 50 180,(70+35*<:#dia),180
 glfont'Terminus 12 bold'
 gltextxy 10 170
 gltext'   0'
 gltextxy 10,170-<.(>./dia)%~160*5000
 gltext'5000'
 gltextxy 10 10
 gltext":<.>./dia
 glpaint''
)

wd FORM
wd'set meses items ',boxtoitem MES
wd'set meses select ',":<:#MES
main_meses_button meses=: >{:MES