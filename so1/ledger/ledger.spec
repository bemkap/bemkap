{node,a,'a@archlinux.fibertel.com.ar'}.
{node,b,'b@archlinux.fibertel.com.ar'}.
{node,c,'c@archlinux.fibertel.com.ar'}.
{node,d,'d@archlinux.fibertel.com.ar'}.

{init,[a,b,c,d],[{node_start,[{monitor_master,true}]}]}.

{alias,ledger,"./src/"}.

{logdir,all_nodes,"./logs/"}.
{logdir,master,"./logs/"}.

{suites,[a,b,c,d],ledger,all}.
