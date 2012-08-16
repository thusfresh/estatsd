-module(demo_with_time).
-define(ENABLE_TIMER, true).    %enable before including monitoring!
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

