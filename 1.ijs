rx=: (1 0 0),(0,cos,-@sin),:(0,sin,cos)
ry=: (cos,0:,sin),(0 1 0)"_,:(-@sin,0:,cos)
rz=: (cos,-@sin,0:),(sin,cos,0:),:(0 0 1)"_
mp=: +/ .*
R=: ~.<.0.5+>,>mp&.>/&.>{<"2&.>(rx"0;ry"0;rz"0)0 1r2p1 1p1 3r2p1