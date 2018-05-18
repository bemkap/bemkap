coinsert'jgl2'[require'gl2'

FIRE=: noun define
 pc window closeok;pn "Fire effect";
 minwh 100 100;cc isi isigraph flush;
 pcenter;pshow;
)
window_run=: verb def 'wd FIRE,'';ptimer ":50'''
window_timer=: verb def 'glpaint M=: next M'
window_close=: verb def 'wd ''timer 0; pclose; reset'''
window_isi_paint=: verb define
 glclear''
 glpixels 0 0 100 100 ,,M
)
window_run''

M=: 1,~99 100$0
borden=: 0,.0,.~0,0,~]
c=: 4 %~ [: +/ (0 1 0 1 0 1 0 1 0) * ,
next=: (1 1,:3 3) c;._3 borden