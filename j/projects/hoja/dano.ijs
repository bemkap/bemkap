load'media/imagekit gl2'
coinsert'jgl2'

NB. funciones
HUE=: rgb_to_i 0 0 255,0 255 0,:255 0 0
MHUE=: rgb_to_i 0 0 0,:255 255 255
d=: +/@:*:@:-"1
C=: 0 0 255,0 255 0,:255 255 255
cat=: 3 : 'C&((i.<./)@:d)"1 y'
boxtoitem=: ' ' joinstring ('"','"',~,@:":)&.>
I=: 0$PREV=: OFFSET=: 2{.SEL=: 0 0 0 0
fnl=: 3 : '(2|(i.1{$y)I.~(i.&1,i:&1))"1]1000<2 d/\"2 y'
bb=: fnl <. [:|:[:fnl (1 0 2&|:)

NB. definicion formulario
WIN_DANO=: 0 : 0
 bin vhv;
 maxwh 400 1000; cc dano_arch listbox; set dano_arch font Terminus 12;
 cc dano_open button; set dano_open text "Elegir carpeta";
 cc dano_calc button; set dano_calc text "Calcular"; bin z; 
 groupbox Original; cc dano_comp isidraw; groupboxend;
 groupbox Recorte; cc dano_orig isidraw; groupboxend;
 bin v; cc lab1 static; set lab1 text "Muestra"; maxwh 128 128; cc dano_mues isidraw; bin szzh;
 groupbox Máscara; cc dano_masc isidraw; groupboxend;
 groupbox "Vista coloreada"; cc dano_colo isidraw; groupboxend;
 groupbox "Vista agrupada"; cc dano_grou isidraw; groupboxend;
 bin vhs; cc dano_porc static; set dano_porc text Porcentaje de daño: _; bin sz;
)

NB. eventos
win_dano_open_button=: 3 : 0
 DIR=: wd'mb dir "carpeta" "."'
 wd'set dano_arch items ',boxtoitem {."1 ] 1!:0 DIR,'/*.jpeg'
)

win_dano_arch_button=: 3 : 'comppaint I=: read_image_raw DIR,''/'',dano_arch'

win_dano_comp_mbldown=: 3 : 0
 if. 6{".sysdata do. muespaint C=: (<.(+/%#) i_to_rgb glqpixels 10 10,~_10+0 1{".sysdata)1}C
 else. SEL=: ,~0 1{".sysdata end.
)

win_dano_comp_mblup=: 3 : 0
 if. (0<#I)*.1000<*/(>./-<./)_2]\SEL do.
  glsel'dano_comp'
  if. 0 0 0 0-:SEL do. 'PD D'=: (,;0 0,1 0{$)I
  else. PD=: glqpixels D=. 2 2 _4 _4+(<.,>.-<.)/_2]\SEL end.
  glclear glsel'dano_orig'
  glpaint glpixels 0 0,(2}.D),PD
  mascpaint PD=: (3 2{D)$PD
 end.
)

win_dano_comp_mmove=: 3 : 0
 if. 4{".sysdata do. comppaint SEL=: (0 1{".sysdata)(2 3})SEL
 elseif. 8{".sysdata do. comppaint OFFSET=: ($I)<.0>.OFFSET-(0 1{".sysdata)-PREV end.
 PREV=: 0 1{".sysdata
)

win_dano_masc_mbldown=: 3 : 0
 glsel'dano_masc'
 glbrush glpen 0:glrgb 255 255 255
 glpaint glellipse (_10+0 1{".sysdata),20 20
 BB=: ($BB)$1<.MHUE i. glqpixels 0 0,(1 0{$BB)
)

win_dano_masc_mmove=: 3 : 'if. 4{".sysdata do. win_dano_masc_mbldown'''' elseif. 8{".sysdata do. win_dano_masc_mbrdown'''' end.'

win_dano_masc_mbrdown=: 3 : 0
 glsel'dano_masc'
 glbrush glpen 0:glrgb 0 0 0
 glpaint glellipse (_10+0 1{".sysdata),20 20
 BB=: ($BB)$1<.MHUE i. glqpixels 0 0,(1 0{$BB)
)

win_dano_calc_button=: groupaint@:colopaint bind ''

NB. paint de cada isidraw
mascpaint=: 3 : 0
 glclear glsel'dano_masc'
 glpaint glpixels 0 0,(1 0{$PD),MHUE{~,BB=: bb i_to_rgb PD
)

comppaint=: 3 : 0
 if. 0<#I do.
  glclear glsel'dano_comp'
  glpixels 0 0,((1 0{$),,)({:OFFSET)}.({.OFFSET)}."1 I
  glpen 3:glrgb 0 255 255
  glpaint glrect (<.,>.-<.)/_2]\SEL
 end.
)

colopaint=: 3 : 0
 wh=. glqwh glclear glsel'dano_colo'
 B=. ($PD)$,(,BB)}PD,:~&,($PD)$rgb_to_i 0 0 255
 glpixels 0 0,(wh=. 1 0{$B),J=: ,/HUE{~CT=. cat i_to_rgb B 
 wd'set dano_porc text Porcentaje de daño: ','%',~,":100%~<.10000*({:%+/)@:(1&=,&(+/)2&=)@:,CT
 glpaint glrect 0 0,wh
)

groupaint=: 3 : 0
 wh=. glqwh glclear glsel'dano_grou'
 glpixels 0 0,(wh=. 1 0{$PD),((/:~ J #~ J e. }.HUE))(I. J e. }.HUE)}J
 glpaint glrect 0 0,wh
)

muespaint=: 3 : 0
 glsel'dano_mues'
 glbrush glrgb 1{C
 glpaint glrect 0 0 128 128
)