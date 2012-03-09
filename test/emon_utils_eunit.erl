-module(emon_utils_eunit).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

statsnode_test_() ->
    Node=emon_utils:statsnode(),
    [
        ?_assertMatch(L when is_list(L), Node),
        ?_assert(Node/=""),
        ?_assertEqual(0, string:str(Node, "@"))
    ].

get_key_string_test_() ->
    Node=emon_utils:statsnode(),
    Expected=elibs_string:format("env.team.app.metric.submetric1.submetric2.~s", [Node]),
    [
        ?_assertEqual(Expected, emon_utils:get_key_string("env", "team", "app", ["metric", "submetric1", "submetric2"]))
    ].

