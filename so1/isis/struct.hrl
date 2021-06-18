-record(handler,{onDeliver=fun(X)->io:format("~p~n",[X])end,
                 onNodedown=fun(X)->{error,X}end}).
