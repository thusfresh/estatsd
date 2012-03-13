-module(emon_utils).

-export([statsnode/0, get_key_string/3, get_key_string/4]).

%%--------------------------------------------------------------------
%% @doc Returns a string like ErlangNodeName.ShortHostName
-spec statsnode() -> string().
%% @end
%%--------------------------------------------------------------------
statsnode() ->
    N=atom_to_list(node()),
    [Nodename, Hostname]=string:tokens(N, "@"),
    ShortHostName=lists:takewhile(fun (X) -> X /= $. end, Hostname),
    string:join([Nodename, ShortHostName], ".").

%%--------------------------------------------------------------------
%% @doc Returns a valid keyname according to spilgames naming rules for monitoring. The 'Environment' part of the key will
%% be read from configuration and defaulted to 'development'
-spec get_key_string(string() | atom(), string() | atom(), [string() | atom()]) -> string().
%% @end
%%--------------------------------------------------------------------
get_key_string(Team, Application, MetricChain) when MetricChain /= [] ->
    Environment=elibs_application:get_env(erlang_monitoring, environment, "development"),
    get_key_string(Environment, Team, Application, MetricChain).


%%--------------------------------------------------------------------
%% @doc Returns a valid keyname according to spilgames naming rules for monitoring.
-spec get_key_string(string() | atom(), string() | atom(), string() | atom(), [string() | atom()]) -> string().
%% @end
%%--------------------------------------------------------------------
get_key_string(Environment, Team, Application, MetricChain) when MetricChain /= [] ->
    MetricName=string:join([elibs_types:to_type(str, M, "unknown") || M <- MetricChain], "."),
    elibs_string:format("~s.~s.~s.~s.~s",
        [elibs_types:to_type(str,Environment, "unknown"), elibs_types:to_type(str, Team, "unknown"),
            elibs_types:to_type(str, Application, "unknown"), MetricName, statsnode()]
    ).

