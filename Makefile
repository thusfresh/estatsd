.PHONY: test

REBAR=rebar
all: compile

compile:
	${REBAR} compile

clean:
	${REBAR} clean

test:
	${REBAR} compile eunit

docs:
	${REBAR} doc

# Runs estatsd erlang application.
go:
	erl -pa ebin -s estatsd_app -config conf/estatsd

# For testing purposes starts a dummy tcp server based on netcat (nc).
graphite:
	./priv/graphite.sh
