data=: ". ; cutLF (0 : 0)
('slashdot';'USA';'yes';18;'None'),
('google';'France';'yes';23;'Premium'),
('digg';'USA';'yes';24;'Basic'),
('kiwitobes';'France';'yes';23;'Basic'),
('google';'UK';'no';21;'Premium'),
('(direct)';'New Zealand';'no';12;'None'),
('(direct)';'UK';'no';21;'Basic'),
('google';'USA';'no';24;'Premium'),
('slashdot';'France';'yes';19;'None'),
('digg';'USA';'no';18;'None'),
('google';'UK';'no';18;'None'),
('kiwitobes';'UK';'no';19;'None'),
('digg';'New Zealand';'yes';12;'Basic'),
('slashdot';'UK';'no';21;'None'),
('google';'UK';'yes';18;'Basic'),:
'kiwitobes';'France';'yes';19;'Basic'
)

uniquecounts=: [: #/.~ {:"1

gini=: [: +/^:2 [: (* 1&(]\.)) uniquecounts % #
entropy=: [: +/ [: (- * 2&^.) uniquecounts % #

tree=: 1 : 0
A=. 0$0
for_i. i.#{.y do.
  B=. 0$0
  for_c. ~.i {"1 y do.
    B=. B,+/"1 ((u * (#y) % #)/.~ i&(c -: {)"1) y
  end.
  A=. A,<B
end.A
)
tree=: 1 : '|:@:(-:"0/"1~@:|: +/"1@:((u * (#y) % #)/./"1 _) ]) y'