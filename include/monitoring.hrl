-ifndef(DECORATOR).
    -compile([{parse_transform, elibs_decorator}]).
    -define(DECORATOR, true).
-endif.

-define(INCREMENT(Key), emon_facade:increment(Key, 1, 1)).
-define(INCREMENT(Key, Amount), emon_facade:increment(Key, Amount, 1)).
-define(INCREMENT(Key, Amount, SampleRate), emon_facade:increment(Key, Amount, SampleRate)).

-define(DECREMENT(Key), emon_facade:decrement(Key, 1, 1)).
-define(DECREMENT(Key, Amount), emon_facade:decrement(Key, Amount, 1)).
-define(DECREMENT(Key, Amount, SampleRate), emon_facade:decrement(Key, Amount, SampleRate)).

-define(TIMING(Key, Duration), emon_facade:timing(Key, Duration)).

-define(MEASURE(Key, Fun), emon_facade:tc(Key, Fun)).

%%====================================================================
%% Spec:
%%      ?MEASURE().    
%%====================================================================
%% 
-ifdef(TESTING).
    -ifdef(ENABLE_TIMER).
        -define(TIME(AppName, FuncName), -decorate({emon_facade, tc_pt, {AppName, FuncName}})).
    -else.
        -define(TIME(AppName, FuncName), -decorate({})).
    -endif.
-else.
    -define(TIME(AppName, FuncName), -decorate({emon_facade, tc_pt, {AppName, FuncName}})).
-endif.