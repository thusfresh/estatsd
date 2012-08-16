-module(demo_eunit).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

demo_with_time_test_() ->
    {setup, local,
        fun() ->
            meck:new(emon_utils),
            meck:new(estatsd),
            meck:expect(emon_utils, get_key_string, fun(A,B,C) -> "dummy" end),
            meck:expect(estatsd, timing, fun(A,B) -> ok end)
        end,
        fun(_) ->
            true = meck:validate(emon_utils),       %actually called
            true = meck:validate(estatsd),
            meck:unload(emon_utils),
            meck:unload(estatsd)
        end,
        fun(_) ->
            [
                ?_assertMatch({ok, demo}, demo_with_time:test(demo))  %still work as expected
            ]
        end
    }.


demo_without_time_test_() ->
    {setup, local,
        fun() ->
            ok
        end,
        fun(_) ->
            ok
        end,
        fun(_) ->
            [
                ?_assertMatch({ok, demo}, demo_without_time:test(demo))  %still work as expected
            ]
        end
    }.