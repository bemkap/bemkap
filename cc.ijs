A=: ?5 5$2 NB. matrix of boolean
C=: _1 0,1 0,0 _1,:0 1 NB. neighbours relative coordinates
g0=: *./@:(>:&0) NB. y>0 0
ls=: *./@:(<&($A)) NB. y<$A
on=: (<@(|~ $) { ])&A NB. 1=y{A. y is modulo $A
fi=: [: (#~(on*.g0*.ls)"1) [: ,/ +"1/&C NB. conditions on neighbourhood
f1=: $ #: i.&1@:, NB. first 1 coordinates
ap=: [: ([: ~. (,fi))^:_ ,:@f1 NB. all paths
co=: #@:ap -: +/@:, NB. totally connected

B=: 5 5$1 2 0 0 0 0 0 0 3 0 0 3 2 0 0 0 4 0 0 0 0 0 0 1 4
wc=: (#~ 0=B&({~)) , { ;~ i.#B NB. white coordinates