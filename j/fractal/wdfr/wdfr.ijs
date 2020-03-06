load'~temp/wdfr/rfr.ijs ~temp/wdfr/cfr.ijs'
load'gl2 numeric'
coinsert'px2j4 jgl2 cfr'

FRACTAL=: 0 : 0
pc frwin closeok;
cc frtab tab;
tabnew ifs;
bin vh;
cc frlist listbox;set frlist select 0;
bin vh;
minwh 200 200;cc frx0 isigraph;
cc frpen slider v 0 1 1 1 10 0;
cc frcol slider v 0 0 50 50 16777215 0; 
bin szh;
cc s3 static;cn "iter";
cc friter dspinbox 0 0 1 1000000 0;
bin zszz;
minwh 640 480;cc frgrph isigraph;
tabnew ds;
)

frwin_run=: 3 : 0
F=: (conew&'cfr')"1 rfr'~temp/wdfr/f1.xml'
X0=: OC=: C=: 0 0
Z=: D0=: D1=: 0
wd FRACTAL
wd'set frlist items ',,,&' '"1 NM"0 F
wd'set frlist select 0'
wd'pshow'
)

fwin_close=: wd bind 'pclose'

frwin_frgrph_paint=: 3 : 0
glpen ".frpen
glrgb 256 #. inv ".frcol
f=. F{~".frlist_select
wh=. -: glqwh''
gllines 0 0 640 0 640 480 0 480 0 0
glpixel roundint wh +"1 Z*(calc__f X0;~".friter) -"1 C
)

frwin_frpen_changed=: glpaint bind ''

frwin_frcol_changed=: glpaint bind ''

frwin_frx0_paint=: 3 : 'glcmds 12 2015 0 0 200 0 200 200 0 200 0 0 6 2015 100 0 100 200 6 2015 0 100 200 100'

frwin_frx0_mbldown=: 3 : 'D1=: 1'

frwin_frx0_mblup=: 3 : 'D1=: 0'

frwin_frx0_mmove=: 3 : 0
if. D1 do.
  X0=: _10+0.1*2{.".sysdata
  glsel'frgrph'
  glpaint''
end.
)

frwin_frgrph_mbldown=: 3 : 'D0=: 1 [ OC=: 2{.".sysdata'

frwin_frgrph_mblup=: 3 : 'D0=: 0'

frwin_frgrph_mmove=: 3 : 0
if. D0 do.
  mc=. 2{.".sysdata
  C =: C-0.005*OC-mc
  OC=: mc
  glpaint''
end.
)

frwin_frgrph_mwheel=: 3 : 0
Z=: 0>.Z+{:".sysdata
glpaint''
)

frwin_run''