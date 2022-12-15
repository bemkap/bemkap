DIR=: '/home/bemkap/doc/b/V/'
MES=: ;:'feb mar abr may jun jul ago sep oct nov dic'
G=: 'b'&fread&.>DIR&,&.>MES
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
hdr=: ((6:I.@:=]),#)@:(7(#~*)@:|(+i.))

FORM=: 0 : 0
 pc main closeok;
 fontdef Terminus 14 bold;
 bin vh;
 bin v; cc meses listbox; cc save button; bin z;
 minwh 1600 1;cc reg editm;
 bin z;
 minwh 1 140; cc summary static center sunken; set summary text "";
 bin hh;
 minwh 1 256; cc history static center sunken; set history text "";
 cc clientes static left sunken; set clientes text "";
 bin z;
 cc tops static left sunken; set tops text "";
 pshow;
)

main_meses_button=: 3 : 0
 F=: 'b'fread DIR,meses
 V=: {.CFG=: ".&>{.F
 prop=: 0.25(}.}:CFG)}1#~{:CFG
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
 wd'set reg text ',;,&LF&.>(":CFG);F
 wd'set summary text ',,LF,.~summary
 wd'set tops text ',,LF,.~>,&.>/"1 top,&.><'   '
 wd'set history text ',,LF,.~hist
 wd'set clientes text ',,LF,.~>,&.>/"1 (_7]\ CL),&.><'   '
)

main_save_button=: 3 : 0
 reg fwrite DIR,meses
 main_meses_button''
)

wd FORM
wd'set meses items ',boxtoitem MES
wd'set meses select ',":<:#MES
main_meses_button meses=: >{:MES