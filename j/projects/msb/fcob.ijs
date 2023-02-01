FCOB=: 0 : 0
tabnew COBRO;
bin hv;
cc fcob_tb_cobr table 50 6; set fcob_tb_cobr hdr > codigo # producto pr.unid pr.total;
bin h;
cc fcob_cb_cuen checkbox; cn en cuenta:;
cc fcob_cl_cuen combolist; set fcob_cl_cuen enable 0;
bin zh;
cc fcob_lb_codi static; cn codigo ; cc fcob_tx_codi edit;
bin z;
cc fcob_stat statusbar;
set fcob_stat font Monospace 10;
set fcob_stat addlabel fcob_help;
set fcob_stat setlabel fcob_help " b: buscar producto  <enter><enter>: terminar venta  -<numero de linea>: eliminar producto";
bin zvs;
minwh 320 1; cc fcob_lb_tota static; cn Total; set fcob_lb_tota alignment center; set fcob_lb_tota font monospace 32;
minwh 320 1; cc fcob_lb_totb static; set fcob_lb_totb alignment center; set fcob_lb_totb font monospace 32;
bin s;
)

fcob_init=: 3 : 0
 wd'set fcob_tb_cobr data ""'
 wd'set fcob_cl_cuen items ',boxtoitem'elegir cuenta';{."1 ] 1!:0 jpath CUENTAS,'*'
 wd'set fcob_tb_cobr protect ',":,50 6$1
 wd'set fcob_tb_cobr colwidth ',":<.1r32 1r6 1r6 2r6 1r6 1r6*_400+2{".wd'qscreen'
 wd'set fcob_tb_cobr align ',":,50 6$2 2 2 0 2 2
 wd'set fcob_lb_totb text 0.00'
 wd'set fcob_cl_cuen select 0; set fcob_cl_cuen enable 0; set fcob_cb_cuen 0'
 fcob_focus''
 D=: 0 2$0
 COBRAR=: TOTAL=: 0
)

fcob_focus=: 3 : 0
 wd'set fcob_tx_codi focus'
)

main_fcob_tx_codi_button=: 3 : 0
 if. *./' '=fcob_tx_codi do.
  if. COBRAR=: -.COBRAR do. wd'set fcob_stat show "OTRA VEZ PARA TERMINAR" 1000'
  else. fcob_init (' ',~12":TOTAL,~DBASE#.x:5{.6!:0'') fappend jpath CUENTAS,fcob_cl_cuen end.
  return.
 end.
 NB.if. '-'e.fcob_tx_codi do. D=: x:(I{.D),D}.~>:I=. (#D)|<:".`0:@.(''&-:) fcob_tx_codi (>:@:i.}.[) '-'
 if. '-'e.fcob_tx_codi do. D=: D#~0((<:#D)<.((#D)"_)^:(''&-:)<:1".(#~'-'&~:)fcob_tx_codi)}1#~#D
 else. D=: x:D,|.(".&>,~1:)`(".&>)@.(<:@:#) '+' splitstring fcob_tx_codi end.
 T=. {:"1@:jd"1 ('read prodnomb,prodcost,prodporc from prod,prod.prov where prodcodi=',":@:{.)"1 D NB. read
 T=. (,.(1&{*&.>{:)"1)(<"0 D),"1({.,(*>:)&.>/@:}.)"1 T NB. completa columnas
 T=. (#~a:&~:@:{:"1) T NB. saca filas vacias
 T=. ({."1,.(6j2":&.>1{"1]),.(2&}."1))T NB. formato celdas
 E=. boxtoitem,TEST=: 50{.(,.~<"0@:>:@:i.@:#)T
 wd'set fcob_tb_cobr data ',E
 wd'set fcob_lb_totb text ',10j2":TOTAL=: +/;{:"1 T
 wd'set fcob_tx_codi text ""'
 wd'set fcob_tx_codi focus'
 wd'set fcob_tb_cobr colwidth ',":<.1r32 1r6 1r6 2r6 1r6 1r6*_400+2{".wd'qscreen'
)

main_fcob_tx_codi_char=: 3 : 0
 if. sysdata='b' do. fpro_focus wd'set opes active 2' end.
)

main_fcob_cb_cuen_button=: 3 : 0
 wd'set fcob_cl_cuen enable ',fcob_cb_cuen
)