.PHONY: deps test
REBAR := rebar

all: deps compile

setup: 

# Compiles the whole application
compile:
	@${REBAR} compile
	@${REBAR} skip_deps=true xref | grep -v "is unused export (Xref)"

getdeps:
	./scripts/verify-dependency-tags && \
	${REBAR} get-deps

# Gets the dependencies to the deps folder. This is necessary for compile to succeed.
deps:
	./scripts/verify-dependency-tags && \
	${REBAR} get-deps && ${REBAR} compile

# Cleans any generated files from the repo (except dependencies)
clean:
	@-rm -f erl_crash.dump;
	${REBAR} clean
	rm -f test/ebin/*
	rm -f doc/*.html doc/*.css doc/*.png doc/edoc-info

# Cleans any downloaded dependencies
distclean: clean
	${REBAR} delete-deps

# Runs every test suite under test/ abd generates an html page with detailed info about test coverage
test: all
	${REBAR} skip_deps=true eunit

# Generates the edoc documentation and places it under doc/ .
docs:
	${REBAR} skip_deps=true doc

# While developing with vi, :!make dialyzer | grep '%:t' can be used to run dialyzer in the current file
dialyzer: clean compile
	@dialyzer -Wno_return -Wno_opaque -c ebin
	
typer: compile
	typer --show-exported -I include -I ../ src/*.erl
