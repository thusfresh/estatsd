-module(estatsd_benchmark).

-export([benchmark/2]).

%% Idea : start estatsd, wait 1 second, then run 10 keys insert 100 items each
%% Disable vmstats (because of how it can influence stats)

benchmark(CountKeys, CountRequests) ->
	Port = 2993,
	estatsd_receiver:start(Port),
	application:set_env(estatsd, vm_metrics, false),
	application:set_env(estatsd, graphite_port, Port),
	application:set_env(estatsd, flush_interval, 4000),
	ok = application:start(estatsd),
	Keys = [ lists:flatten(io_lib:format("dummmy.key.~p.demo", [Index])) || Index <- lists:seq(0,CountKeys-1)],
	get_reductions(),
	[ estatsd:increment(lists:nth((Counter rem CountKeys)+1, Keys)) || Counter <- lists:seq(1, CountRequests)],
	timer:sleep(4500),
	Reductions = get_reductions(),
	io:format("Reductions used: ~p\n",[Reductions]),
	ok = application:stop(estatsd).

get_reductions() ->
	{_TotalReductions, Reductions} = erlang:statistics(reductions),
    Reductions.
