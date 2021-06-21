-record(handler,{onDeliver=fun(X)->io:format("~p~n",[X])end,
                 onNodedown=fun(X)->X end}).

%% -define(DEBUG(STR,ARGS),io:format("[~p]"++STR,[node()|ARGS])).
-define(DEBUG(STR,ARGS),nop).
-define(SLEEP,0).
%% -define(SLEEP,10000).
