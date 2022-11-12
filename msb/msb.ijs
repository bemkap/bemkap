load'data/jd'
jdadmin'fiam'

FADD=: 0 : 0
fontdef Monospace 14;
pc fadd closeok;pn "MSB";
pmove _1 _1 800 600;
bin vs;
bin hsv;
cc provlabe static; cn "Proveedores";
bin h; cc provnoml static; cn "Nombre  "; minwh 500 1; cc provnomb edit; bin z;
cc provbutt button; cn "Agregar";
bin zszs;
bin hsv;
cc prodlabe static; cn "Productos";
bin h; cc prodcodl static; cn "Codigo  "; minwh 500 1; cc prodcodi edit; bin z;
bin h; cc prodnoml static; cn "Nombre  "; minwh 500 1; cc prodnomb edit; bin z;
bin h; cc prodprol static; cn "Marca   "; cc prodprob button; cn "Buscar"; cc prodprov edit; minwh 300 1; bin z;
cc prodbutt button; cn "Agregar";
bin zszs;

set prodnomb inputmask AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
set prodcodi inputmask 9999999999999999999999999999999999999999;
set prodprov inputmask 999;

pshow;
)

fadd_prodbutt_button=: 3 : 0
 if. 40>#prodcodi do. wd'mb info mb_ok "" "longitud del codigo menor a 40"' return. end.
 if.  0=#prodnomb do. wd'mb info mb_ok "" "sin nombre de producto"' return. end.
 if.  0=#prodprov do. wd'mb info mb_ok "" "sin proveedor"' return. end.
 jd'insert prod';'prod_codi';(".prodcodi);'prod_nomb';prodnomb;'prod_prov';prodprov;'prod_prec';0
)

wd FADD