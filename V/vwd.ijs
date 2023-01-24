load'gl2'
coinsert'jgl2'
DIR=: '/home/bemkap/doc/b/V/'
MES=: ' 'splitstring'0222 0322 0422 0522 0622 0722 0822 0922 1022 1122 1222 0123'
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
 bin h; cc new button; cc nomb edit; bin zz;
 minwh 1600 1;cc reg editm;
 bin zh;
 maxwh 350 200; cc grph isidraw;
 minwh 1 140; cc summary static center sunken; set summary text "";
 maxwh 270 200; cc cal table 7 7;
 bin zhh;
 minwh 1 256; cc history static center sunken; set history text "";
 maxwh 380 283; cc clientes table 10 8; set clientes colwidth 30; set clientes rowheight 42;
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
 tab=: _10]\]
 CL=: /:~~.;;:&.>;(0({"1)_2]\}.)&.>G
 gpag=: 0({"1)_2]\]
 pag=: ".&.>1({"1)_2]\F
 MAT=: (;pag)(<"1;(,.~&.>i.@#)(}:CL)&i.&.>;:&.>cls)}0$~cls,&#CL
 dia=: +/"1 MAT
 top=: |:tab(\:~CL,&.>6&":"0&.>)+/MAT
 prom=: prop(]%&(+/)({.~#))dia
 proy=: prom*+/prop
 
 summary=: ('~V  ',:' D '),.":dia,:~<.0.5+dia%V
 summary=: summary,'','   prom  ~prov   proy  total        prop',:((+/prop)(],'/',[)&(5j2&":)+/prop({.~#)dia),~' ',~7":<.prom,(prom%V),proy,+/dia

 SUMA=: +/&.>+/@:".&>L:1(1({"1)_2]\}.)&.>G
 PREC=: {.@:".&.>{.&>G

 hist=: (SUMA<.@%&.>PREC)(,5&":)&>~PREC(,5&":)&.>~MES(,8&":)&.>SUMA
 wd'set reg text ',;,&LF&.>F
 wd'set reg scroll max'
 wd'set summary text ',,LF,.~summary
 wd'set tops data ',boxtoitem ,top
 wd'set history text ',,LF,.~hist
 wd'set clientes data ',boxtoitem ,_8]\CL
 wd'set clientes protect 1'
 wd'set cal block'
 wd'set cal data ',boxtoitem 49{.,CAL=: }._3<\"1{.>calendar|.0 2000+100#.inv".meses
 wd'set cal block 1 6 0 6'
 wd'set cal foreground ',boxtoitem COL{~42{.CFG,~0#~PAD=: 1 i.~ (<'   ')~:,}.CAL
 wd'set cal protect 1'
 glclear''
 glrgb 59 66 82
 glbrush''
 glrect 0 0 350 200
 X=. 20+<.330((%*i.@:])#)Y=. <.180*(%>./)dia
 gllines ,X,.200-Y
 glpaint''
)

main_save_button=: 3 : 0
 ((":V,CFG),LF,reg) fwrite DIR,meses
 main_meses_button''
)

main_new_button=: 3 : 0
 (":200,1#~".&>({~(<'   ')&~:i:1:),2}._3<\"1{.>calendar|.0 2000+100#.inv".nomb) fwrite DIR,nomb
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

wd FORM
wd'set meses items ',boxtoitem MES
wd'set meses select ',":<:#MES
main_meses_button meses=: >{:MES