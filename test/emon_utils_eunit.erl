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
    Expected1=elibs_string:format("development.team.app.metric.submetric1.submetric2.~s", [Node]),
    Expected2=elibs_string:format("myenv.team.app.metric.submetric1.submetric2.~s", [Node]),
    [
        ?_assertEqual(Expected1, emon_utils:get_key_string("team", "app", ["metric", "submetric1", "submetric2"])),
        ?_assertEqual(Expected2, emon_utils:get_key_string("myenv", "team", "app", ["metric", "submetric1", "submetric2"]))
    ].

get_key_string_with_env_test_() ->
    {setup,
        fun () ->
                {ok, F} = elibs_application:set_env(erlang_monitoring, environment, "myenv"),
                [F]
        end,
        fun (Cleanup) ->
                lists:foreach(fun (F) -> F() end, Cleanup)
        end,
        fun (_) ->
                Node=emon_utils:statsnode(),
                Expected=elibs_string:format("myenv.team.app.metric.submetric1.submetric2.~s", [Node]),
                [
                    ?_assertEqual(Expected, emon_utils:get_key_string("team", "app", ["metric", "submetric1", "submetric2"]))
                ]
        end
    }.

