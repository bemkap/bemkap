require'regex'
I=: (,&' 0 1') each 'b' fread '~temp/input.txt'
rh=: '\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] Guard #(\d+) (?:begins|ends) shift'
rw=: '\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] wakes up 0 (1)'
rf=: '\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] falls asleep (0) 1'
mh=: ([: }. rh&(rxmatch rxfrom ])) L: 0 ] I
mw=: ([: }. rw&(rxmatch rxfrom ])) L: 0 ] I
mf=: ([: }. rf&(rxmatch rxfrom ])) L: 0 ] I
P=: /:~>,(#~ a:&~:)"1 > each ". L: 0 mh,.mw,.mf