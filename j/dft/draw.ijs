load'gl2 math/fftw'
coinsert'jgl2'
p=: 0 2$0
WIN=: 0 : 0
 pc win closeok;pn "draw something";
 bin v;
 minwh 250 250;cc grph isigraph;
 bin h;
 cc name edit;
 cc save button;cn "save";
 cc clean button;cn "clean";
 pshow;
)
win_grph_mmove=: 3 : 'glpaint p=: p,~^:(4{d)~2{.d=. ".sysdata'
win_grph_paint=: 3 : 'glcmds 6 2093 255 255 255 255,(2++:#p),2015,,p'
win_save_button=: 3 : '(''~temp/dft/'',name) fwrite~ LF,.~":p'
win_clean_button=: 3 : 'glpaint p=: 0 2$0'
wd WIN