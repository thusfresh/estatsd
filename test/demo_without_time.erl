-module(demo_without_time).
-undef(ENABLE_TIMER).           %make sure it is not set before including timer!
-include("monitoring.hrl").
-export([test/1]).

%%--------------------------------------------------------------------
%% @doc
-spec test(atom()) -> {ok, atom()}.
%% @end
%%--------------------------------------------------------------------
?TIME(erl_monitoring, test).
test(Any) ->
    {ok, Any}.

