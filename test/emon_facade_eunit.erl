-module(emon_facade_eunit).

-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

increment_test_() ->
    {setup,
        fun () ->
                {ok, Fapp}=elibs_application:start(erl_monitoring),
                [Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:increment("key", 1, 1))
                ]
        end
    }.

decrement_test_() ->
    {setup,
        fun () ->
                {ok, Fapp}=elibs_application:start(erl_monitoring),
                [Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:decrement("key", 1, 1))
                ]
        end
    }.

timing_test_() ->
    {setup,
        fun () ->
                {ok, Fapp}=elibs_application:start(erl_monitoring),
                [Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:timing("key", 198123123))
                ]
        end
    }.

tc_test_() ->
    {setup,
        fun () ->
                {ok, Fapp}=elibs_application:start(erl_monitoring),
                [Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(myresult, emon_facade:tc("key", fun () -> myresult end))
                ]
        end
    }.


