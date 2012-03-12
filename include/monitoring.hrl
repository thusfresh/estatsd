
-define(INCREMENT(Key), emon_facade:increment(Key, 1, 1)).
-define(INCREMENT(Key, Amount), emon_facade:increment(Key, Amount, 1)).
-define(INCREMENT(Key, Amount, SampleRate), emon_facade:increment(Key, Amount, SampleRate)).

-define(DECREMENT(Key), emon_facade:decrement(Key, 1, 1)).
-define(DECREMENT(Key, Amount), emon_facade:decrement(Key, Amount, 1)).
-define(DECREMENT(Key, Amount, SampleRate), emon_facade:decrement(Key, Amount, SampleRate)).

-define(TIMING(Key, Duration), emon_facade:timing(Key, Duration)).

-define(MEASURE(Key, Fun), emon_facade:tc(Key, Fun)).
