FCOB=: 0 : 0
bin hv;
cc fcob_tb_cobr table 50 5; set fcob_tb_cobr hdr codigo # producto pr.unid pr.total;
bin h;
cc fcob_cb_cuen checkbox; cn en cuenta:;
cc fcob_cl_cuen combolist; set fcob_cl_cuen enable 0;
bin zh;
cc fcob_lb_codi static; cn codigo ; cc fcob_tx_codi edit;
bin zzvs;
minwh 320 1; cc fcob_lb_tota static; cn Total; set fcob_lb_tota alignment center; set fcob_lb_tota font monospace 18;
minwh 320 1; cc fcob_lb_totb static; cn 0.00; set fcob_lb_totb alignment center; set fcob_lb_totb font monospace 18;
bin s;
)

fcob_init=: 3 : 0
 wd'set fcob_cl_cuen items ',,LF,.~>'elegir cuenta';{."1 ] 1!:0 jpath DIRECTORY,'CUENTAS/*'
 wd'set fcob_tb_cobr protect ',":,50 5$0 0 1 1 1
 wd'set fcob_tb_cobr colwidth ',":<.1r6 1r6 2r6 1r6 1r6*_400+2{".wd'qscreen'
 wd'set fcob_tx_codi focus'
 D=: 0 2$0
)

main_fcob_tx_codi_button=: 3 : 0
 if. *./' '=fcob_tx_codi do. return. end.
 if. '-'e.fcob_tx_codi do.
  D=: (I{.D),D}.~>:I=. (#D)|<:".`0:@.(''&-:) fcob_tx_codi (>:@:i.}.[) '-'
 else.
  D=: D,|.(".&>,1:)`(".&>)@.(<:@:#) '+' splitstring fcob_tx_codi
 end.
 E=. }:;('" ',~'"',":@:,)&.>50{.T=. (,.(1&{*&.>{:)"1)(<"0 D),"1{:"1@:jd"1 ('read prodnomb,prodcost from prod,prod.prov where prodcodi=',":@:{.)"1 D
 wd'set fcob_tb_cobr data ',E
 wd'set fcob_lb_totb text ',10j2":+/;{:"1 T
 wd'set fcob_tx_codi text ""'
 wd'set fcob_tx_codi focus'
 wd'set fcob_tb_cobr colwidth ',":<.1r6 1r6 2r6 1r6 1r6*_400+2{".wd'qscreen'
)

main_fcob_cb_cuen_button=: 3 : 0
 wd'set fcob_cl_cuen enable ',fcob_cb_cuen
)