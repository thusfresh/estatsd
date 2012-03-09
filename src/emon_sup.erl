-module(emon_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type, StartOpts), {I, {I, start_link, StartOpts}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervision tree.
-spec start_link() -> {ok, pid()}.
%% @end
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

%% @private
-spec init([]) -> {ok, {{one_for_one, 5, 10}, []}}.

init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.
