-module(dest).
-include("struct.hrl").
-export([start/1,stop/0]).
-export([destLoop/3,senderLoop/1,deliver/0,monitor/1]).
-export([send/1]).

start(Seq)->
    {sequencer,Seq}!{query,self()},
    receive 
        {ok,SeqNum}->
            register(dest,spawn(?MODULE,destLoop,[SeqNum,dict:new(),0])),
            register(sender,spawn(?MODULE,senderLoop,[Seq])),
            register(deliver,spawn(?MODULE,deliver,[])),
            spawn(?MODULE,monitor,[Seq]),
            ok
    end.

stop()->
    dest!fin,
    deliver!fin,
    sender!fin,
    unregister(deliver),
    unregister(dest),
    unregister(sender).

send(Msg)->
    sender!#send{msg=Msg,sender=self()},
    ok.

monitor(Seq)->
    monitor_node(Seq,true),
    receive {nodedown,Seq}->stop(),
                            monitor_node(Seq,false),
                            io:format("error_no_sequencer~n",[])
    end.

senderLoop(Seq)->
    receive
        fin->exit(normal);
        M when is_record(M,send)->
            {sequencer,Seq}!M,
            senderLoop(Seq);
        _->io:format("Recvcualca~n")
    end.

deliver()->
    receive
        fin->exit(normal);
        M->io:format("Deliver:~p~n",[M]),
           deliver()
    end.

destLoop(NDel,Pend,TO)->
    receive
        fin->exit(normal);
        Data when is_record(Data,msg)->
            destLoop(NDel,dict:append(Data#msg.sn,#send{msg=Data#msg.msg,sender=Data#msg.sender},Pend),0)
    after TO->case dict:find(NDel,Pend) of
                  {ok,Msg}->
                      deliver!Msg,
                      destLoop(NDel+1,Pend,0);
                  error->destLoop(NDel,Pend,infinity)
              end
    end.
