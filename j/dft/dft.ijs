load'gl2 math/fftw'
coinsert'jgl2'
a=: 0 2$t=: 0
WIN=: 0 : 0
 pc win closeok;pn "discrete fourier transform";
 minwh 500 500;cc grph isigraph;
 ptimer 20;pshow;
)
win_timer=: glpaint bind ''
c =: ".'m'fread'~temp/dft/train1.txt'
cx=: |.            (,.i.@#)*.1 fftwnd_jfftw_ {."1 c
cy=: |.0 1r2p1 0+"1(,.i.@#)*.1 fftwnd_jfftw_ {:"1 c
win_grph_paint=: 3 : 0
 p=. +/\.100 150,~+.cy({."1@:[r.+/ .*)0 1,t=: t+10p1%#c
 q=. +/\.300 400,~+.cx({."1@:[r.+/ .*)0 1,t
 try.
  glfill 255 255 255 255
  glpen 1
  glellipse"1 (}.p)(-,.,.~@:+:@:]){."1 cy
  glellipse"1 (}.q)(-,.,.~@:+:@:]){."1 cx
  gllines,<.a=: ({.~(#c)<.#)a,({.{.q),{:{.p
  gllines <.({.p),({.{.q),({:{.p),{.q
  glpen 3
  glpixel"1 <.p,q
 catch. smoutput 'mistake' end.
)
wd WIN