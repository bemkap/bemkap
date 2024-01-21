NB.+./ 2 -:/\ (range 0 100 1) I. /:~ 1 v ,: 0 0 1

DIR=: '/home/bemkap/doc/b/j/fractal/wdfr/'
load&>DIR&,&.>'rfr.ijs';'cfr.ijs'
load'gl2 numeric'
coinsert'px2j4 jgl2 cfr'

FRACTAL=: 0 : 0
pc frwin closeok;pn "wdfr";
bin vh;
cc lbfr listbox;
bin v;
cc sinit static;cn "init : 0 0";
cc i0 isigraph;
cc sred static;cn "R : 0";
cc slred slider 0 0 1 16 255 0;
cc sgreen static;cn "G : 0";
cc slgreen slider 0 0 1 16 255 0;
cc sblue static;cn "B : 0";
cc slblue slider 0 0 1 16 255 0;
cc siter static;cn "iter";
cc sbiter spinbox;
bin zz;
cc i1 isigraph;
)

frwin_run=: 3 : 0
F=: (conew&'cfr')"1 rfr '~temp/wdfr/f1.xml'
X0=: OC=: C=: 0 0 
Z=: D0=: D1=: 0
wd FRACTAL
wd'set lbfr items ',,,&' '"1 NM"0 F
wd'set lbfr select 0'
wd'pshow'
)

frwin_i0_paint=: 3 : 0
'w h'=. glqwh''
glfill 255 255 255
glpen 3
gllines 0 0,w,0,w,h,0,h,0 0 
glpen 1
gllines (<.-:w),0,(<.-:w),h
gllines 0,(<.-:h),w,(<.-:h)
glpen 5
glpixel X0
)

frwin_i1_paint=: 3 : 0
'w h'=. glqwh''
hwh=. -:w,h
glfill 255 255 255
glpen 3
gllines 0 0,w,0,w,h,0,h,0 0
glrgb ". slred,slgreen,:slblue
f=. F{~".lbfr_select
glpixel roundint hwh +"1 (2^Z)*(calc__f X0;~".sbiter) -"1 C
)

frwin_slred_changed=: 3 : 0
wd'set sred text R : ',slred
glpaint''
)

frwin_slgreen_changed=: 3 : 0
wd'set sgreen text R : ',slgreen
glpaint''
)

frwin_slblue_changed=: 3 : 0
wd'set sblue text R : ',slblue
glpaint''
)

frwin_i0_mbldown=: 3 : 0
D0=: 1
X0=: 2{.".sysdata
glpaint''
)

frwin_i0_mblup=: 3 : 'D0=: 0'

frwin_i0_mmove=: 3 : 0
X0=: 2{.".sysdata
if. D0 *. *./ X0 I."1 0~ 0,.glqwh'' do.
  wh=. <.-:glqwh''
  wd'set sinit text init : ',":0.1*X0-wh
  glpaint''
  glsel'i1'
  glpaint''
end.
)

frwin_i1_mbldown=: 3 : 0
D1=: 1
OC=: 2{.".sysdata
)

frwin_i1_mblup=: 3 : 'D1=: 0'

frwin_i1_mmove=: 3 : 0
mc=. 2{.".sysdata
if. D1 *. *./ mc I."1 0~ 0,.glqwh'' do.
  C =: C-0.1*OC-mc
  OC=: mc
  glpaint''
end.
)

frwin_i1_mwheel=: 3 : 0
Z=: 0>.Z+*{:".sysdata
glpaint''
)

frwin_run''