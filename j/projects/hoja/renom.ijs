NB. <image> sc <to>
sc=: 4 : 0
 p=. ($x)%y
 |:(|:x{"_ 1~<.({:p)*i.({:y)){"_ 1~<.({.p)*i.{.y
)

WIN_RENOM=: 0 : 0
 bin hv;
 maxwh 512 1000; cc renom_arch listbox; set renom_arch font Terminus 12;
 cc renom_open button; set renom_open text "Elegir carpeta";
 bin zv;
 groupbox Imagen; cc renom_foto isidraw; groupboxend;
 bin h; cc lab2 static; set lab2 text "Nuevo nombre "; cc renom_name edit;
 cc renom_reno button; set renom_reno text "Aplicar cambios";
)

win_renom_open_button=: 3 : 0
 DIR=: wd'mb dir "carpeta" "."'
 FS=: a:#~#RS=: {."1 ] 1!:0 DIR,'/*.jpeg'
 wd'set renom_arch items ',boxtoitem RS
 SEL=: 0
)

win_renom_arch_button=: 3 : 'fotopaint read_image_raw DIR,''/'',>RS{~SEL=: ".renom_arch_select'

win_renom_name_button=: 3 : 0
 FS=: (<renom_name)(SEL)}FS
 wd'set renom_arch items ',boxtoitem (],'  -->  ',[)&.>^:(a:~:[)/"1 FS,.RS
 wd'set renom_arch select ',":SEL=: (#FS)| >:SEL
 wd'set renom_name select'
 fotopaint read_image_raw DIR,'/',>SEL{RS
)

win_renom_reno_button=: 3 : 0
 N=. ,&'.jpeg'&.>((,'-',":)&.>(}:+/@:={:)\)(#~a:&~:)FS
 N=. N(I.a:~:FS)}RS
 ((DIR,'/')&,&.>N) frename&> ((DIR,'/')&,&.>RS)
 FS=: a:#~#RS=: {."1 ] 1!:0 DIR,'/*.jpeg'
 wd'set renom_arch items ',boxtoitem RS
 SEL=: 0
)

fotopaint=: 3 : 0
 glsel'renom_foto'
 glpaint glpixels 0 0,(1 0{$y),,y=. y sc |.glqwh''
)
