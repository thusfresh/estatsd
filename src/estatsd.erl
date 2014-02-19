-module(estatsd).

-include("defs.hrl").

-export([
         gauge/2,
         increment/1, increment/2, increment/3,
         decrement/1, decrement/2, decrement/3,
         timing/2
        ]).

-define(SERVER, estatsd_server).

% Convenience: just give it the now() tuple when the work started
timing(Key, StartTime = {_,_,_}) ->
    Dur = erlang:round(timer:now_diff(os:timestamp(), StartTime)/1000),
    timing(Key,Dur);

% Log timing information, ms
timing(Key, Duration) when is_integer(Duration) ->
    gen_server:cast(?SERVER, {timing, Key, Duration});

timing(Key, Duration) ->
    gen_server:cast(?SERVER, {timing, Key, erlang:round(Duration)}).

% Increments one or more stats counters
-spec increment(string() | binary() | atom()) -> ok.
increment(Key) ->
    % Note that this will fail if the value in the ETS table
    % is NOT an integer. So you shouldn't mix samplesizes or amounts
    % Assuming you only update a key in one place, this is fine.
    % To keep it safer, we only optimize increment/1, which is most
    % commonly used.

    % catch is required, because initially the key will not be set
    % and after flushing it is also removed.
    case (catch ets:update_counter(?ETS_TABLE_COUNTERS, Key, 1)) of
        {'EXIT',{badarg, _}} ->
            increment(Key,1,1);
        _ ->
            ok
    end.
increment(Key, Amount) ->
    increment(Key, Amount, 1).
increment(Key, Amount, Sample) when Sample >= 0, Sample =< 1 ->
    gen_server:cast(?SERVER, {increment, Key, Amount, Sample}).

decrement(Key) ->
    decrement(Key, 1, 1).
decrement(Key, Amount) ->
    decrement(Key, Amount, 1).
decrement(Key, Amount, Sample) ->
    increment(Key, 0 - Amount, Sample).

% Sets a gauge value
gauge(Key, Value) when is_number(Value) ->
    gen_server:cast(?SERVER, {gauge, Key, Value}).
