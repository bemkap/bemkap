-module(ledger_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0,groups/0,node_run/1,is_ordered/1,init_per_group/2,end_per_group/2]).

all()->[{group,session}].

groups()->[{session,[],[{group,nodes},is_ordered]},
           {nodes,[],[node_run]}].

init_per_group(session,Config)->
    ledger:start(),
    Config;
init_per_group(nodes,Config)->
    net_adm:ping('a@archlinux.fibertel.com.ar'),
    timer:sleep(500),
    Config.

end_per_group(nodes,_)->ok;
end_per_group(session,_)->
    ledger:stop(),
    ok.

node_run(_)->
    ledger:append(1).

is_ordered(_)->
    [1,1]=ledger:get().
