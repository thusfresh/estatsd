-module(emon_app).

-behaviour(application).

-export([start/0]).

%% Application callbacks
-export([start/2, stop/1]).

%%--------------------------------------------------------------------
%% API
%%--------------------------------------------------------------------


%%--------------------------------------------------------------------
%% @doc Starts this application
-spec start() -> ok.
%% @end
%%--------------------------------------------------------------------
start() ->
    application:start(erl_monitoring).

%%--------------------------------------------------------------------
%% Application callbacks
%%--------------------------------------------------------------------

%% @private
-spec start(normal | {takeover,node()} | {failover,node()}, term()) -> {ok, pid()}.

start(_Type, _StartArgs) ->
    elibs_application:load_extra_config(),
    application:stop(estatsd),
    ok=application:start(estatsd),
    emon_sup:start_link().

%% @private
-spec stop(term()) -> ok.

stop(_State) ->
    ok.

%%--------------------------------------------------------------------
%% Internal functions
%%--------------------------------------------------------------------


