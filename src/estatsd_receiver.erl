%@doc Helper module to receive stats from Graphite.
-module(estatsd_receiver).

-export([start/1, server/1]).
-define(ACCEPTORS, 2).

start(LPort) ->
    case gen_tcp:listen(LPort,[{active, false},{packet, line}]) of
        {ok, ListenSock} ->
            start_servers(?ACCEPTORS,ListenSock),
            {ok, Port} = inet:port(ListenSock),
            Port;
        {error,Reason} ->
            {error,Reason}
    end.

start_servers(0,_) ->
    ok;
start_servers(Num,LS) ->
    spawn(?MODULE,server,[LS]),
    start_servers(Num-1,LS).

server(LS) ->
    case gen_tcp:accept(LS) of
        {ok,S} ->
            loop(S),
            server(LS);
        Other ->
            io:format("accept returned ~w - goodbye!~n",[Other]),
            ok
    end.

loop(S) ->
    inet:setopts(S,[{active,once}]),
    receive
        {tcp,S,Data} ->
            process(Data),
            loop(S);
        {tcp_closed,S} ->
            io:format("Socket ~w closed [~w]~n",[S,self()]),
            ok
    end.


process(Data) ->
    io:format("Received: ~p\n", [Data]).
