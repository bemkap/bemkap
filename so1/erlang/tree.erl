-module(tree).
-export([ex/0]).
-record(tree,{node,left=null,right=null}).

ex()->#tree{node=50,left=#tree{node=30,left=#tree{node=20},right=#tree{node=40}},right=#tree{node=90,right=#tree{node=100}}}.
