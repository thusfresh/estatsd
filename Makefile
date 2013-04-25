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
# For testing purposes you can also run "./priv/graphite.sh" alongside it as a server.
go:
	erl -pa ebin -s estatsd_app -config conf/estatsd
