require^:IFQT 'ide/qt/keys'
require^:IFJA 'ide/ja/keys'

coclass 'jgl2'

create=: destroy=: [:

locGL2=: 0$<''

3 : 0''
if. 0~: 4!:0 <'PROFONT_z_' do. PROFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'Sans 10' ; '"Lucida Grande" 10' ; (IFQT{::'Sans 10';'"Droid Sans" 10') ; 'Tahoma 10' else. PROFONT=: PROFONT_z_ end.
if. 0~: 4!:0 <'FIXFONT_z_' do. FIXFONT=: (('Linux';'Darwin';'Android';'Win') i. <UNAME){:: 'mono 10' ; 'Monaco 10' ; (IFQT{::'monospace 10';'"Droid Sans Mono" 10') ; '"Lucida Console" 10' else. FIXFONT=: FIXFONT_z_ end.
if. 0~: 4!:0 <'GL2Backend_j_' do. GL2Backend_j_=: 0 end.

if. IFQT do.
  RGBSEQ_j_=: 1
  GL2Backend=: 0
  locGL2_jgl2_=: <'jglcanvas'
elseif. IFJA do.
  GL2Backend=: 1
  RGBSEQ_j_=: 1
  locGL2_jgl2_=: <'jglcanvas'
elseif. 'Android'-:UNAME do.
  GL2Backend=: 0
elseif. do.
  RGBSEQ_j_=: 1
  GL2Backend=: 0
  locGL2_jgl2_=: <'jgl2'
end.
EMPTY
)
PS_NULL=: 0
PS_SOLID=: 1
PS_DASH=: 2
PS_DOT=: 3
PS_DASHDOT=: 4
PS_DASHDOTDOT=: 5

IDC_ARROW=: 0
IDC_UPARROW=: 1
IDC_CROSS=: 2
IDC_WAIT=: 3
IDC_IBEAM=: 4
IDC_SIZEVER=: 5
IDC_SIZEHOR=: 6
IDC_SIZEBDIAG=: 7
IDC_SIZEFDIAG=: 8
IDC_SIZEALL=: 9
IDC_BLANK=: 10
IDC_SPLITV=: 11
IDC_SPLITH=: 12
IDC_POINTINGHAND=: 13
IDC_FORBIDDEN=: 14
IDC_OPENHAND=: 17
IDC_CLOSEDHAND=: 18
IDC_WHATSTHIS=: 15
IDC_BUSY=: 16
IDC_DRAGMOVE=: 20
IDC_DRAGCOPY=: 19
IDC_DRAGLINK=: 21
IDC_UNSET=: _1
glarc_n=: 2001
glbrush_n=: 2004
glbrushnull_n=: 2005
glcapture_n=: 2062
glcaret_n=: 2065
glclear_n=: 2007
glclip_n=: 2078
glclipreset_n=: 2079
glcmds_n=: 2999
glcursor_n=: 2069
glellipse_n=: 2008
glemfopen_n=: 2084
glemfclose_n=: 2085
glemfplay_n=: 2086
glfile_n=: 2066
glfill_n=: 2093
glfont_n=: 2012
glfontextent_n=: 2094
gllines_n=: 2015
glnodblbuf_n=: 2070
glpaint_n=: 2020
glpaintx_n=: 2021
glpen_n=: 2022
glpie_n=: 2023
glpixel_n=: 2024
glpixelsx_n=: 2075
glpixels_n=: 2076
glprint_n=: 2089
glprintmore_n=: 2091
glpolygon_n=: 2029
glqextent_n=: 2057
glqextentw_n=: 2083
glqpixels_n=: 2077
glqpixelm_n=: 2080
glqprintpaper_n=: 2092
glqprintwh_n=: 2088
glqtextmetrics_n=: 2058
glqtype_n=: 2095
glqwh_n=: 2059
glqhandles_n=: 2060
glrect_n=: 2031
glrgb_n=: 2032
glroundr_n=: 2033
glsel_n=: 2035
gltext_n=: 2038
gltextcolor_n=: 2040
gltextxy_n=: 2056
glwindoworg_n=: 2045

glbkmode_n=: 2003
glnoerasebkgnd_n=: 2071

glfont2_n=: 2312
glfontangle_n=: 2342
glrgba_n=: 2343
glsel2_n=: 2344
glwaitgl_n=: 2345
glwaitnative_n=: 2346
3 : 0''
if. IFQT do.
  kbBS=: Qt_Key_Backspace_jqtide_
  kbTAB=: Qt_Key_Tab_jqtide_
  kbLF=: Qt_Key_Enter_jqtide_
  kbENTER=: Qt_Key_Enter_jqtide_
  kbRETURN=: Qt_Key_Return_jqtide_
  kbPUP=: Qt_Key_PageUp_jqtide_
  kbPDOWN=: Qt_Key_PageDown_jqtide_
  kbEND=: Qt_Key_End_jqtide_
  kbHOME=: Qt_Key_Home_jqtide_
  kbLEFT=: Qt_Key_Left_jqtide_
  kbUP=: Qt_Key_Up_jqtide_
  kbRIGHT=: Qt_Key_Right_jqtide_
  kbDOWN=: Qt_Key_Down_jqtide_
  kbESC=: Qt_Key_Escape_jqtide_
  kbINS=: Qt_Key_Insert_jqtide_
  kbDEL=: Qt_Key_Delete_jqtide_
  kbMETA=: Qt_Key_Meta_jqtide_
  kbALT=: Qt_Key_Alt_jqtide_
  kbSHIFT=: Qt_Key_Shift_jqtide_
  kbCTRL=: Qt_Key_Control_jqtide_
elseif. 'Android'-:UNAME do.
  kbBS=: 0
  kbTAB=: 0
  kbLF=: 0
  kbENTER=: 0
  kbRETURN=: 0
  kbPUP=: 0
  kbPDOWN=: 0
  kbEND=: 0
  kbHOME=: 0
  kbLEFT=: 0
  kbUP=: 0
  kbRIGHT=: 0
  kbDOWN=: 0
  kbESC=: 0
  kbINS=: 0
  kbDEL=: 0
  kbMETA=: 0
  kbALT=: 0
  kbSHIFT=: 0
  kbCTRL=: 0
end.
EMPTY
)
3 : 0''
if. IFJA +. IFQT *. 0~:#locGL2_jgl2_ do.
  glarc=: glarc__locGL2
  glarcx=: glarcx__locGL2
  glbrush=: glbrush__locGL2
  glbrushnull=: glbrushnull__locGL2
  glcapture=: glcapture__locGL2
  glcaret=: glcaret__locGL2
  glclear=: glclear__locGL2
  glclip=: glclip__locGL2
  glclipreset=: glclipreset__locGL2
  glcmds=: glcmds__locGL2
  glcmds=: glcmds__locGL2
  glcursor=: glcursor__locGL2
  glellipse=: glellipse__locGL2
  glemfclose=: glemfclose__locGL2
  glemfopen=: glemfopen__locGL2
  glemfplay=: glemfplay__locGL2
  glfile=: glfile__locGL2
  glfill=: glfill__locGL2
  glfont=: glfont__locGL2
  glfontangle=: glfontangle__locGL2
  glfontextent=: glfontextent__locGL2
  gllines=: gllines__locGL2
  glnodblbuf=: glnodblbuf__locGL2
  glpaint=: glpaint__locGL2
  glpaintx=: glpaintx__locGL2
  glpen=: glpen__locGL2
  glpie=: glpie__locGL2
  glpixel=: glpixel__locGL2
  glpixels=: glpixels__locGL2
  glpixelsx=: glpixelsx__locGL2
  glpolygon=: glpolygon__locGL2
  glprint=: glprint__locGL2
  glprintmore=: glprintmore__locGL2
  glqextent=: glqextent__locGL2
  glqextentw=: glqextentw__locGL2
  glqhandles=: glqhandles__locGL2
  glqpixelm=: glqpixelm__locGL2
  glqpixels=: glqpixels__locGL2
  glqprintpaper=: glqprintpaper__locGL2
  glqprintwh=: glqprintwh__locGL2
  glqtextmetrics=: glqtextmetrics__locGL2
  glqtype=: glqtype__locGL2
  glqwh=: glqwh__locGL2
  glrect=: glrect__locGL2
  glrgb=: glrgb__locGL2
  glrgba=: glrgba__locGL2
  glroundr=: glroundr__locGL2
  glsel1=: glsel__locGL2
  glsel2=: glsel2__locGL2
  glsetbrush=: glsetbrush__locGL2
  glsetlocale=: glsetlocale__locGL2
  glsetpen=: glsetpen__locGL2
  gltext=: gltext__locGL2
  gltextcolor=: gltextcolor__locGL2
  gltextxy=: gltextxy__locGL2
  glwindoworg=: glwindoworg__locGL2
  glbuf=: glbuf__locGL2
  glmark=: glmark__locGL2
  glqmark=: glqmark__locGL2
  gltrash=: gltrash__locGL2
else.
  glarc=: 3 : 'glarc__l y [[ l=. locGL2_jgl2_'
  glarcx=: 3 : 'glarcx__l y [[ l=. locGL2_jgl2_'
  glbrush=: 3 : 'glbrush__l y [[ l=. locGL2_jgl2_'
  glbrushnull=: 3 : 'glbrushnull__l y [[ l=. locGL2_jgl2_'
  glcapture=: 3 : 'glcapture__l y [[ l=. locGL2_jgl2_'
  glcaret=: 3 : 'glcaret__l y [[ l=. locGL2_jgl2_'
  glclear=: 3 : 'glclear__l y [[ l=. locGL2_jgl2_'
  glclip=: 3 : 'glclip__l y [[ l=. locGL2_jgl2_'
  glclipreset=: 3 : 'glclipreset__l y [[ l=. locGL2_jgl2_'
  glcmds=: 3 : 'glcmds__l y [[ l=. locGL2_jgl2_'
  glcmds=: 3 : 'glcmds__l y [[ l=. locGL2_jgl2_'
  glcursor=: 3 : 'glcursor__l y [[ l=. locGL2_jgl2_'
  glellipse=: 3 : 'glellipse__l y [[ l=. locGL2_jgl2_'
  glemfclose=: 3 : 'glemfclose__l y [[ l=. locGL2_jgl2_'
  glemfopen=: 3 : 'glemfopen__l y [[ l=. locGL2_jgl2_'
  glemfplay=: 3 : 'glemfplay__l y [[ l=. locGL2_jgl2_'
  glfile=: 3 : 'glfile__l y [[ l=. locGL2_jgl2_'
  glfont=: 3 : 'glfont__l y [[ l=. locGL2_jgl2_'
  glfontangle=: 3 : 'glfontangle__l y [[ l=. locGL2_jgl2_'
  glfontextent=: 3 : 'glfontextent__l y [[ l=. locGL2_jgl2_'
  gllines=: 3 : 'gllines__l y [[ l=. locGL2_jgl2_'
  glnodblbuf=: 3 : 'glnodblbuf__l y [[ l=. locGL2_jgl2_'
  glpaint=: 3 : 'glpaint__l y [[ l=. locGL2_jgl2_'
  glpaintx=: 3 : 'glpaintx__l y [[ l=. locGL2_jgl2_'
  glpen=: 3 : 'glpen__l y [[ l=. locGL2_jgl2_'
  glpie=: 3 : 'glpie__l y [[ l=. locGL2_jgl2_'
  glpixel=: 3 : 'glpixel__l y [[ l=. locGL2_jgl2_'
  glpixels=: 3 : 'glpixels__l y [[ l=. locGL2_jgl2_'
  glpixelsx=: 3 : 'glpixelsx__l y [[ l=. locGL2_jgl2_'
  glpolygon=: 3 : 'glpolygon__l y [[ l=. locGL2_jgl2_'
  glprint=: 3 : 'glprint__l y [[ l=. locGL2_jgl2_'
  glprintmore=: 3 : 'glprintmore__l y [[ l=. locGL2_jgl2_'
  glqextent=: 3 : 'glqextent__l y [[ l=. locGL2_jgl2_'
  glqextentw=: 3 : 'glqextentw__l y [[ l=. locGL2_jgl2_'
  glqhandles=: 3 : 'glqhandles__l y [[ l=. locGL2_jgl2_'
  glqpixelm=: 3 : 'glqpixelm__l y [[ l=. locGL2_jgl2_'
  glqpixels=: 3 : 'glqpixels__l y [[ l=. locGL2_jgl2_'
  glqprintpaper=: 3 : 'glqprintpaper__l y [[ l=. locGL2_jgl2_'
  glqprintwh=: 3 : 'glqprintwh__l y [[ l=. locGL2_jgl2_'
  glqtextmetrics=: 3 : 'glqtextmetrics__l y [[ l=. locGL2_jgl2_'
  glqtype=: 3 : 'glqtype__l y [[ l=. locGL2_jgl2_'
  glqwh=: 3 : 'glqwh__l y [[ l=. locGL2_jgl2_'
  glrect=: 3 : 'glrect__l y [[ l=. locGL2_jgl2_'
  glrgb=: 3 : 'glrgb__l y [[ l=. locGL2_jgl2_'
  glroundr=: 3 : 'glroundr__l y [[ l=. locGL2_jgl2_'
  glsel1=: 3 : 'glsel__l y [[ l=. locGL2_jgl2_'
  glsel2=: 3 : 'glsel2__l y [[ l=. locGL2_jgl2_'
  glsetbrush=: 3 : 'glsetbrush__l y [[ l=. locGL2_jgl2_'
  glsetlocale=: 3 : 'glsetlocale__l y [[ l=. locGL2_jgl2_'
  glsetpen=: 3 : 'glsetpen__l y [[ l=. locGL2_jgl2_'
  gltext=: 3 : 'gltext__l y [[ l=. locGL2_jgl2_'
  gltextcolor=: 3 : 'gltextcolor__l y [[ l=. locGL2_jgl2_'
  gltextxy=: 3 : 'gltextxy__l y [[ l=. locGL2_jgl2_'
  glwindoworg=: 3 : 'glwindoworg__l y [[ l=. locGL2_jgl2_'
  glbuf=: 3 : 'glbuf__l y [[ l=. locGL2_jgl2_'
  glmark=: 3 : 'glmark__l y [[ l=. locGL2_jgl2_'
  glqmark=: 3 : 'glqmark__l y [[ l=. locGL2_jgl2_'
  gltrash=: 3 : 'gltrash__l y [[ l=. locGL2_jgl2_'
end.
EMPTY
)
gl_arc=: (qtgl_arc`jagl_arc@.GL2Backend_jgl2_)`(glarc_n_jgl2_&glbuf)@.glqmark
gl_arcx=: (qtgl_arcx`jagl_arcx@.GL2Backend_jgl2_)`(glarcx_n_jgl2_&glbuf)@.glqmark
gl_brush=: (qtgl_brush`jagl_brush@.GL2Backend_jgl2_)`(glbrush_n_jgl2_&glbuf)@.glqmark
gl_brushnull=: (qtgl_brushnull`jagl_brushnull@.GL2Backend_jgl2_)`(glbrushnull_n_jgl2_&glbuf)@.glqmark
gl_capture=: (qtgl_capture`jagl_capture@.GL2Backend_jgl2_)`(glcapture_n_jgl2_&glbuf)@.0:
gl_caret=: (qtgl_caret`jagl_caret@.GL2Backend_jgl2_)`(glcaret_n_jgl2_&glbuf)@.0:
gl_clear=: (qtgl_clear`jagl_clear@.GL2Backend_jgl2_)`(glclear_n_jgl2_&glbuf)@.glqmark
gl_clip=: (qtgl_clip`jagl_clip@.GL2Backend_jgl2_)`(glclip_n_jgl2_&glbuf)@.glqmark
gl_clipreset=: (qtgl_clipreset`jagl_clipreset@.GL2Backend_jgl2_)`(glclipreset_n_jgl2_&glbuf)@.glqmark
gl_cmds=: (qtgl_cmds`jagl_cmds@.GL2Backend_jgl2_)`(glcmds_n_jgl2_&glbuf)@.glqmark
gl_cursor=: (qtgl_cursor`jagl_cursor@.GL2Backend_jgl2_)`(glcursor_n_jgl2_&glbuf)@.0:
gl_ellipse=: (qtgl_ellipse`jagl_ellipse@.GL2Backend_jgl2_)`(glellipse_n_jgl2_&glbuf)@.glqmark
gl_fill=: (qtgl_fill`jagl_fill@.GL2Backend_jgl2_)`(glfill_n_jgl2_&glbuf)@.glqmark
gl_font=: (qtgl_font`jagl_font@.GL2Backend_jgl2_)`(glfont_n_jgl2_&glbuf)@.glqmark
gl_fontangle=: (qtgl_fontangle`jagl_fontangle@.GL2Backend_jgl2_)`(glfontangle_n_jgl2_&glbuf)@.glqmark
gl_fontextent=: (qtgl_fontextent`jagl_fontextent@.GL2Backend_jgl2_)`(glfontextent_n_jgl2_&glbuf)@.glqmark
gl_lines=: (qtgl_lines`jagl_lines@.GL2Backend_jgl2_)`(gllines_n_jgl2_&glbuf)@.glqmark
gl_nodblbuf=: (qtgl_nodblbuf`jagl_nodblbuf@.GL2Backend_jgl2_)`(glnodblbuf_n_jgl2_&glbuf)@.0:
gl_paint=: (qtgl_paint`jagl_paint@.GL2Backend_jgl2_)`(glpaint_n_jgl2_&glbuf)@.0:
gl_paintx=: (qtgl_paintx`jagl_paintx@.GL2Backend_jgl2_)`(glpaintx_n_jgl2_&glbuf)@.0:
gl_pen=: (qtgl_pen`jagl_pen@.GL2Backend_jgl2_)`(glpen_n_jgl2_&glbuf)@.glqmark
gl_pie=: (qtgl_pie`jagl_pie@.GL2Backend_jgl2_)`(glpie_n_jgl2_&glbuf)@.glqmark
gl_pixel=: (qtgl_pixel`jagl_pixel@.GL2Backend_jgl2_)`(glpixel_n_jgl2_&glbuf)@.glqmark
gl_pixels=: (qtgl_pixels`jagl_pixels@.GL2Backend_jgl2_)`(glpixels_n_jgl2_&glbuf)@.glqmark
gl_pixelsx=: (qtgl_pixelsx`jagl_pixelsx@.GL2Backend_jgl2_)`(glpixelsx_n_jgl2_&glbuf)@.glqmark
gl_polygon=: (qtgl_polygon`jagl_polygon@.GL2Backend_jgl2_)`(glpolygon_n_jgl2_&glbuf)@.glqmark
gl_qextent=: (qtgl_qextent`jagl_qextent@.GL2Backend_jgl2_)`(glqextent_n_jgl2_&glbuf)@.0:
gl_qextentw=: (qtgl_qextentw`jagl_qextentw@.GL2Backend_jgl2_)`(glqextentw_n_jgl2_&glbuf)@.0:
gl_qpixelm=: (qtgl_qpixelm`jagl_qpixelm@.GL2Backend_jgl2_)`(glqpixelm_n_jgl2_&glbuf)@.0:
gl_qpixels=: (qtgl_qpixels`jagl_qpixels@.GL2Backend_jgl2_)`(glqpixels_n_jgl2_&glbuf)@.0:
gl_qtextmetrics=: (qtgl_qtextmetrics`jagl_qtextmetrics@.GL2Backend_jgl2_)`(glqtextmetrics_n_jgl2_&glbuf)@.0:
gl_qtype=: (qtgl_qtype`jagl_qtype@.GL2Backend_jgl2_)`(glqtype_n_jgl2_&glbuf)@.0:
gl_qwh=: (qtgl_qwh`jagl_qwh@.GL2Backend_jgl2_)`(glqwh_n_jgl2_&glbuf)@.0:
gl_rect=: (qtgl_rect`jagl_rect@.GL2Backend_jgl2_)`(glrect_n_jgl2_&glbuf)@.glqmark
gl_rgb=: (qtgl_rgb`jagl_rgb@.GL2Backend_jgl2_)`(glrgb_n_jgl2_&glbuf)@.glqmark
gl_rgba=: (qtgl_rgba`jagl_rgba@.GL2Backend_jgl2_)`(glrgba_n_jgl2_&glbuf)@.glqmark
gl_sel=: (qtgl_sel`jagl_sel@.GL2Backend_jgl2_)`(glsel_n_jgl2_&glbuf)@.glqmark
gl_sel2=: (qtgl_sel2`jagl_sel2@.GL2Backend_jgl2_)`(glsel2_n_jgl2_&glbuf)@.glqmark
gl_setbrush=: (qtgl_setbrush`jagl_setbrush@.GL2Backend_jgl2_)`(glsetbrush_n_jgl2_&glbuf)@.glqmark
gl_setlocale=: (qtgl_setlocale`jagl_setlocale@.GL2Backend_jgl2_)`(glsetlocale_n_jgl2_&glbuf)@.0:
gl_setpen=: (qtgl_setpen`jagl_setpen@.GL2Backend_jgl2_)`(glsetpen_n_jgl2_&glbuf)@.0:
gl_text=: (qtgl_text`jagl_text@.GL2Backend_jgl2_)`(gltext_n_jgl2_&glbuf)@.glqmark
gl_textcolor=: (qtgl_textcolor`jagl_textcolor@.GL2Backend_jgl2_)`(gltextcolor_n_jgl2_&glbuf)@.glqmark
gl_textxy=: (qtgl_textxy`jagl_textxy@.GL2Backend_jgl2_)`(gltextxy_n_jgl2_&glbuf)@.glqmark
gl_waitgl=: (qtgl_waitgl`jagl_waitgl@.GL2Backend_jgl2_)`(glwaitgl_n_jgl2_&glbuf)@.glqmark
gl_waitnative=: (qtgl_waitnative`jagl_waitnative@.GL2Backend_jgl2_)`(glwaitnative_n_jgl2_&glbuf)@.glqmark
gl_windoworg=: (qtgl_windoworg`jagl_windoworg@.GL2Backend_jgl2_)`(glwindoworg_n_jgl2_&glbuf)@.glqmark
gl_print=: qtgl_print`jagl_print@.GL2Backend_jgl2_
gl_printmore=: qtgl_printmore`jagl_printmore@.GL2Backend_jgl2_
gl_qhandles=: qtgl_qhandles`jagl_qhandles@.GL2Backend_jgl2_
gl_qprintpaper=: qtgl_qprintpaper`jagl_qprintpaper@.GL2Backend_jgl2_
gl_qprintwh=: qtgl_qprintwh`jagl_qprintwh@.GL2Backend_jgl2_
gl_emfclose=: qtgl_emfclose`jagl_emfclose@.GL2Backend_jgl2_
gl_emfopen=: qtgl_emfopen`jagl_emfopen@.GL2Backend_jgl2_
gl_emfplay=: qtgl_emfplay`jagl_emfplay@.GL2Backend_jgl2_
gl_file=: qtgl_file`jagl_file@.GL2Backend_jgl2_
gl_roundr=: qtgl_roundr`jagl_roundr@.GL2Backend_jgl2_
glsel=: glsel1`glsel2@.(2=3!:0)
rpcinfinity=: 3 : 0
<. 0 (I.(_=y)+.__=y)}y
)

jaadverbc=: 1 : 0
ogl_jni_ (2+#y), m, <.y
)

chkgl2=: 13!:8@3:^:(0&<)
jagl_arc=: chkgl2 @: ((glarc_n_jgl2_ jaadverbc))
jagl_brush=: chkgl2 @: ((glbrush_n_jgl2_ jaadverbc) bind '')
jagl_brushnull=: chkgl2 @: ((glbrushnull_n_jgl2_ jaadverbc) bind '')
jagl_capture=: chkgl2 @: ((glcapture_n_jgl2_ jaadverbc))
jagl_caret=: chkgl2 @: ((glcaret_n_jgl2_ jaadverbc))
jagl_clear=: chkgl2 @: ((glclear_n_jgl2_ jaadverbc) bind '')
jagl_clip=: chkgl2 @: ((glclip_n_jgl2_ jaadverbc))
jagl_clipreset=: chkgl2 @: ((glclipreset_n_jgl2_ jaadverbc) bind '')
jagl_cmds=: chkgl2 @: ((glcmds_n_jgl2_ jaadverbc)@:rpcinfinity)
jagl_cursor=: chkgl2 @: ((glcursor_n_jgl2_ jaadverbc))
jagl_ellipse=: chkgl2 @: ((glellipse_n_jgl2_ jaadverbc))
jagl_fill=: chkgl2 @: ((glfill_n_jgl2_ jaadverbc))
jagl_font=: chkgl2 @: ((glfont_n_jgl2_ jaadverbc)@:(a.&i.)@,)
jagl_font2=: chkgl2 @: ((glfont2_n_jgl2_ jaadverbc))
jagl_fontangle=: chkgl2 @: ((glfontangle_n_jgl2_ jaadverbc))
jagl_fontextent=: chkgl2 @: ((glfontextent_n_jgl2_ jaadverbc)@:(a.&i.)@,)
jagl_lines=: chkgl2 @: ((gllines_n_jgl2_ jaadverbc))
jagl_nodblbuf=: chkgl2 @: ((glnodblbuf_n_jgl2_ jaadverbc)@:{.@(,&0))
jagl_pen=: chkgl2 @: ((glpen_n_jgl2_ jaadverbc)@:(2 {. (,&1)))
jagl_paint=: chkgl2 @: ((glpaint_n_jgl2_ jaadverbc)@:(2 {. (,&1)))
jagl_paintx=: chkgl2 @: ((glpaintx_n_jgl2_ jaadverbc)@:(2 {. (,&1)))
jagl_pie=: chkgl2 @: ((glpie_n_jgl2_ jaadverbc))
jagl_pixel=: chkgl2 @: ((glpixel_n_jgl2_ jaadverbc))
jagl_pixels=: chkgl2 @: ((glpixels_n_jgl2_ jaadverbc))
jagl_pixelsx=: chkgl2 @: ((glpixelsx_n_jgl2_ jaadverbc))
jagl_polygon=: chkgl2 @: ((glpolygon_n_jgl2_ jaadverbc))
jagl_rect=: chkgl2 @: ((glrect_n_jgl2_ jaadverbc)@:rpcinfinity)
jagl_rgb=: chkgl2 @: ((glrgb_n_jgl2_ jaadverbc))
jagl_rgba=: chkgl2 @: ((glrgba_n_jgl2_ jaadverbc))
jagl_sel=: chkgl2 @: ((glsel_n_jgl2_ jaadverbc))
jagl_sel2=: chkgl2 @: ((glsel2_n_jgl2_ jaadverbc)@:(a.&i.)@,)
jagl_text=: chkgl2 @: ((gltext_n_jgl2_ jaadverbc)@:(a.&i.)@,)
jagl_textcolor=: chkgl2 @: ((gltextcolor_n_jgl2_ jaadverbc) bind '')
jagl_textxy=: chkgl2 @: ((gltextxy_n_jgl2_ jaadverbc))
jagl_waitgl=: chkgl2 @: ((glwaitgl_n_jgl2_ jaadverbc) bind '')
jagl_waitnative=: chkgl2 @: ((glwaitnative_n_jgl2_ jaadverbc) bind '')
jagl_windoworg=: chkgl2 @: ((glwindoworg_n_jgl2_ jaadverbc))

jagl_setlocale=: chkgl2 @: ((glsetlocale_n_jgl2_ jaadverbc)@:(a.&i.)@,)
jagl_qhandles=: 3 : 0"1
chkgl2 (glqhandles_n_jgl2_ jaadverbc)$0
glresult_jgl2_
)
jagl_qtype=: 3 : 0"1
chkgl2 (glqtype_n_jgl2_ jaadverbc)$0
glresult_jgl2_
)
jagl_qwh=: 3 : 0"1
chkgl2 (glqwh_n_jgl2_ jaadverbc)$0
glresult_jgl2_
)
jagl_qpixelm=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
shape=. 2#2-2
chkgl2 (glqpixelm_n_jgl2_ jaadverbc) y
shape$pix
)
jagl_qpixels=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
chkgl2 (glqpixels_n_jgl2_ jaadverbc) y
glresult_jgl2_
)
jagl_qextent=: 3 : 0"1
chkgl2 (glqextent_n_jgl2_ jaadverbc) a.&i. ,y
glresult_jgl2_
)
jagl_qextentw=: 3 : 0"1
y=. y,(LF~:{:y)#LF [ y=. ,y
w=. (+/LF=y)#2-2
chkgl2 (glqextentw_n_jgl2_ jaadverbc) a.&i. ,y
glresult_jgl2_
)
jagl_qtextmetrics=: 3 : 0"1
chkgl2 (glqtextmetrics_n_jgl2_ jaadverbc)$0
glresult_jgl2_
)
jagl_setbrush=: gl_arcbrush @ gl_arcrgb
jagl_setpen=: gl_arcpen @ ((1 1 [ gl_arcrgb) :((2 {. (,&1)) gl_arcrgb))
jagl_print=: [:
jagl_printmore=: [:
jagl_qprintpaper=: [:
jagl_qprintwh=: [:
jagl_emfclose=: [:
jagl_emfopen=: [:
jagl_emfplay=: [:
jagl_file=: [:
jagl_roundr=: [:
rpcinfinity=: 3 : 0
<. 0 (I.(_=y)+.__=y)}y
)

chkgl2=: 13!:8@3:^:(0&<)
qtgl_arc=: chkgl2 @: (('"',libjqt,'" gl_arc >',(IFWIN#'+'),' i *i') cd <)
qtgl_brush=: chkgl2 @: (('"',libjqt,'" gl_brush >',(IFWIN#'+'),' i')&cd bind '')
qtgl_brushnull=: chkgl2 @: (('"',libjqt,'" gl_brushnull >',(IFWIN#'+'),' i')&cd bind '')
qtgl_capture=: chkgl2 @: (('"',libjqt,'" gl_capture >',(IFWIN#'+'),' i i')&cd)
qtgl_caret=: chkgl2 @: (('"',libjqt,'" gl_caret >',(IFWIN#'+'),' i *i') cd <)
qtgl_clear=: chkgl2 @: (('"',libjqt,'" gl_clear >',(IFWIN#'+'),' i')&cd bind '')
qtgl_clip=: chkgl2 @: (('"',libjqt,'" gl_clip >',(IFWIN#'+'),' i *i') cd <)
qtgl_clipreset=: chkgl2 @: (('"',libjqt,'" gl_clipreset >',(IFWIN#'+'),' i')&cd bind '')
qtgl_cmds=: chkgl2 @: (('"',libjqt,'" gl_cmds >',(IFWIN#'+'),' i *i i') cd (;#)@:rpcinfinity)
qtgl_cursor=: chkgl2 @: (('"',libjqt,'" gl_cursor >',(IFWIN#'+'),' i i')&cd)
qtgl_ellipse=: chkgl2 @: (('"',libjqt,'" gl_ellipse >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_fill=: chkgl2 @: (('"',libjqt,'" gl_fill >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_font=: chkgl2 @: (('"',libjqt,'" gl_font >',(IFWIN#'+'),' i *c') cd <@,)
qtgl_font2=: chkgl2 @: (('"',libjqt,'" gl_font2 >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qtgl_fontangle=: chkgl2 @: (('"',libjqt,'" gl_fontangle >',(IFWIN#'+'),' i i')&cd)
qtgl_lines=: chkgl2 @: (('"',libjqt,'" gl_lines >',(IFWIN#'+'),' i *i i') cd (;#))
qtgl_nodblbuf=: chkgl2 @: (('"',libjqt,'" gl_nodblbuf >',(IFWIN#'+'),' i i') cd {.@(,&0))
qtgl_paint=: chkgl2 @: (('"',libjqt,'" gl_paint >',(IFWIN#'+'),' i')&cd bind '')
qtgl_paintx=: chkgl2 @: (('"',libjqt,'" gl_paintx >',(IFWIN#'+'),' i')&cd bind '')
qtgl_pen=: chkgl2 @: (('"',libjqt,'" gl_pen >',(IFWIN#'+'),' i *i') cd <@:(2&{.))
qtgl_pie=: chkgl2 @: (('"',libjqt,'" gl_pie >',(IFWIN#'+'),' i *i') cd <)
qtgl_pixel=: chkgl2 @: (('"',libjqt,'" gl_pixel >',(IFWIN#'+'),' i *i') cd <)
qtgl_pixels=: chkgl2 @: (('"',libjqt,'" gl_pixels >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qtgl_pixelsx=: chkgl2 @: (('"',libjqt,'" gl_pixelsx >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_polygon=: chkgl2 @: (('"',libjqt,'" gl_polygon >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qtgl_rect=: chkgl2 @: (('"',libjqt,'" gl_rect >',(IFWIN#'+'),' i *i') cd <@:rpcinfinity)
qtgl_rgb=: chkgl2 @: (('"',libjqt,'" gl_rgb >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_rgba=: chkgl2 @: (('"',libjqt,'" gl_rgba >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_sel=: chkgl2 @: (('"',libjqt,'" gl_sel >',(IFWIN#'+'),' i x')&cd)
qtgl_sel2=: chkgl2 @: (('"',libjqt,'" gl_sel2 >',(IFWIN#'+'),' i *c') cd <@,)
qtgl_text=: chkgl2 @: (('"',libjqt,'" gl_text >',(IFWIN#'+'),' i *c') cd <@,)
qtgl_textcolor=: chkgl2 @: (('"',libjqt,'" gl_textcolor >',(IFWIN#'+'),' i')&cd bind '')
qtgl_textxy=: chkgl2 @: (('"',libjqt,'" gl_textxy >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_waitgl=: chkgl2 @: (('"',libjqt,'" gl_waitgl >',(IFWIN#'+'),' i')&cd bind '')
qtgl_waitnative=: chkgl2 @: (('"',libjqt,'" gl_waitnative >',(IFWIN#'+'),' i')&cd bind '')
qtgl_windoworg=: chkgl2 @: (('"',libjqt,'" gl_windoworg >',(IFWIN#'+'),' i *i') cd <@:<.)
qtgl_updategl=: chkgl2 @: (('"',libjqt,'" gl_updategl >',(IFWIN#'+'),' i x')&cd)

qtgl_setlocale=: chkgl2 @: (('"',libjqt,'" gl_setlocale >',(IFWIN#'+'),' i *c') cd <@,@>)
qtgl_qhandles=: 3 : 0"1
hs=. 3#2-2
chkgl2 ('"',libjqt,'" gl_qhandles >',(IFWIN#'+'),' i *x') cd <hs
hs
)
qtgl_qwh=: 3 : 0"1
wh=. 2#2-2
chkgl2 ('"',libjqt,'" gl_qwh >',(IFWIN#'+'),' i *i') cd <wh
wh
)
qtgl_qpixelm=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
shape=. 2#2-2
chkgl2 ('"',libjqt,'" gl_qpixelm >',(IFWIN#'+'),' i *i *i *i') cd y;shape;pix
shape$pix
)
qtgl_qpixels=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
chkgl2 ('"',libjqt,'" gl_qpixels >',(IFWIN#'+'),' i *i *i') cd y;pix
pix
)
qtgl_qextent=: 3 : 0"1
wh=. 2#2-2
chkgl2 ('"',libjqt,'" gl_qextent >',(IFWIN#'+'),' i *c *i') cd (,y);wh
wh
)
qtgl_qextentw=: 3 : 0"1
y=. y,(LF~:{:y)#LF [ y=. ,y
w=. (+/LF=y)#2-2
chkgl2 ('"',libjqt,'" gl_qextentw >',(IFWIN#'+'),' i *c *i') cd y;w
w
)
qtgl_qtextmetrics=: 3 : 0"1
tm=. 7#2-2
chkgl2 ('"',libjqt,'" gl_qtextmetrics >',(IFWIN#'+'),' i *i') cd tm
tm
)
HUES=: 255*|."1#:7|3^i.7
cile=: $@] $ ((* <.@:% #@]) /:@/:@,)
grayscale=: 3&#"0 @ >.@ (255&*)
fit01=: 3 : 0
0 fit01 y
:
dat=. y
s=. $dat
if. x=0 do. dat=. ,dat end.
min=. <./dat
max=. >./dat
s $ ,(dat -"1 min) %"1 max-min
)
fit11=: <: @: +: @: fit01
fitrect01=: 0&$: : (4 : 0)
s=. $y
'x y w h'=. |: _4[\ ,y
rx=. #x
d=. x fit01 (x,x+w) ,. y,y+h
'x xw'=. (2,rx)${."1 d
'y yh'=. (2,rx)${:"1 d
s $ , x,.y,.(xw-x),.yh-y
)
fitrect11=: 3 : 0
s=. $y
'x y w h'=. |: _4[\ ,y
rx=. #x
d=. <: +: x fit01 (x,x+w) ,. y,y+h
'x xw'=. (2,rx)${."1 d
'y yh'=. (2,rx)${:"1 d
s $ , x,.y,.(xw-x),.yh-y
)
hue=: 4 : 0
y=. y*<:#x
b=. x {~ <.y
t=. x {~ >.y
k=. y-<.y
(t*k)+b*-.k
)
hueRGB=: (HUES&$:) : (4 : 0)
<. 0.5 + x hue y
)
polygon=: 1&$: : (4 : '|: clean 2 1 o./ (2p1*x%y)*i.>:y')
rotate=: 4 : 0
rot=. 2 2$1 1 _1 1*0 1 1 0{2 1 o. x
rot +/ . * "2 1 y
)
gbrush=: glbrush_jgl2_ @: grgb
gclear=: 3 : 0
glclear_jgl2_''
if. #y do.
  gbrush y
  glrect_jgl2_ 0 0 1000 1000
end.
)
gfit=: 3 : 0
min=. <./y
max=. >./y
(y-"1 min)*"1 [ 1000%max-min
)
glines=: 3 : 0
gllines_jgl2_ y
:
glpen_jgl2_ x
gllines_jgl2_ y
)
gopen=: 3 : 0
y=. 2{.}.0;y
'c n'=. (<'isigraph') (I. y=<'') }y
if. (<c) e. <;._2 wd 'qp;' do.
  wd 'psel ',c
  glclear_jgl2_''
else.
  wd 'pc ',c,' closeok;pn *',n
  wd 'xywh 0 0 150 150;cc g0 isigraph rightmove bottommove'
  wd 'pas 0 0;pcenter'
  fx=. 0 ". wd 'qformx'
  wd 'pmove 150 5 ',": 2 }. fx
  wd 'pshow;'
end.
)
gpen=: 3 : 0
y=. boxopen y
'c ws'=. 2{. y,(#y)}.0 0 0;1 0
glpen_jgl2_ ws
grgb c
)
gpolygon=: 3 : 0
glpolygon_jgl2_ y
:
glbrush_jgl2_ grgb x
glpolygon_jgl2_ y
)
grgb=: 3 : 0
clr=. y
if. 1=#clr do. clr=. |. 256 256 256 #: {.clr end.
glrgb_jgl2_ clr
)
gscale=: 500&* @ >:
gshow=: 3 : 0
'isigraph' gshow y
:
wd 'psel ',x,';'
glpaint_jgl2_''
)
coclass'jglcanvas'

RGBA=: 3 : 'r (23 b.) 8 (33 b.) g (23 b.) 8 (33 b.) b (23 b.) 8 (33 b.) a [ ''r g b a''=. <.y'
BGRA=: 3 : 'b (23 b.) 8 (33 b.) g (23 b.) 8 (33 b.) r (23 b.) 8 (33 b.) a [ ''r g b a''=. <.y'

3 : 0''
if. IFQT do.
  coinsert'jqtide'
end.
EMPTY
)

initialized=: 0
stash_state=: 0
stash_buf=: 0$0
create=: 0:
destroy=: codestroy

NB jandroid gl2

rpcinfinity=: 3 : 0
<. 0 (I.(_=y)+.__=y)}y
)

jaadverbb=: 1 : 0
gl2_jni_ (2+#y), m, <.y
)

chkgl2=: 13!:8@3:^:(0&<)
ja_glarc=: chkgl2 @: ((glarc_n_jgl2_ jaadverbb))
ja_glbrush=: chkgl2 @: ((glbrush_n_jgl2_ jaadverbb) bind '')
ja_glbrushnull=: chkgl2 @: ((glbrushnull_n_jgl2_ jaadverbb) bind '')
ja_glcapture=: chkgl2 @: ((glcapture_n_jgl2_ jaadverbb))
ja_glcaret=: chkgl2 @: ((glcaret_n_jgl2_ jaadverbb))
ja_glclear=: chkgl2 @: ((glclear_n_jgl2_ jaadverbb) bind '')
ja_glclip=: chkgl2 @: ((glclip_n_jgl2_ jaadverbb))
ja_glclipreset=: chkgl2 @: ((glclipreset_n_jgl2_ jaadverbb) bind '')
ja_glcmds=: chkgl2 @: ((glcmds_n_jgl2_ jaadverbb)@:rpcinfinity)
ja_glcursor=: chkgl2 @: ((glcursor_n_jgl2_ jaadverbb))
ja_glellipse=: chkgl2 @: ((glellipse_n_jgl2_ jaadverbb))
ja_glfill=: chkgl2 @: ((glfill_n_jgl2_ jaadverbb))
ja_glfont=: chkgl2 @: ((glfont_n_jgl2_ jaadverbb)@:(a.&i.)@,)
ja_glfont2=: chkgl2 @: ((glfont2_n_jgl2_ jaadverbb))
ja_glfontangle=: chkgl2 @: ((glfontangle_n_jgl2_ jaadverbb))
ja_glfontextent=: chkgl2 @: ((glfontextent_n_jgl2_ jaadverbb)@:(a.&i.)@,)
ja_gllines=: chkgl2 @: ((gllines_n_jgl2_ jaadverbb))
ja_glnodblbuf=: chkgl2 @: ((glnodblbuf_n_jgl2_ jaadverbb)@:{.@(,&0))
ja_glpen=: chkgl2 @: ((glpen_n_jgl2_ jaadverbb)@:(2 {. (,&1)))
ja_glpie=: chkgl2 @: ((glpie_n_jgl2_ jaadverbb))
ja_glpixel=: chkgl2 @: ((glpixel_n_jgl2_ jaadverbb))
ja_glpixels=: chkgl2 @: ((glpixels_n_jgl2_ jaadverbb))
ja_glpixelsx=: chkgl2 @: ((glpixelsx_n_jgl2_ jaadverbb))
ja_glpolygon=: chkgl2 @: ((glpolygon_n_jgl2_ jaadverbb))
ja_glrect=: chkgl2 @: ((glrect_n_jgl2_ jaadverbb)@:rpcinfinity)
ja_glrgb=: chkgl2 @: ((glrgb_n_jgl2_ jaadverbb))
ja_glrgba=: chkgl2 @: ((glrgba_n_jgl2_ jaadverbb))
ja_glsel=: chkgl2 @: ((glsel_n_jgl2_ jaadverbb))
ja_glsel2=: chkgl2 @: ((glsel2_n_jgl2_ jaadverbb)@:(a.&i.)@,)
ja_gltext=: chkgl2 @: ((gltext_n_jgl2_ jaadverbb)@:(a.&i.)@,)
ja_gltextcolor=: chkgl2 @: ((gltextcolor_n_jgl2_ jaadverbb) bind '')
ja_gltextxy=: chkgl2 @: ((gltextxy_n_jgl2_ jaadverbb))
ja_glwaitgl=: chkgl2 @: ((glwaitgl_n_jgl2_ jaadverbb) bind '')
ja_glwaitnative=: chkgl2 @: ((glwaitnative_n_jgl2_ jaadverbb) bind '')
ja_glwindoworg=: chkgl2 @: ((glwindoworg_n_jgl2_ jaadverbb))

ja_glsetlocale=: chkgl2 @: ((glsetlocale_n_jgl2_ jaadverbb)@:(a.&i.)@,)
ja_glpaint=: 3 : 0 "1
if. #stash_buf do. stash_buf=: 0$0 [ ja_glcmds stash_buf end.
(glpaint_n_jgl2_ jaadverbb)$0
0
)
ja_glpaintx=: 3 : 0 "1
if. #stash_buf do. stash_buf=: 0$0 [ ja_glcmds stash_buf end.
(glpaintx_n_jgl2_ jaadverbb)$0
0
)
ja_glqhandles=: 3 : 0"1
chkgl2 (glqhandles_n_jgl2_ jaadverbb)$0
glresult_jgl2_
)
ja_glqtype=: 3 : 0"1
chkgl2 (glqtype_n_jgl2_ jaadverbb)$0
glresult_jgl2_
)
ja_glqwh=: 3 : 0"1
chkgl2 (glqwh_n_jgl2_ jaadverbb)$0
glresult_jgl2_
)
ja_glqpixelm=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
shape=. 2#2-2
chkgl2 (glqpixelm_n_jgl2_ jaadverbb) y
shape$pix
)
ja_glqpixels=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
chkgl2 (glqpixels_n_jgl2_ jaadverbb) y
glresult_jgl2_
)
ja_glqextent=: 3 : 0"1
chkgl2 (glqextent_n_jgl2_ jaadverbb) a.&i. ,y
glresult_jgl2_
)
ja_glqextentw=: 3 : 0"1
y=. y,(LF~:{:y)#LF [ y=. ,y
w=. (+/LF=y)#2-2
chkgl2 (glqextentw_n_jgl2_ jaadverbb) a.&i. ,y
glresult_jgl2_
)
ja_glqtextmetrics=: 3 : 0"1
chkgl2 (glqtextmetrics_n_jgl2_ jaadverbb)$0
glresult_jgl2_
)
ja_glsetbrush=: ja_glbrush @ ja_glrgb
ja_glsetpen=: ja_glpen @ ((1 1 [ ja_glrgb) :((2 {. (,&1)) ja_glrgb))
ja_glprint=: [:
ja_glprintmore=: [:
ja_glqprintpaper=: [:
ja_glqprintwh=: [:
ja_glemfclose=: [:
ja_glemfopen=: [:
ja_glemfplay=: [:
ja_glfile=: [:
ja_glroundr=: [:
NB qt gl2

rpcinfinity=: 3 : 0
<. 0 (I.(_=y)+.__=y)}y
)

chkgl2=: 13!:8@3:^:(0&<)
qt_glarc=: chkgl2 @: (('"',libjqt,'" glarc >',(IFWIN#'+'),' i *i') cd <)
qt_glbrush=: chkgl2 @: (('"',libjqt,'" glbrush >',(IFWIN#'+'),' i')&cd bind '')
qt_glbrushnull=: chkgl2 @: (('"',libjqt,'" glbrushnull >',(IFWIN#'+'),' i')&cd bind '')
qt_glcapture=: chkgl2 @: (('"',libjqt,'" glcapture >',(IFWIN#'+'),' i i')&cd)
qt_glcaret=: chkgl2 @: (('"',libjqt,'" glcaret >',(IFWIN#'+'),' i *i') cd <)
qt_glclear=: ('"',libjqt,'" glclear >',(IFWIN#'+'),' i')&cd bind ''
qt_glclip=: chkgl2 @: (('"',libjqt,'" glclip >',(IFWIN#'+'),' i *i') cd <)
qt_glclipreset=: chkgl2 @: (('"',libjqt,'" glclipreset >',(IFWIN#'+'),' i')&cd bind '')
qt_glcmds=: chkgl2 @: (('"',libjqt,'" glcmds >',(IFWIN#'+'),' i *i i') cd (;#)@:rpcinfinity)
qt_glcursor=: chkgl2 @: (('"',libjqt,'" glcursor >',(IFWIN#'+'),' i i')&cd)
qt_glellipse=: chkgl2 @: (('"',libjqt,'" glellipse >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glfill=: chkgl2 @: (('"',libjqt,'" glfill >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glfont=: chkgl2 @: (('"',libjqt,'" glfont >',(IFWIN#'+'),' i *c') cd <@,)
qt_glfont2=: chkgl2 @: (('"',libjqt,'" glfont2 >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qt_glfontangle=: chkgl2 @: (('"',libjqt,'" glfontangle >',(IFWIN#'+'),' i i')&cd)
qt_glfontextent=: chkgl2 @: (('"',libjqt,'" glfontextent >',(IFWIN#'+'),' i *c') cd <@,)
qt_gllines=: chkgl2 @: (('"',libjqt,'" gllines >',(IFWIN#'+'),' i *i i') cd (;#))
qt_glnodblbuf=: chkgl2 @: (('"',libjqt,'" glnodblbuf >',(IFWIN#'+'),' i i') cd {.@(,&0))
qt_glpen=: chkgl2 @: (('"',libjqt,'" glpen >',(IFWIN#'+'),' i *i') cd <@:(2 {. (,&1)))
qt_glpie=: chkgl2 @: (('"',libjqt,'" glpie >',(IFWIN#'+'),' i *i') cd <)
qt_glpixel=: chkgl2 @: (('"',libjqt,'" glpixel >',(IFWIN#'+'),' i *i') cd <)
qt_glpixels=: chkgl2 @: (('"',libjqt,'" glpixels >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qt_glpixelsx=: chkgl2 @: (('"',libjqt,'" glpixelsx >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glpolygon=: chkgl2 @: (('"',libjqt,'" glpolygon >',(IFWIN#'+'),' i *i i') cd (;#)@:<.)
qt_glrect=: chkgl2 @: (('"',libjqt,'" glrect >',(IFWIN#'+'),' i *i') cd <@:rpcinfinity)
qt_glrgb=: chkgl2 @: (('"',libjqt,'" glrgb >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glrgba=: chkgl2 @: (('"',libjqt,'" glrgba >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glsel=: chkgl2 @: (('"',libjqt,'" glsel >',(IFWIN#'+'),' i x')&cd)
qt_glsel2=: chkgl2 @: (('"',libjqt,'" glsel2 >',(IFWIN#'+'),' i *c') cd <@,)
qt_gltext=: chkgl2 @: (('"',libjqt,'" gltext >',(IFWIN#'+'),' i *c') cd <@,)
qt_gltextcolor=: chkgl2 @: (('"',libjqt,'" gltextcolor >',(IFWIN#'+'),' i')&cd bind '')
qt_gltextxy=: chkgl2 @: (('"',libjqt,'" gltextxy >',(IFWIN#'+'),' i *i') cd <@:<.)
qt_glwaitgl=: chkgl2 @: (('"',libjqt,'" glwaitgl >',(IFWIN#'+'),' i')&cd bind '')
qt_glwaitnative=: chkgl2 @: (('"',libjqt,'" glwaitnative >',(IFWIN#'+'),' i')&cd bind '')
qt_glwindoworg=: chkgl2 @: (('"',libjqt,'" glwindoworg >',(IFWIN#'+'),' i *i') cd <@:<.)

qt_glsetlocale=: chkgl2 @: (('"',libjqt,'" glsetlocale >',(IFWIN#'+'),' i *c') cd <@,@>)
qt_glpaint=: 3 : 0 "1
if. #stash_buf do. stash_buf=: 0$0 [ qt_glcmds stash_buf end.
('"',libjqt,'" glpaint >',(IFWIN#'+'),' i')&cd ''
0
)
qt_glpaintx=: 3 : 0 "1
if. #stash_buf do. stash_buf=: 0$0 [ qt_glcmds stash_buf end.
('"',libjqt,'" glpaintx >',(IFWIN#'+'),' i')&cd ''
0
)
qt_glqhandles=: 3 : 0"1
hs=. 3#2-2
chkgl2 ('"',libjqt,'" glqhandles >',(IFWIN#'+'),' i *x') cd <hs
hs
)
qt_glqtype=: 3 : 0"1
type=. 1#2-2
chkgl2 ('"',libjqt,'" glqtype >',(IFWIN#'+'),' i *i') cd <type
type
)
qt_glqwh=: 3 : 0"1
wh=. 2#2-2
chkgl2 ('"',libjqt,'" glqwh >',(IFWIN#'+'),' i *i') cd <wh
wh
)
qt_glqpixelm=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
shape=. 2#2-2
chkgl2 ('"',libjqt,'" glqpixelm >',(IFWIN#'+'),' i *i *i *i') cd y;shape;pix
shape$pix
)
qt_glqpixels=: 3 : 0"1
n=. */ 2{.2}.y
pix=. n#2-2
chkgl2 ('"',libjqt,'" glqpixels >',(IFWIN#'+'),' i *i *i') cd y;pix
pix
)
qt_glqextent=: 3 : 0"1
wh=. 2#2-2
chkgl2 ('"',libjqt,'" glqextent >',(IFWIN#'+'),' i *c *i') cd (,y);wh
wh
)
qt_glqextentw=: 3 : 0"1
y=. y,(LF~:{:y)#LF [ y=. ,y
w=. (+/LF=y)#2-2
chkgl2 ('"',libjqt,'" glqextentw >',(IFWIN#'+'),' i *c *i') cd y;w
w
)
qt_glqtextmetrics=: 3 : 0"1
tm=. 7#2-2
chkgl2 ('"',libjqt,'" glqtextmetrics >',(IFWIN#'+'),' i *i') cd tm
tm
)
qt_glsetbrush=: qt_glbrush @ qt_glrgb
qt_glsetpen=: qt_glpen @ ((1 1 [ qt_glrgb) :((2 {. (,&1)) qt_glrgb))
qt_glprint=: [:
qt_glprintmore=: [:
qt_glqprintpaper=: [:
qt_glqprintwh=: [:
qt_glemfclose=: [:
qt_glemfopen=: [:
qt_glemfplay=: [:
qt_glfile=: [:
qt_glroundr=: [:
glqmark=: 3 : 0"1
stash_state
)
glmark=: 3 : 0"1
stash_state=: 1
EMPTY
)
gltrash=: 3 : 0"1
b [ stash_state=: 0 [ stash_buf=: 0$0 [ b=. stash_buf
)
glbuf=: 4 : 0"0 1
assert. 1=stash_state
if. (*#y) *. 2 = 3!:0 y do. y=. a. i. y end.
if. glcmds_n_jgl2_ = x do.
  stash_buf=: stash_buf, y
else.
  stash_buf=: stash_buf, (2+#y),x,<.y
end.
EMPTY
)
pafc=: 2p1&|@{:@:(*.@(j./))

rfd=: *&(1p1%180)
dfr=: *&(180%1p1)
calcAngle=: ([: pafc _1 1 * -)"1
degree64=: 0.5 <.@:+ 64 * dfr
3 : 0''
if. IF64 do.
  ALPHA=: 0{_3 ic 0 0 0 255 255 255 255 255{a.
else.
  ALPHA=: 0{_2 ic 0 0 0 255{a.
end.
''
)
NOTALPHA=: 0{_2 ic 255 255 255 0{a.
ALPHARGB=: IF64{::_1;16bffffffff
parseFontname=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <@(-.&'"');._1 font
)
FontStyle=: ;:'regular bold italic underline strikeout'

parseFontSpec=: 3 : 0
'ns styleangle'=. 2 split parseFontname y
'face size'=. ns
size=. 12". size
style=. FontStyle i. tolower each styleangle
style=. <.+/2^<:(style ((> 0) *. <) #FontStyle) # style
if. 1 e. an=. ('angle'-:5&{.)&> styleangle do.
  degree=. 10%~ 0". 5}.>(an i. 1){styleangle
else.
  degree=. 0
end.
face;size;style;degree
)
dlws=: 3 : 0
y }.~ +/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
clws=: 3 : 0
+/ *./\ (y e. ' ')+.(y e. LF)+.(y e. TAB)
)
wdglshiftarg=: 3 : 0
if. (#wdglstr) = wdglptr=: wdglptr + clws wdglptr}. wdglstr do. '' return. end.
y=. wdglptr}.wdglstr
b=. y e. ' '
a=. y e. '*'
q=. 2| +/\ y e. '"'
d=. 2| +/\ y e. DEL
b=. b *. -.q+.d
a=. a *. -.q+.d
if. 1={.a do.
  z=. }.y
  wdglptr=: #wdglstr
elseif. (1={.d)+.(1={.q) do.
  p2=. 1+ (}.y) i. {.y
  z=. }.p2{.y
  wdglptr=: wdglptr+ p2+1
elseif. 1 e. b do.
  p2=. {.I.b
  z=. p2{.y
  wdglptr=: wdglptr+ 1+p2
elseif. do.
  z=. y
  wdglptr=: #wdglstr
end.
<z
)
wdglshiftargs=: 3 : 0
wdglptr=: 0 [ wdglstr=: y
z=. 0$<''
while. wdglptr < #wdglstr do. z=. z, wdglshiftarg'' end.
z
)

tors=: 3 : 0
(2{.y),(2{.y)+2}.y
)
glarc=: (qt_glarc`ja_glarc@.GL2Backend_jgl2_)`(glarc_n_jgl2_&glbuf)@.glqmark
glarcx=: (qt_glarcx`ja_glarcx@.GL2Backend_jgl2_)`(glarcx_n_jgl2_&glbuf)@.glqmark
glbrush=: (qt_glbrush`ja_glbrush@.GL2Backend_jgl2_)`(glbrush_n_jgl2_&glbuf)@.glqmark
glbrushnull=: (qt_glbrushnull`ja_glbrushnull@.GL2Backend_jgl2_)`(glbrushnull_n_jgl2_&glbuf)@.glqmark
glcapture=: (qt_glcapture`ja_glcapture@.GL2Backend_jgl2_)`(glcapture_n_jgl2_&glbuf)@.0:
glcaret=: (qt_glcaret`ja_glcaret@.GL2Backend_jgl2_)`(glcaret_n_jgl2_&glbuf)@.0:
glclear=: (qt_glclear`ja_glclear@.GL2Backend_jgl2_)`(glclear_n_jgl2_&glbuf)@.glqmark
glclip=: (qt_glclip`ja_glclip@.GL2Backend_jgl2_)`(glclip_n_jgl2_&glbuf)@.glqmark
glclipreset=: (qt_glclipreset`ja_glclipreset@.GL2Backend_jgl2_)`(glclipreset_n_jgl2_&glbuf)@.glqmark
glcmds=: (qt_glcmds`ja_glcmds@.GL2Backend_jgl2_)`(glcmds_n_jgl2_&glbuf)@.glqmark
glcursor=: (qt_glcursor`ja_glcursor@.GL2Backend_jgl2_)`(glcursor_n_jgl2_&glbuf)@.0:
glellipse=: (qt_glellipse`ja_glellipse@.GL2Backend_jgl2_)`(glellipse_n_jgl2_&glbuf)@.glqmark
glfill=: (qt_glfill`ja_glfill@.GL2Backend_jgl2_)`(glfill_n_jgl2_&glbuf)@.glqmark
glfont=: (qt_glfont`ja_glfont@.GL2Backend_jgl2_)`(glfont_n_jgl2_&glbuf)@.glqmark
glfontangle=: (qt_glfontangle`ja_glfontangle@.GL2Backend_jgl2_)`(glfontangle_n_jgl2_&glbuf)@.glqmark
glfontextent=: (qt_glfontextent`ja_glfontextent@.GL2Backend_jgl2_)`(glfontextent_n_jgl2_&glbuf)@.glqmark
gllines=: (qt_gllines`ja_gllines@.GL2Backend_jgl2_)`(gllines_n_jgl2_&glbuf)@.glqmark
glnodblbuf=: (qt_glnodblbuf`ja_glnodblbuf@.GL2Backend_jgl2_)`(glnodblbuf_n_jgl2_&glbuf)@.0:
glpaint=: (qt_glpaint`ja_glpaint@.GL2Backend_jgl2_)`(glpaint_n_jgl2_&glbuf)@.0:
glpaintx=: (qt_glpaintx`ja_glpaintx@.GL2Backend_jgl2_)`(glpaintx_n_jgl2_&glbuf)@.0:
glpen=: (qt_glpen`ja_glpen@.GL2Backend_jgl2_)`(glpen_n_jgl2_&glbuf)@.glqmark
glpie=: (qt_glpie`ja_glpie@.GL2Backend_jgl2_)`(glpie_n_jgl2_&glbuf)@.glqmark
glpixel=: (qt_glpixel`ja_glpixel@.GL2Backend_jgl2_)`(glpixel_n_jgl2_&glbuf)@.glqmark
glpixels=: (qt_glpixels`ja_glpixels@.GL2Backend_jgl2_)`(glpixels_n_jgl2_&glbuf)@.glqmark
glpixelsx=: (qt_glpixelsx`ja_glpixelsx@.GL2Backend_jgl2_)`(glpixelsx_n_jgl2_&glbuf)@.glqmark
glpolygon=: (qt_glpolygon`ja_glpolygon@.GL2Backend_jgl2_)`(glpolygon_n_jgl2_&glbuf)@.glqmark
glqextent=: (qt_glqextent`ja_glqextent@.GL2Backend_jgl2_)`(glqextent_n_jgl2_&glbuf)@.0:
glqextentw=: (qt_glqextentw`ja_glqextentw@.GL2Backend_jgl2_)`(glqextentw_n_jgl2_&glbuf)@.0:
glqpixelm=: (qt_glqpixelm`ja_glqpixelm@.GL2Backend_jgl2_)`(glqpixelm_n_jgl2_&glbuf)@.0:
glqpixels=: (qt_glqpixels`ja_glqpixels@.GL2Backend_jgl2_)`(glqpixels_n_jgl2_&glbuf)@.0:
glqtextmetrics=: (qt_glqtextmetrics`ja_glqtextmetrics@.GL2Backend_jgl2_)`(glqtextmetrics_n_jgl2_&glbuf)@.0:
glqtype=: (qt_glqtype`ja_glqtype@.GL2Backend_jgl2_)`(glqtype_n_jgl2_&glbuf)@.0:
glqwh=: (qt_glqwh`ja_glqwh@.GL2Backend_jgl2_)`(glqwh_n_jgl2_&glbuf)@.0:
glrect=: (qt_glrect`ja_glrect@.GL2Backend_jgl2_)`(glrect_n_jgl2_&glbuf)@.glqmark
glrgb=: (qt_glrgb`ja_glrgb@.GL2Backend_jgl2_)`(glrgb_n_jgl2_&glbuf)@.glqmark
glrgba=: (qt_glrgba`ja_glrgba@.GL2Backend_jgl2_)`(glrgba_n_jgl2_&glbuf)@.glqmark
glsel=: (qt_glsel`ja_glsel@.GL2Backend_jgl2_)`(glsel_n_jgl2_&glbuf)@.glqmark
glsel2=: (qt_glsel2`ja_glsel2@.GL2Backend_jgl2_)`(glsel2_n_jgl2_&glbuf)@.glqmark
glsetbrush=: (qt_glsetbrush`ja_glsetbrush@.GL2Backend_jgl2_)`(glsetbrush_n_jgl2_&glbuf)@.glqmark
glsetlocale=: (qt_glsetlocale`ja_glsetlocale@.GL2Backend_jgl2_)`(glsetlocale_n_jgl2_&glbuf)@.0:
glsetpen=: (qt_glsetpen`ja_glsetpen@.GL2Backend_jgl2_)`(glsetpen_n_jgl2_&glbuf)@.0:
gltext=: (qt_gltext`ja_gltext@.GL2Backend_jgl2_)`(gltext_n_jgl2_&glbuf)@.glqmark
gltextcolor=: (qt_gltextcolor`ja_gltextcolor@.GL2Backend_jgl2_)`(gltextcolor_n_jgl2_&glbuf)@.glqmark
gltextxy=: (qt_gltextxy`ja_gltextxy@.GL2Backend_jgl2_)`(gltextxy_n_jgl2_&glbuf)@.glqmark
glwaitgl=: (qt_glwaitgl`ja_glwaitgl@.GL2Backend_jgl2_)`(glwaitgl_n_jgl2_&glbuf)@.glqmark
glwaitnative=: (qt_glwaitnative`ja_glwaitnative@.GL2Backend_jgl2_)`(glwaitnative_n_jgl2_&glbuf)@.glqmark
glwindoworg=: (qt_glwindoworg`ja_glwindoworg@.GL2Backend_jgl2_)`(glwindoworg_n_jgl2_&glbuf)@.glqmark
glprint=: qt_glprint`ja_glprint@.GL2Backend_jgl2_
glprintmore=: qt_glprintmore`ja_glprintmore@.GL2Backend_jgl2_
glqhandles=: qt_glqhandles`ja_glqhandles@.GL2Backend_jgl2_
glqprintpaper=: qt_glqprintpaper`ja_glqprintpaper@.GL2Backend_jgl2_
glqprintwh=: qt_glqprintwh`ja_glqprintwh@.GL2Backend_jgl2_
glemfclose=: qt_glemfclose`ja_glemfclose@.GL2Backend_jgl2_
glemfopen=: qt_glemfopen`ja_glemfopen@.GL2Backend_jgl2_
glemfplay=: qt_glemfplay`ja_glemfplay@.GL2Backend_jgl2_
glfile=: qt_glfile`ja_glfile@.GL2Backend_jgl2_
glroundr=: qt_glroundr`ja_glroundr@.GL2Backend_jgl2_
finalize_jgl2_^:(3=(4!:0)@<) 'finalize_jgl2_'
