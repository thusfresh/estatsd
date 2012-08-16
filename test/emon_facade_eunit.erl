-module(emon_facade_eunit).

-include_lib("eunit/include/eunit.hrl").
-include("monitoring.hrl").

-compile(export_all).

increment_test_() ->
    {setup,
        fun () ->
                error_logger:tty(false),
                {ok, Ftwig} = elibs_application:set_env(twig, level, twig_util:level(crit)),
                {ok, Fapp} = elibs_application:start(erl_monitoring),
                [Ftwig, Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:increment("key", 1, 1)),
                    ?_assertEqual(ok, ?INCREMENT("key")),
                    ?_assertEqual(ok, ?INCREMENT("key", 1)),
                    ?_assertEqual(ok, ?INCREMENT("key", 1, 1))
                ]
        end
    }.

decrement_test_() ->
    {setup,
        fun () ->
                error_logger:tty(false),
                {ok, Ftwig} = elibs_application:set_env(twig, level, twig_util:level(crit)),
                {ok, Fapp} = elibs_application:start(erl_monitoring),
                [Ftwig, Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:decrement("key", 1, 1)),
                    ?_assertEqual(ok, ?DECREMENT("key")),
                    ?_assertEqual(ok, ?DECREMENT("key", 1)),
                    ?_assertEqual(ok, ?DECREMENT("key", 1, 1))
                ]
        end
    }.

timing_test_() ->
    {setup,
        fun () ->
                error_logger:tty(false),
                {ok, Ftwig} = elibs_application:set_env(twig, level, twig_util:level(crit)),
                {ok, Fapp} = elibs_application:start(erl_monitoring),
                [Ftwig, Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(ok, emon_facade:timing("key", 198123123)),
                    ?_assertEqual(ok, ?TIMING("key", 198123123))
                ]
        end
    }.

tc_test_() ->
    {setup,
        fun () ->
                error_logger:tty(false),
                {ok, Ftwig} = elibs_application:set_env(twig, level, twig_util:level(crit)),
                {ok, Fapp} = elibs_application:start(erl_monitoring),
                [Ftwig, Fapp]
        end,
        fun (L) ->
                lists:foreach(fun (F) -> F() end, L)
        end,
        fun (_) ->
                [
                    ?_assertEqual(myresult, emon_facade:tc("key", fun () -> myresult end)),
                    ?_assertEqual(myresult, ?MEASURE("key", fun () -> myresult end)),
                    ?_assertThrow({myerror, myreason}, emon_facade:tc("key", fun () -> throw({myerror, myreason}) end))
                ]
        end
    }.

